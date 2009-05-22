Message-ID: <4A165F3A.30300@domain.hid>
Date: Fri, 22 May 2009 10:15:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20090521234047.12080x4n89e96wdc@domain.hid>
In-Reply-To: <20090521234047.12080x4n89e96wdc@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on ARM integrator platform
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gildas Bayard <gildas.bayard@domain.hid>
Cc: xenomai@xenomai.org

Gildas Bayard wrote:
> Hello,
> 
> I've got problems compiling a xenomai kernel for the arm integrator platform.
> I've tried linux 2.6.26, 2.6.27 and 2.6.28. The kernel patches are  
> applied smoothly but compilation gives me undefined references kind of  
> errors.
> 
> For the 2.6.28 it says:
> arch/arm/kernel/built-in.o: In function `__ipipe_grab_irq':
> io.c:(.text+0x5840): undefined reference to `__ipipe_mach_demux_irq'
> arch/arm/kernel/built-in.o: In function `ipipe_get_sysinfo':
> io.c:(.text+0x5b14): undefined reference to `__ipipe_mach_ticks_per_jiffy'
> arch/arm/mach-integrator/built-in.o: In function `__ipipe_mach_release_timer':
> pci.c:(.text+0x580): undefined reference to `__ipipe_mach_ticks_per_jiffy'
> arch/arm/xenomai/built-in.o: In function `rthal_timer_release':
> hal.c:(.text+0x46c): undefined reference to `__ipipe_mach_ticks_per_jiffy'
> arch/arm/xenomai/built-in.o: In function `rthal_timer_request':
> hal.c:(.text+0x534): undefined reference to `__ipipe_mach_ticks_per_jiffy'
> 
> Searching on the net I've found someone with a similar problem and the  
> answer for him was that it's board was not supported.
> But it seemed to me that ARM integrator was advertised as fully supported.
> Could someone give me versions for xenomai/linux that compile well for  
> the integrator board?

Only integrator cp is supported, are you sure you are not trying to
select integrator ap ?

-- 
					    Gilles.

