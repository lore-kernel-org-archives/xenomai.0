MIME-Version: 1.0
References: <HK2PR06MB1187DCC67A2AB77E7674E2FDA3D20@HK2PR06MB1187.apcprd06.prod.outlook.com>
 <CALLqZ8Qx218=Yj8SXsCGrUHAWaNE824dxcv6bFBUTVvhmdTUPA@mail.gmail.com>
 <PS1PR06MB1195A329D28385BBDE7589D2A3D30@PS1PR06MB1195.apcprd06.prod.outlook.com>
In-Reply-To: <PS1PR06MB1195A329D28385BBDE7589D2A3D30@PS1PR06MB1195.apcprd06.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 30 Nov 2018 01:21:32 -0500
Message-ID: <CALLqZ8RSwUQ0k-iMCJghx61PGpkUztviAvsnBvsrZJKk0T5fHw@mail.gmail.com>
Subject: Re: IRQ WARNING message occurred on the ZynqMP(Xilinx)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?7JqwIOywve2YhA==?= <baramir@msn.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

I believe you may be missing the flag in the irq chip driver to say
it's pipeline safe.  Either that hasn't been enabled yet or if it uses
the same irq chip as the 32-bit zynq chip then you are probably
missing the driver bits from the no-arch tree.  I can double check
when I have some time today.  Most users get the patch from
https://xenomai.org/downloads/ipipe/ but if you want to go with 4.14
then your approach works.  With your approach I believe that you'll
also have to get some driver bits from the noarch tree.  I'm still
waiting for my ultra96 board or else i'd try this out but I think
others on here have gotten it running with 4.14.

-Greg
On Thu, Nov 29, 2018 at 7:29 PM =EC=9A=B0 =EC=B0=BD=ED=98=84 via Xenomai <x=
enomai@xenomai.org> wrote:
>
> I use Linux repository provided by Xilinx, like below.
>
> https://github.com/Xilinx/linux-xlnx
>
> And I use ipipe-arm64 repository, like below.
>
> https://gitlab.denx.de/Xenomai/ipipe-arm64
>
> First I made a patch file between ipipe-arm64 and linux-stable-4.14.4 tag=
.
>
> Next I pached to linux-xlnx.
>
> And I succeeded the petalinux build with patched linux-xlinx.
>
> This method is wrong?
>
> Could you give me some advice?
>
> I am not yet familiar with the mail list and have rewritten it.
>
> - Thomas
>
>
> 2018=EB=85=84 11=EC=9B=94 29=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 8:59=
=EC=97=90 Greg Gallagher <greg@embeddedgreg.com<mailto:greg@embeddedgreg.co=
m>>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> What version of the kernel/ipipe are you using? If you want to use petali=
nux you'll need to apply to ipipe patch to it.
>
> -Greg
>
> On Wed., Nov. 28, 2018, 9:39 p.m. =EC=9A=B0 =EC=B0=BD=ED=98=84 via Xenoma=
i <xenomai@xenomai.org<mailto:xenomai@xenomai.org> wrote:
> Hi.
>
> I'm porting the 3.1-dev xenomai on the ZynqMP.
>
> I succeed build from petalinux but a WARNING message occurred on the dmes=
g, like below.
>
> [    1.325926] ------------[ cut here ]------------
> [    1.325954] WARNING: CPU: 1 PID: 1 at /kernel-source//kernel/irq/chip.=
c:57 irq_set_chip+0x94/0xa8
> [    1.325965] Modules linked in:
> [    1.325978] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.14.0-ipipe #1
> [    1.325987] Hardware name: xlnx,zynqmp (DT)
> [    1.325994] I-pipe domain: Linux
>
> I found a similar issue on this mailing list.
>
> https://xenomai.org/pipermail/xenomai/2018-February/038318.html
>
> I think that the 'IRQCHIP_PIPELINE_SAFE' flag isn't set for Xilinx IRQ so=
urce code.
>
> So could you investigate for this warning like BCM2835?
>
> Best Regards,
> Thomas Woo

