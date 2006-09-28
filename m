Subject: Re: [Adeos-main] Problems booting after Adeos patch
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <451C0171.3020508@domain.hid>
References: <451AEEED.1050708@domain.hid> <451B0978.5020108@domain.hid>
	<451BD6FC.9080205@domain.hid> <451BDADC.30101@domain.hid>
	<1159454661.4982.20.camel@domain.hid>  <451C0171.3020508@domain.hid>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 22:27:21 +0200
Message-Id: <1159475242.4982.46.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: "J.D. Yamokoski" <yamokosk@domain.hid>
Cc: adeos-main@gna.org

On Thu, 2006-09-28 at 13:08 -0400, J.D. Yamokoski wrote:
> Philippe Gerum wrote:
> > On Thu, 2006-09-28 at 16:23 +0200, Jan Kiszka wrote:
> >   
> >> J.D. Yamokoski wrote:
> >>     
> >>> Jan Kiszka wrote:
> >>>       
> >>>> J.D. Yamokoski wrote:
> >>>>  
> >>>>         
> >>>>> Greetings,
> >>>>>
> >>>>> I have recently run into some trouble trying to boot a custom configed
> >>>>> linux kernel with Adeos. During boot the system seems to have problems
> >>>>> with the SATA hard drives with messages like,
> >>>>>
> >>>>> ata1: slow completion (cmd ef)
> >>>>> ATA: abnormal status 0x0FF
> >>>>> ata1: command 0x25 timeout, stat 0x50 host-stat 0x24
> >>>>>
> >>>>> And then finally towards the end of the boot sequence, I get "ALERT!
> >>>>> /dev/sda3 does not exist. Dropping to a shell!"
> >>>>>
> >>>>> I am using a highly modified config customized for this machine
> >>>>> (Highlights of the config: It excludes a lot of drivers, SMP build, and
> >>>>> both SATA-as-SCSI-driver and the regular PCI IDE driver are enabled.)
> >>>>> Unpatched this customized kernel works fine. And as expected, if I use a
> >>>>> more general config file (one that came with my distro) the Adeos
> >>>>> patched kernel boots normally. Its just the combination of Adeos and
> >>>>> customized config that seems to be the problem. Does anything jump out
> >>>>> at anyone? I have include my config file with this email.
> >>>>>
> >>>>>     
> >>>>>           
> >>>> What I-pipe patch version are you using?
> >>>>
> >>>> Could you try with CONFIG_PCI_MSI disabled? There has been other reports
> >>>> on MSI issues recently, maybe yours belong to the same group.
> >>>>
> >>>> Thanks,
> >>>> Jan
> >>>>
> >>>>
> >>>> PS: Unrelated to the problem but maybe still interesting: If you plan to
> >>>> use Adeos/I-pipe as a real-time enabler (e.g. with Xenomai), you should
> >>>> switch off CONFIG_ACPI_PROCESSOR, CONFIG_CPU_FREQ, and CONFIG_APM.
> >>>> Recent Xenomai versions should warn you about this fact as well.
> >>>>
> >>>>   
> >>>>         
> >>> That seems to have fixed the problem! The new kernel with this disabled
> >>> boots just fine. Thanks!
> >>>       
> >> Well, I wouldn't say "fixed", it works around the bug.
> >>
> >>     
> >>> By the way, I was using I-pipe patch 2.6.15-i386-1.3-07.
> >>>       
> >> Philippe, any news on the MSI issue?
> >>
> >>     
> >
> > Nope. Unfortunately, now hw at hand that exhibits the issue, and no time
> > to dig it anyway.
> >
> >   
> >> Jan
> >>
> >> _______________________________________________
> >> Adeos-main mailing list
> >> Adeos-main@domain.hid
> >> https://mail.gna.org/listinfo/adeos-main
> >>     
> I can't lend out hardware, but if there are specific tests or patches 
> you want me to try, by all means send them my way.

Ok, thanks. Just for the purpose of finding some grip on this issue,
could you:
1) apply the patch below; I suspect some unwanted IRQ migration issue,
but can't prove it right now.
2) if this patch does not solve the boot problem with CONFIG_PCI_MSI
enabled, then does disabling CONFIG_SMP improve the situation?

TIA,

--- 2.6.17-ipipe/kernel/irq/migration.c~	2006-06-18 03:49:35.000000000 +0200
+++ 2.6.17-ipipe/kernel/irq/migration.c	2006-09-28 21:18:27.000000000 +0200
@@ -17,6 +17,11 @@
 	cpumask_t tmp;
 	irq_desc_t *desc = irq_descp(irq);
 
+#ifdef CONFIG_IPIPE
+	if (!__ipipe_pipeline_head_p(ipipe_root_domain))
+		return;
+#endif /* CONFIG_IPIPE */
+
 	if (likely(!desc->move_irq))
 		return;
 
-- 
Philippe.



