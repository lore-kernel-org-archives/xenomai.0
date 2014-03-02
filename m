Message-ID: <53137581.5060600@xenomai.org>
Date: Sun, 02 Mar 2014 19:16:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <530D0205.9050406@xenomai.org>
 <CAEbDrgmwch94crHAcrbJDj9MxaiBNaYeLH2U9NtS0tuJKmdDDw@mail.gmail.com>
 <530D0BBD.6070704@xenomai.org>
 <CAK4EZFR_L+=-LtSVHkvZ36rPOA8ViVboB9M9rf4Yqk=crfBotw@mail.gmail.com>
 <CAEbDrgk=yrGq8KdpdN8e7RtO7qUpWTtwRXhrg0A0=KbDjqoDng@mail.gmail.com>
 <530D2C92.9010607@xenomai.org>
 <CAEbDrgkWZqSxjCUfjR3YCp=YOzh1r-=YC6Wyr-Jvk9d7JYEcmQ@mail.gmail.com>
 <530E6159.4050204@xenomai.org>
 <CAEbDrgmo==15Zar2X=yz=wBL3pJ4DOiqKy2xx43UPxuu6_5LhA@mail.gmail.com>
 <530F17EC.6020204@xenomai.org>
 <CAEbDrgnq46OJ6bi1FCQmC8JBWhSA6o=M9K=fg4x4hq3JpwcBjw@mail.gmail.com>
 <530F9CA2.2040601@xenomai.org>
 <CAEbDrgmLq08Xq5Cgt7oXX3koQDr+HVx_JS-7Nn_pC53rmTTV-g@mail.gmail.com>
 <531075E7.7060107@xenomai.org>
 <CAEbDrgmQNRjaTEm5TvM93Yy3k+fa+QRETFzXdM3bz8=-N15DPQ@mail.gmail.com>
 <53134A2E.1000406@xenomai.org>
 <CAEbDrgmB4vZ0TPrD2-_-vR8bDwYXLKL2fMdNzFZWGsoiK9ZBDQ@mail.gmail.com>
In-Reply-To: <CAEbDrgmB4vZ0TPrD2-_-vR8bDwYXLKL2fMdNzFZWGsoiK9ZBDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RaspberryPi kernel 3.8 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gregory Dymarek <gregd72002@gmail.com>
Cc: xenomai@xenomai.org

On 03/02/2014 06:26 PM, Gregory Dymarek wrote:
> So I started from scratch, have not used any xenomai/ipipe patches. But
> used the same .config.
> As a result all worked fine. The USB device is getting initialized
> correctly.
> 
> So the current situation is that xenomai does work on 3.2 but does not on
> 3.8 because of some USB driver issues.
> I diff'ed the code for dwc_otg_hcd_handle_intr and this has changed.
> What is intriguing:
> https://github.com/raspberrypi/linux/blob/rpi-3.8.y/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c#L530
> 
> // We should be OK doing this because the common interrupts should already
> have been serviced
> 
> So I removed all the DEBUG code from this function, but this did not help
> either. Not sure if my test is valid in here.

If the driver relies on FIQ to work (which is a bad idea with Xenomai, 
as it will cause an increase in latencies), the following construction:


local_irq_save(flags);
local_fiq_disable();

/* do something */

local_irq_restore(flags);

Will mask the FIQ with CONFIG_IPIPE whereas local_irq_restore unmasks 
both the IRQ and FIQ without CONFIG_IPIPE. 

So, as a last try before giving up, could you try the following patch?

diff --git a/drivers/usb/host/dwc_common_port/dwc_common_linux.c b/drivers/usb/host/dwc_common_port/dwc_common_linux.c
index 0812d3a..6d01261 100644
--- a/drivers/usb/host/dwc_common_port/dwc_common_linux.c
+++ b/drivers/usb/host/dwc_common_port/dwc_common_linux.c
@@ -585,6 +585,7 @@ void DWC_MODIFY_REG32(uint32_t volatile *reg, uint32_t clear_mask, uint32_t set_
 	local_irq_save(flags);
 	local_fiq_disable();
 	writel((readl(reg) & ~clear_mask) | set_mask, reg);
+	local_fiq_enable();
 	local_irq_restore(flags);
 }
 
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c b/drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c
index b5a007d..10eead2 100644
--- a/drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c
+++ b/drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c
@@ -1354,6 +1354,7 @@ static inline uint32_t dwc_otg_read_common_intr(dwc_otg_core_if_t * core_if, gin
 		gintmsk.d32 |= gintmsk_common.d32;
 		gintsts_saved.d32 &= ~gintmsk_common.d32;
 		reenable_gintmsk->d32 = gintmsk.d32;
+		local_fiq_enable();
 		local_irq_restore(flags);
 	}
 
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c b/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
index 7d521d9..86d9cbe 100644
--- a/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
+++ b/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
@@ -97,6 +97,7 @@ void notrace _fiq_print(FIQDBG_T dbg_lvl, char *fmt, ...)
 		memcpy(buffer + wptr, text, 16);
 		wptr = (wptr + 16) % sizeof(buffer);
 	}
+	local_fiq_enable();
 	local_irq_restore(flags);
 }
 #endif


-- 
                                                                Gilles.

