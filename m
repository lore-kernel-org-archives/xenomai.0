From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A018D3CFB@ARVMAIL1.mra.roland-man.biz>
References: <5D63919D95F87E4D9D34FF7748CE2C2A018D3CFB@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain
Date: Tue, 24 Mar 2009 10:22:28 +0100
Message-Id: <1237886548.6815.39.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

On Mon, 2009-03-23 at 15:25 +0100, roderik.wildenburg@domain.hid
wrote:
> Hello Philippe,
> 
> could you find out something new with this issue ?

I did not manage to resume work on this issue yet, unfortunately.
Meanwhile, you my want to switch to 2.4.7, so that we don't run into
already fixed issues when chasing this one later on.

> 
> Roderik
> 
> > Wolfgang Grandegger wrote:
> > > Philippe Gerum wrote:
> > >> roderik.wildenburg@domain.hid wrote:
> > >>> On behalf of Thomas I would like to answer : 
> > >>>
> > >>>> Do you have CONFIG_XENO_OPT_DEBUG_NUCLEUS enabled in your 
> > >>> yes, we can aahhh have this option enabled.
> > >>>
> > >>>> kconfig, and if so, do
> > >>>> you get any message in your kernel log when running fetest?
> > >>> no, no message anywhere (/var/log/messages, console, dmesg).
> > >>> fetest runs and runs till I sent CTRL-C.
> > > 
> > > I just tried the program fetest on my TQM5200 with a fresh 
> > Xenomai 2.4.x
> > > and the linuxppc_2_4_devel tree and the excepetion does *not* get
> > > triggered. Actually I realize the following wired behavior:
> > >
> > 
> > I can reproduce this as well on the tqm now. This seems to be 
> > a nucleus issue 
> > wrt FPU management. More later.
> > 
> > > /fpu_test
> > > ^C
> > > ./fpu_test
> > > ^C
> > > Feb  3 17:16:12 tqm5200 kernel: Xenomai: Switching trivial 
> > to secondary
> > > mode after exception #1792 from user-space at 0x10001974 (pid 342)
> > > Floating point exception
> > > bash-2.05b# ./fpu_test
> > > ^C
> > > bash-2.05b# ./fpu_test
> > >  ^C
> > > bash-2.05b# ./fpu_test
> > > 
> > > After aborting the fpu_test program with ^C, I get the 
> > message above,
> > > but only after the second try.
> > > 
> > >> Gilles sent you a patch affecting 
> > include/asm-powerpc/bits/pod.h a few weeks
> > >> ago, that fixed an FPU issue. Are you running with this 
> > patch applied?
> > > 
> > > $ svn log include/asm-powerpc/bits/pod.h
> > > 
> > --------------------------------------------------------------
> > ----------
> > > r4600 | gch | 2009-01-31 19:46:37 +0100 (Sat, 31 Jan 2009) | 1 line
> > > 
> > > Is that the patch you have in mind?
> > > 
> > > Wolfgang.
> > > 
> > 
> >
> 
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Rall, Paul Steidle   
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht Offenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933
-- 
Philippe.



