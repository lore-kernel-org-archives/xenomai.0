Message-ID: <45880ED8.9040306@domain.hid>
Date: Tue, 19 Dec 2006 17:10:00 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] ADEOS IPIPE PPC patches upgrade
References: <458685C6.40204@domain.hid>	<20061218134917.c76ac833.benjamin.zores@domain.hid>	<45869247.6020704@domain.hid>
	<20061219134433.fb10846e.benjamin.zores@domain.hid>
In-Reply-To: <20061219134433.fb10846e.benjamin.zores@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Benjamin Zores <benjamin.zores@domain.hid>
Cc: xenomai@xenomai.org

Benjamin Zores wrote:
> On Mon, 18 Dec 2006 14:06:15 +0100
> Wolfgang Grandegger <wg@domain.hid> wrote:
> 
>> I don't understand your questions. These patches are for the PPC tree. 
>> The POWERPC is still not supported. Do you already have a working port 
>> for the PowerPC tree 2.6.18?
> 
> I send one a month ago but which wasn't 100% complete.
> Now, here's an updated one for both ppc and powerpc arch.
> It based on your patch + the equivalent functions ported to merged powerpc architecture.
> This time it should compile fine but i haven't tested if ppc arch still works
> (i can't do so).
> 
> I just remove the xenomai parts from your patch (which obviously had nothing to do
> in adeos patch itself).
> 
> With ipipe enabled on my card, the kernels boots up
> but still hangs due to IRQ problems has it used to do in 2.6.18.
> It seems to hang at SATA driver load (does the same for USB/I2C and so on after all)
>  but if I had printk() in each function from ipipe-root.c it goes in an endless
> loop of:
> 
> ...
> __ipipe_handle_irq:226
> __ipipe_do_timer:404
> __ipipe_grab_timer:357
> __ipipe_handle_irq:226
> __ipipe_do_timer:404
> __ipipe_grab_timer:357
> ...
> 
> and seems to never go further :-(

Well, in the meantime I started the porting of IPIPE v1.6 over the 
PowerPC tree on my Icecube-MPC5200 board ... and it seems to hang at the 
same location :-(.

> Do you have an idea where and why this might come from ?

No yet but it seems not to be related with interrupts.

> FYI, the vanilla 2.6.19 kernel boots up my card fine and goes to userspace
> but seems to also hang a few time later (but at least it boots up to user space).

The PowerPC tree is highly experimental, ... not really a good setup to 
do the porting.

> Anyhow, please consider this patch for review and if possible test it/apply it.

OK, I will have a closer look when time permits.

Wolfgang.


