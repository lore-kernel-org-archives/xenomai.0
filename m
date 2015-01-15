Date: Thu, 15 Jan 2015 12:20:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150115112013.GD22199@hermes.click-hack.org>
References: <9BA84827B30CBE4996725F98F7DC9123428FAE5D@SMExchange01.siebmeyer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9BA84827B30CBE4996725F98F7DC9123428FAE5D@SMExchange01.siebmeyer.org>
Subject: Re: [Xenomai] arch arm no pci irq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?SMOkbmVsLUJhYXMs?= Alexander <alexander.haenel-baas@sieb-meyer.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Jan 15, 2015 at 11:09:11AM +0000, Hänel-Baas, Alexander wrote:
> Hi
> 
> I have the kernel 3.14.17 with xenomai 2.6.4 and my own pci-fpga card that generates interrupts.
> 
> When i registry my pci irq with rt_intr_create() than i get the following warning and no irq was fired.
> 
> The same configuration under x86 arch works fine.
> 
> Dmesg output:
> sm36500001: ioctl(SM36500001_IOCGIRQ) =  385 <- this is the irq number that i get after i called pci_enable_msi() in the driver
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 766 at arch/arm/kernel/ipipe.c:158 ipipe_set_irq_affinity+0xa0/0xe0()

You are running an SMP kernel, is this really what you want ? (note
that this is unrelated to the problem you have).

> (...)
> 
> Any idias what is going wrong?

Does it work if you call rt_intr_enable after rt_intr_create ? 
If no, does it work if you call request_irq for the same interrupt ? 
If yes, does it work work if you use the I-pipe kernel from the
for-ipipe-3.14 branch of the ipipe-gch git repository ?

-- 
					    Gilles.

