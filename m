MIME-Version: 1.0
Sender: alexis.berlemont@domain.hid
In-Reply-To: <9c789a000906040120t53d8a7ccm4e9384d4328634dd@domain.hid>
References: <9c789a000905250446t78fd6b38x1a6f28e35b70d7d6@domain.hid>
	<9c789a000905260736t241467ax805c4823b0d58ff5@domain.hid>
	<1243374524.22014.74.camel@domain.hid>
	<9c789a000905261525q45cbaa3ag25855befde1cb130@domain.hid>
	<9c789a000905261531m67dee7dah9740d825cce04cbc@domain.hid>
	<9c789a000905261535v56d5ac5i4fa1a41f4e678849@domain.hid>
	<9c789a000905271447i3998c3d3xf5ce93d1d8783031@domain.hid>
	<72cf3fb0905272338s6ef295fch9239989091ac85ca@domain.hid>
	<871vq0kftf.fsf@domain.hid>
	<9c789a000906040120t53d8a7ccm4e9384d4328634dd@domain.hid>
Date: Thu, 4 Jun 2009 11:00:21 +0200
Message-ID: <72cf3fb0906040200p45bf7435yf9ac4dc9b39e35e7@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Driver testing procedure ?!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cristian Axenie <cristian.axenie@domain.hid>
Cc: xenomai@xenomai.org

Hi,

On Thu, Jun 4, 2009 at 10:20 AM, Cristian Axenie
<cristian.axenie@domain.hid> wrote:
> Hy I,ve tested the new git update and failed
>
> /usr/xenomai/sbin # ./comedi_config comedi0 comedi_pcimio
> Unable to handle kernel paging request for data at address 0x0000001c
> Faulting instruction address: 0xc0239c5c
> Oops: Kernel access of bad area, sig: 11 [#1]
> MPC831x RDB
> Modules linked in:
> NIP: c0239c5c LR: c024aaf8 CTR: 00000000
> REGS: c7affcd0 TRAP: 0300=A0=A0 Not tainted=A0 (2.6.24.2)
> MSR: 00009032 <EE,ME,IR,DR>=A0 CR: 24008424=A0 XER: 00000000
> DAR: 0000001c, DSISR: 20000000
> TASK =3D c7889430[1536] 'comedi_config' THREAD: c7afe000
> GPR00: 0000ffff c7affd80 c7889430 c03f00e0 00000030 c0247d44 00000001
> c03f00e0
> GPR08: c907a000 00000000 00000001 c7810400 c7900a00 1004a5b8 c033c200
> c03c0000
> GPR16: c03b83c4 c03cfa00 fffffff0 c7afff50 c03cfa00 00000040 00000010
> c03a0ca0
> GPR24: c03f00e0 c03b2cf0 00000000 00000000 c7900800 c03d8628 fffffff0
> c03f00e0
> Call Trace:
> [c7affd80] [c023c2d4]=A0 (unreliable)
> [c7affda0] [c024aaf8]
> [c7affdd0] [c02376f8]
> [c7affdf0] [c0237830]
> [c7affe30] [c0237c50]
> [c7affe40] [c023a5e8]
> [c7affe70] [c0089820]
> [c7affeb0] [c008ba50]
> [c7affec0] [c00582d0]
> [c7affee0] [c0049188]
> [c7afff30] [c0009644]
> [c7afff40] [c0010ca4]
> --- Exception: c01Instruction dump:
> 38210010 7c0803a6 4e800020 9421ffe0 7c0802a6 bf61000c 7c7f1b78 3bc0fff0
> 90010024 38000000 6000ffff 81230010 <8169001c> 7f8b0000 419e001c 80010024
> ---[ end trace 78f6932e4d494a5a ]---
>
> and I've managed to trace the fault
>
> /home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-integration/d=
rivers/xenomai/comedi/transfer.c:295
> c0239c50:=A0=A0=A0 38 00 00 00 =A0=A0=A0 li=A0=A0=A0=A0=A0 r0,0
> c0239c54:=A0=A0=A0 60 00 ff ff =A0=A0=A0 ori=A0=A0=A0=A0 r0,r0,65535
> c0239c58:=A0=A0=A0 81 23 00 10 =A0=A0=A0 lwz=A0=A0=A0=A0 r9,16(r3)
> c0239c5c:=A0=A0=A0 81 69 00 1c =A0=A0=A0 lwz=A0=A0=A0=A0 r11,28(r9)
> c0239c60:=A0=A0=A0 7f 8b 00 00 =A0=A0=A0 cmpw=A0=A0=A0 cr7,r11,r0
> c0239c64:=A0=A0=A0 41 9e 00 1c =A0=A0=A0 beq-=A0=A0=A0 cr7,c0239c80 <come=
di_request_irq+0x48>
>
> What do you think ?
>

OK. I must have missed something obvious. I will dig further.

Alexis.

