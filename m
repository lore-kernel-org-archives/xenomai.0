MIME-Version: 1.0
In-Reply-To: <718DFA7882181D45B8BD18F31C46D55427A69659@MBX204.domain.local>
References: <201302141227.05428.paul_c@tuxcnc.org>
	<718DFA7882181D45B8BD18F31C46D55427A69659@MBX204.domain.local>
Date: Thu, 14 Feb 2013 15:15:56 -0500
Message-ID: <CA+T6QPkAcdsU5-eCNiSrM2owEUPi1x5yiUFKmp3n=_HLiBDSww@mail.gmail.com>
From: Jason Kridner <jkridner@beagleboard.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [beagleboard] FW:  Xenomai, Raspberry Pi, 3.5.7 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>
Cc: xenomai@xenomai.org

On Thu, Feb 14, 2013 at 8:59 AM, Gregory Perry
<Gregory.Perry@govirtual.tv> wrote:
> Any chance of getting similar Xenomai support built into the mainline 3.8=
 kernel for the BeagleBoard?  A patch set for Xenomai support for the Beagl=
eBone was recently submitted to the Xenomai project, mainline kernel suppor=
t would in turn facilitate direct support from the Xenomai team for the Bea=
gleBone (probably wouldn't hurt to send the Xenomai team a care package of =
a couple BeagleBoards/Bones etc to increase their enthusiasm about maintain=
ing support for both with their development efforts).

If there are individuals who would actively work on this, sending a
couple of boards would be something I can do. I just don't want to go
sending out boards that'll sit idle. Contact me with names/emails of
people who will actively work this.

>
> ________________________________________
> From: xenomai-bounces@xenomai.org [xenomai-bounces@xenomai.org] on behalf=
 of Paul [paul_c@tuxcnc.org]
> Sent: Thursday, February 14, 2013 7:27 AM
> To: xenomai@xenomai.org
> Subject: [Xenomai] Xenomai, Raspberry Pi, 3.5.7 kernel
>
> Attached, a patch set aimed at providing support for the Broadcom
> BCM2835 SoC as used in the Raspberry Pi[1].
>
> The first patch assumes that the core-ipipe-3.5.7-arm patch has already
> been applied or the sources have been pulled from the ipipe git
> repository[2]. Most of the changes have been pulled from the 3.6.11
> kernel sources maintained by the Rasbperry team and adds a number of
> drivers needed by the BCM2835 chip. Low level changes to the timer
> support have been made courtesy of ian-cim and his preliminary 3.2.21
> patch[3]
>
> Patch number 2 silences a trivial compile time warning and can be
> skipped..
> Patch number three adds a minimal default config (bcmrpi_defconfig) that
> can be used as a basis for compiling a Xenomai enabled kernel. This
> patch can also be skipped if a defconfig is not required.
>
> Patch number four makes some changes to the way GPIO interrupts are
> handled - Interrupt latencies are considerably improved (typically in
> the 15-30uS range).
>
> Work is being undertaken by the Raspberry team to get support built in
> to the mainline kernel - I believe the window has been missed for
> 3.8.x, so fingers are crossed for 3.10.x.
>
>
> Regards, Paul.
>
>
> [1] www.raspberrypi.org
> [2] git://git.denx.de/ipipe.git
> [3] www.raspberrypi.org/phpBB3/viewtopic.php?f=3D41&t=3D12368
>
>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: raspberry-pi.bz2
> Type: application/x-bzip2
> Size: 458222 bytes
> Desc: not available
> URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130214/bb924=
4d7/attachment.bin>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>
> --
> For more options, visit http://beagleboard.org/discuss
> ---
> You received this message because you are subscribed to the Google Groups=
 "BeagleBoard" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to beagleboard+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/groups/opt_out.
>
>

