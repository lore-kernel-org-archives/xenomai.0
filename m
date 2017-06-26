Date: Mon, 26 Jun 2017 08:44:33 +0800 (GMT+08:00)
From: kirayamato@zju.edu.cn
Message-ID: <6665fdf0.14a6a.15ce1db6f0b.Coremail.kirayamato@zju.edu.cn>
In-Reply-To: <mailman.3.1498298402.11325.xenomai@xenomai.org>
References: <mailman.3.1498298402.11325.xenomai@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai Digest, Vol 62, Issue 21
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Thank you for your kindness. I built the xenomai only once, and the new ker=
nel can not boot.=20
Last weekend, I tried again and read the following boot message:

Kernel panic - not syncing: timer doesn't work through Interrupt-remapped I=
O-APIC.

So, it is a problem caused by the hardware configuration?

> -----=D4=AD=CA=BC=D3=CA=BC=FE-----
> =B7=A2=BC=FE=C8=CB: xenomai-request@xenomai.org
> =B7=A2=CB=CD=CA=B1=BC=E4: 2017=C4=EA6=D4=C224=C8=D5 =D0=C7=C6=DA=C1=F9
> =CA=D5=BC=FE=C8=CB: xenomai@xenomai.org
> =B3=AD=CB=CD:=20
> =D6=F7=CC=E2: Xenomai Digest, Vol 62, Issue 21
>=20
> Send Xenomai mailing list submissions to
> =09xenomai@xenomai.org
>=20
> To subscribe or unsubscribe via the World Wide Web, visit
> =09https://xenomai.org/mailman/listinfo/xenomai
> or, via email, send a message with subject or body 'help' to
> =09xenomai-request@xenomai.org
>=20
> You can reach the person managing the list at
> =09xenomai-owner@xenomai.org
>=20
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Xenomai digest..."
>=20
>=20
> Today's Topics:
>=20
>    1. Re: System freezed when loading initial ramdisk (Lennart Sorensen)
>=20
>=20
> ----------------------------------------------------------------------
>=20
> Message: 1
> Date: Fri, 23 Jun 2017 13:49:26 -0400
> From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
> To: kirayamato@zju.edu.cn
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] System freezed when loading initial ramdisk
> Message-ID: <20170623174926.GE18556@csclub.uwaterloo.ca>
> Content-Type: text/plain; charset=3Dus-ascii
>=20
> On Fri, Jun 23, 2017 at 03:51:37PM +0800, kirayamato@zju.edu.cn wrote:
> > Hi, everyone.
> > I patched kernel 3.14.17 with xenomai 2.6.4 on my laptop, but the syste=
m freezed when booting process showed loading initial ramdisk. I do not fin=
d any hints on the trouble shooting manual. Can anyone tell me how to fix i=
t?
>=20
> Did you generate a new ramdisk with modules built with your new kernel?
>=20
> Modules built for a different kernel config rarely work with a new kernel=
.
>=20
> --=20
> Len Sorensen
>=20
>=20
>=20
> ------------------------------
>=20
> Subject: Digest Footer
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>=20
>=20
> ------------------------------
>=20
> End of Xenomai Digest, Vol 62, Issue 21
> ***************************************
>=20


