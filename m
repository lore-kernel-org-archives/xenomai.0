From: Dennis Nguyen <dennisnguy@domain.hid>
In-Reply-To: <mailman.91.1196420467.32207.xenomai@xenomai.org>
References: <mailman.91.1196420467.32207.xenomai@xenomai.org>
Content-Type: text/plain
Date: Fri, 30 Nov 2007 13:35:45 -0800
Message-Id: <1196458545.4072.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xnintr_shirq_handler: IRQ11 not handled.
	Disabling IRQ line
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Jeroem,

You right, 
set CONFIG_ACPI=y
and turn off PCI BIOS
#CONFIG_PCI_BIOS is not set
The kernel will assign unique IRQ for each PCI device.

Thanks,
Dennis

On Fri, 2007-11-30 at 12:01 +0100, xenomai-help-request@domain.hid wrote:
> Send Xenomai-help mailing list submissions to
> 	xenomai@xenomai.org
> 
> To subscribe or unsubscribe via the World Wide Web, visit
> 	https://mail.gna.org/listinfo/xenomai-help
> or, via email, send a message with subject or body 'help' to
> 	xenomai-help-request@domain.hid
> 
> You can reach the person managing the list at
> 	xenomai-help-owner@domain.hid
> 
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Xenomai-help digest..."
> 
> 
> Today's Topics:
> 
>    1. Re: xnintr_shirq_handler: IRQ11 not handled. Disabling IRQ
>       line. (Dennis Nguyen)
>    2. rt_queue_write strange behaviour (Roderik.Wildenburg@domain.hid)
>    3. Re: xnintr_shirq_handler: IRQ11 not handled.	Disabling IRQ
>       line. (Jeroen Van den Keybus)
>    4. rt_queue_write strange behaviour ++
>       (Roderik.Wildenburg@domain.hid)
>    5. error while rt_task_wait_period, code -110 (Andreas Vogt)
>    6. Re: rt_queue_write strange behaviour ++ (Philippe Gerum)
> 
> 
> ----------------------------------------------------------------------
> 
> Message: 1
> Date: Thu, 29 Nov 2007 06:52:19 -0800
> From: Dennis Nguyen <dennisnguy@domain.hid>
> Subject: Re: [Xenomai-help] xnintr_shirq_handler: IRQ11 not handled.
> 	Disabling IRQ line.
> To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>,
> 	rolandtollenaar@domain.hid
> Cc: xenomai@xenomai.org
> Message-ID: <474ED223.9040009@domain.hid>
> Content-Type: text/plain; charset=UTF-8; format=flowed
> 
> Jeroen, Roland,
> 
> I'm sorry for replying late.  my interrupt conflicts could be solved by 
> using only one NIC or upgrade to Linux 2.6.23.9.  Interestingly I 
> noticed that the kernel 2.6.23.9 assigned different IRQ for each PCI device.
> My solution is using Linux i386 2.6.23.9 and xenomai 2.4-rc7.
> Thanks for your help,
> Dennis
> 
> Jeroen Van den Keybus wrote:
> >
> >     post the output of
> >
> >     lspci -v
> >
> >  
> > And while you're at it, please also show the results of
> >  
> > cat /proc/interrupts
> > cat /proc/xenomai/irq
> >  
> > both just before loading the driver and right after the 'Disabling 
> > IRQ.' message.
> >  
> >  
> > Jeroen.
> >  
> >
> >  
> >
> >
> >  
> >
> >     Roland
> >
> >     Dennis Nguyen wrote:
> >     > Most of the times the RTnet/Xenomai disabled the IRQ right away.
> >     few
> >     > time it ran for a while.
> >     > It doesn't matter the system has single or 2 cards, it still have
> >     > conflict IRQ.  I tried to change the slot but it did not help.
> >     > Thanks,
> >     > Dennis
> >     >
> >     > Jeroen Van den Keybus wrote:
> >     >>     The Xenomai disabled the interrupt when it saw the sharing.
> >     >>
> >     >>
> >     >> I may have mislooked, but doesn't xnintr_shirq_handler only
> >     disable
> >     >> the line after XNINTR_MAX_UNHANDLED problematic IRQs (which is by
> >     >> default set to 1000) ? If you get the error immediately after
> >     loading
> >     >> the driver, it looks like either the interrupt doesn't get
> >     properly
> >     >> acknowledged in the I-pipe (after which the driver gets pounded
> >     by 999
> >     >> stray interrupts, causing it to return 'unhandled') or the driver
> >     >> fails to acknowledge it on the card.
> >     >>
> >     >>
> >     >>     The NICs worked normally with 8139too.ko and 8139cp.ko drivers.
> >     >>
> >     >>
> >     >> Ok. I think that means that at least no weird things happen in the
> >     >> I-pipe or that the cards are defective (or poorly inserted in
> >     slot).
> >     >>
> >     >>
> >     >>     I have three difference types of PCs: pentium III 650 Mhz,
> >     Core2, and
> >     >>     AMD athlon 2Ghz. on different mother boards.  All of them have
> >     >>     conflict
> >     >>     IRQs with xenomai and RTnet.  I swapped the slots but it
> >     did not
> >     >>     changed.  I'm thinking of giving the NICs  fixed IRQ but I
> >     don't
> >     >>     know how.
> >     >>
> >     >>
> >     >> As said before, you can only practically do that in the BIOS or
> >     using
> >     >> ACPI.
> >     >>
> >     >> Does the rtnet driver work correctly with only one card ?
> >     >>
> >     >>
> >     >> Jeroen.
> >     >>
> >     >
> >     > _______________________________________________
> >     > Xenomai-help mailing list
> >     > Xenomai-help@domain.hid <mailto:Xenomai-help@domain.hid>
> >     > https://mail.gna.org/listinfo/xenomai-help
> >     >
> >
> >
> 
> 
> 
> ------------------------------
> 
> Message: 2
> Date: Thu, 29 Nov 2007 16:05:43 +0100
> From: <Roderik.Wildenburg@domain.hid>
> Subject: [Xenomai-help] rt_queue_write strange behaviour
> To: <xenomai@xenomai.org>
> Message-ID:
> 	<5D63919D95F87E4D9D34FF7748CE2C2AE3C474@domain.hid>
> Content-Type: text/plain; charset="us-ascii"
> 
> Sometimes we get an EINVAL-Error with rt_queue_write.
> If we immediatelly after the EINVAL-Error try an a second time to write
> to the queue (with exactly the same parameters as at the first time) the
> rt_queue_write succeeds (see appended code sniped) !!??
> 
> I traced down (xnprintf) the error to the function rt_queue_send where a
> plausibility test is made :
> 
> if (xnheap_check_block(&q->bufpool, msg) || msg->refcount == 0) 
> [approx at line 614]
> 
> this test fail as (msg->refcount == 0).
> If I understand the comment correctly :
> 
> /* In case of invalid block or if the sender does not own the
>    message, just bail out. */
> 
> the sender does not own the message.
> But if so, the second try should fail also (and I am quite sure the
> message belongs to the sender) ?
> Does anyone (probabliy Philipe) has an idea in what situation this
> problem could occur or what is the reason for this stange behaviour ?
> 
> Unfortunately I could not reproduce this problem in a simple testcase.
> Therefore I do not have an simple test case, but with our application
> the error occurs regularly (~10 times a hour).
> So I rely on your intuition to spike this problem.
> 
> Many thanks in advance and best regards
> Roderik 
> 
> MAN Roland Druckmaschinen AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Rall, Paul Steidle    
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht Offenbach HRB-Nr. 42592    
> USt-Ident-Nr. DE 250200933
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: rt_queue_write.c
> Type: application/octet-stream
> Size: 815 bytes
> Desc: rt_queue_write.c
> Url : /public/xenomai-help/attachments/20071129/49757763/attachment.obj 
> 
> ------------------------------
> 
> Message: 3
> Date: Thu, 29 Nov 2007 17:50:58 +0100
> From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
> Subject: Re: [Xenomai-help] xnintr_shirq_handler: IRQ11 not handled.
> 	Disabling IRQ line.
> To: "Dennis Nguyen" <dennisnguy@domain.hid>
> Cc: xenomai@xenomai.org
> Message-ID:
> 	<fd6a47a90711290850w5d21c703na1af5eab5eee928c@domain.hid>
> Content-Type: text/plain; charset="iso-8859-1"
> 
> >
> > I'm sorry for replying late.  my interrupt conflicts could be solved by
> > using only one NIC or upgrade to Linux 2.6.23.9.  Interestingly I
> > noticed that the kernel 2.6.23.9 assigned different IRQ for each PCI
> > device.
> 
> 
> That's exactly what I meant by trying to have ACPI reorganize the interrupts
> for you. Never compile without CONFIG_ACPI=yes... And beware, I believe that
> the IRQ config may vary, theoretically even upon every reboot.
> 
> Jeroen.
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: /public/xenomai-help/attachments/20071129/77b71f7b/attachment.htm 
> 
> ------------------------------
> 
> Message: 4
> Date: Fri, 30 Nov 2007 11:42:57 +0100
> From: <Roderik.Wildenburg@domain.hid>
> Subject: [Xenomai-help] rt_queue_write strange behaviour ++
> To: <xenomai@xenomai.org>
> Message-ID:
> 	<5D63919D95F87E4D9D34FF7748CE2C2AE3C69D@ARVMAIL1.mra.roland-man.biz>
> Content-Type: text/plain;	charset="iso-8859-1"
> 
> Sorry, but in my last mail (see below) I had forgotten to tell you my 
> Xenomai-Version and architecture.
> I still use Xenomai 2.3.2 on PPC.
> 
> In the meantime I had a deeper look into the Xenomai source code 
> and I would say, the case we observed (msg->refcount == 0 ; see below)
> isn?t possible with rt_queue_write, as this function implicitly allocate 
> its messagebuffer and rt_queue_alloc initilaizes refcount to 1.
> Immediatelly after this rt_queue_send is called, where the 
> plausibility test if( msg->refcount == 0) is done and fails. 
> So, I can?t see a gap where refcount falls back to 0.
> 
> Does any guru have a good idea, I am quite clueless.
> 
> Original mail :
> --------------------------------------------------------------------
> 
> Sometimes we get an EINVAL-Error with rt_queue_write.
> If we immediatelly after the EINVAL-Error try an a second time to write
> to the queue (with exactly the same parameters as at the first time) the
> rt_queue_write succeeds (see appended code sniped) !!??
> 
> I traced down (xnprintf) the error to the function rt_queue_send where a
> plausibility test is made :
> 
> if (xnheap_check_block(&q->bufpool, msg) || msg->refcount == 0) 
> [approx at line 614]
> 
> this test fail as (msg->refcount == 0).
> If I understand the comment correctly :
> 
> /* In case of invalid block or if the sender does not own the
>    message, just bail out. */
> 
> the sender does not own the message.
> But if so, the second try should fail also (and I am quite sure the
> message belongs to the sender) ?
> Does anyone (probabliy Philipe) has an idea in what situation this
> problem could occur or what is the reason for this strange behaviour ?
> 
> Unfortunately I could not reproduce this problem in a simple testcase, 
> but with our application the error occurs regularly (~10 times a hour).
> So I rely on your intuition to spike this problem.
> 
> Many thanks in advance and best regards
> Roderik 
> 
> MAN Roland Druckmaschinen AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Rall, Paul Steidle    
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht Offenbach HRB-Nr. 42592    
> USt-Ident-Nr. DE 250200933
> 
> 
> 
> ------------------------------
> 
> Message: 5
> Date: Fri, 30 Nov 2007 11:52:48 +0100
> From: Andreas Vogt <A_C_V@web.de>
> Subject: [Xenomai-help] error while rt_task_wait_period, code -110
> To: xenomai@xenomai.org
> Message-ID: <1829866571@domain.hid>
> Content-Type: text/plain; charset="iso-8859-15"
> 
> Hallo,
> 
> I get an error in a simple program with a period time of 1 ms.My latency test program works with a period of 100us.The worst latenz time is about 23us
> Any suggestions?
> 
> Andreas
> _____________________________________________________________________
> Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
> http://smartsurfer.web.de/?mc=100071&distributionid=000000000066
> 
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: speaker.c
> Type: text/x-csrc
> Size: 2030 bytes
> Desc: not available
> Url : /public/xenomai-help/attachments/20071130/5061d2c3/attachment.c 
> 
> ------------------------------
> 
> Message: 6
> Date: Fri, 30 Nov 2007 11:55:20 +0100
> From: Philippe Gerum <rpm@xenomai.org>
> Subject: Re: [Xenomai-help] rt_queue_write strange behaviour ++
> To: Roderik.Wildenburg@domain.hid
> Cc: xenomai@xenomai.org
> Message-ID: <474FEC18.7040304@domain.hid>
> Content-Type: text/plain; charset="iso-8859-1"
> 
> Roderik.Wildenburg@domain.hid wrote:
> > Sorry, but in my last mail (see below) I had forgotten to tell you my 
> > Xenomai-Version and architecture.
> > I still use Xenomai 2.3.2 on PPC.
> > 
> > In the meantime I had a deeper look into the Xenomai source code 
> > and I would say, the case we observed (msg->refcount == 0 ; see below)
> > isn?t possible with rt_queue_write, as this function implicitly allocate 
> > its messagebuffer and rt_queue_alloc initilaizes refcount to 1.
> > Immediatelly after this rt_queue_send is called, where the 
> > plausibility test if( msg->refcount == 0) is done and fails. 
> > So, I can?t see a gap where refcount falls back to 0.
> 
> Does the attached patch trigger any message when your app fails?
> 


