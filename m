From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <7a15153d0909150549x13fada73r35a310227ae27b62@domain.hid>
References: <7a15153d0909081259o47b0fcb7k46f679e7dfe83456@domain.hid>
	<4AA6BC5D.8020704@domain.hid>
	<7a15153d0909090803o309c5883q5c02ebef4fa794d8@domain.hid>
	<4AA7C4F7.6000903@domain.hid>
	<7a15153d0909091206y5d16ffcck32d0c8cc3c120f6c@domain.hid>
	<4AA820D4.8000302@domain.hid>
	<7a15153d0909101028p11716996q7929815b6b65ccb0@domain.hid>
	<4AA93B24.8010802@domain.hid>
	<7a15153d0909150549x13fada73r35a310227ae27b62@domain.hid>
Content-Type: text/plain
Date: Tue, 15 Sep 2009 15:18:46 +0200
Message-Id: <1253020726.2676.103.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] High Latency on PXA
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Felipe Castro <felipecpc1@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2009-09-15 at 09:49 -0300, Felipe Castro wrote:
> Hi, 
> 
> I guess I compiled all with msoft-float OK , i disabled the float
> point emulation in the kernel , did a new filesystem with busybox
> compiled with soft float and compiled the xenomai user space to but
> running the latency program i still having a problem.
> 
> During the boot everything seems to be ok ....
> 
> Attached follow a log file, with the kernel load , and ipipe trace.
> what i supposed to do to get it running ok ?
> 

As Gilles pointed out already, you are supposed to use a pipeline patch
which does not exhibit the issue reported by Xenomai, which raises the
debug assertion reported in the log.

This patch only exists starting from 2.6.28, since the fix was not
backported to earlier kernel releases. Since you want to stick with a
non-mainline kernel, you will have to backport the fix yourself, and see
how it goes.

http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=912dcfb63c3315d8a20b8d467f72e443dad3852b
 

> As you asked me , I'm running version 2.4.9.1 of xenomai .
> 
> On Thu, Sep 10, 2009 at 2:45 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>         Felipe Castro wrote:
>         > I'm a little bit lost about this issues cause when running
>         the xenomai
>         > 2.4.8 with the patch that you send me it worked, but with
>         new version it
>         > doesn't work.
>         > Acctually i using the kernel 2.6.27 and i understand what
>         you told me ,
>         > in version 2.4.9.1 there aren't a patch to this kernel
>         version, neither
>         > xenomai 2.4.8.  :S
>         
>         
>         2.4.8 appeared to work, but it had a bug.
>         See
>         https://mail.gna.org/public/xenomai-core/2009-08/msg00021.html
>         
>         >
>         > The problem is, I'm using a Voipac development kit, and the
>         have only
>         > the kernel 2.6.27 BSP.
>         >
>         > So , i tried to disable the float point emulation but the
>         kernel didn't
>         > load OK .
>         
>         
>         It proves that your user-space support is compiled for
>         hardware float,
>         but not PXA hardware floats. This is a pure waste of CPU
>         power. See:
>         
>         http://www.arm.linux.org.uk/mailinglists/faq.php#f3
>         
>         Note that Xenomai applications compiled that way will not work
>         either.
>         
>         --
>                                                  Gilles
>         
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



