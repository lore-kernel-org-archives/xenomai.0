MIME-Version: 1.0
References: <HK2PR06MB1187DCC67A2AB77E7674E2FDA3D20@HK2PR06MB1187.apcprd06.prod.outlook.com>
In-Reply-To: <HK2PR06MB1187DCC67A2AB77E7674E2FDA3D20@HK2PR06MB1187.apcprd06.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 29 Nov 2018 06:59:23 -0500
Message-ID: <CALLqZ8Qx218=Yj8SXsCGrUHAWaNE824dxcv6bFBUTVvhmdTUPA@mail.gmail.com>
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

What version of the kernel/ipipe are you using? If you want to use
petalinux you'll need to apply to ipipe patch to it.

-Greg

On Wed., Nov. 28, 2018, 9:39 p.m. =EC=9A=B0 =EC=B0=BD=ED=98=84 via Xenomai =
<xenomai@xenomai.org
wrote:

> Hi.
>
> I'm porting the 3.1-dev xenomai on the ZynqMP.
>
> I succeed build from petalinux but a WARNING message occurred on the
> dmesg, like below.
>
> [    1.325926] ------------[ cut here ]------------
> [    1.325954] WARNING: CPU: 1 PID: 1 at
> /kernel-source//kernel/irq/chip.c:57 irq_set_chip+0x94/0xa8
> [    1.325965] Modules linked in:
> [    1.325978] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.14.0-ipipe #1
> [    1.325987] Hardware name: xlnx,zynqmp (DT)
> [    1.325994] I-pipe domain: Linux
>
> I found a similar issue on this mailing list.
>
> https://xenomai.org/pipermail/xenomai/2018-February/038318.html
>
> I think that the 'IRQCHIP_PIPELINE_SAFE' flag isn't set for Xilinx IRQ
> source code.
>
> So could you investigate for this warning like BCM2835?
>
> Best Regards,
> Thomas Woo
>
