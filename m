Message-ID: <1489998848.4037.3.camel@smigroup.net>
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Mon, 20 Mar 2017 09:34:08 +0100
In-Reply-To: <009e01d2a14e$eb682e00$c2388a00$@sepro-group.com>
References: <009e01d2a14e$eb682e00$c2388a00$@sepro-group.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Trying to install Xenomai 3.0.3 on i.MX6 Kernel 4.1.15
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Perles <cperles@sepro-group.com>
Cc: xenomai@xenomai.org

On Mon, 2017-03-20 at 08:52 +0100, C=C3=A9dric Perles wrote:
> Hi community,
>=20
>=20
>=20
> I=C2=92m a Xenomai newby and I=C2=92m trying to install Xenomai 3.0.3 o=
n my i.MX6
> based board (kernel 4.1.15 from NXP).
>=20
>=20
>=20
> So I followed the =C2=93Installing Xenomai 3.x=C2=94 chapter in Xenomai=
.org site and
> began to download ipipe-core-4.1.18-arm-8.patch.
>=20
> Since my kernel is not 4.1.18 but 4.1.15, I had to slightly adapt the
> patch to make it fit.
>=20
> Then I ran prepare-kernel.sh that tells me everything was OK.
>=20
> Finally I successfully compiled kernel (and saw a few ipipe and xenomai
> source files were built with into kernel).
>=20
>=20
>=20
> However, when I boot on that newly built kernel there is absolutely no
> xenomai nor ipipe logs into kernel boot logs, and no /proc/xenomai at a=
ll.
>=20
> I must have missed something or doing something wrong, but I don=C2=92t=
 see.
>=20
>=20
>=20
> =3D=3D> Did somebody successfully run Xeno 3.0.3 on i.MX6 ?
>=20
> =3D=3D> What am I doing wrong ?
>=20
Hi C=C3=A9dric,

I'm using Xenomai 3.0.3 with 4.1.15 kernel from NXP community with
success.

What defconfig have you used to configure your kernel? Before build it,
did you check with 'make menuconfig' that i-pipe was enabled?

Regards
Mauro
>=20
>=20
> Regards,
>=20
>=20
>=20
> C=C3=A9dric
>=20
>=20
>=20
>=20
> Sepro
>=20
> C=C3=A9dric PERLES
> Software R&D engineer
> SEPRO Robotique - Rue Henry Bessemer - Zone Acti-Est - CS 10084 - 85003=
 La
> Roche sur Yon Cedex (France)
>=20
> Tel : +33 (0)2 51 45 05 31
>=20
>   _____
>=20
>  <http://www.sepro-group.com/fr> www.sepro-group.com |
> <https://twitter.com/seprogroup> twitter@SeproGroup
>=20
>=20
>=20
>=20
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: image001.jpg
> Type: image/jpeg
> Size: 22984 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20170320/50daa0c=
f/attachment.jpg>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: image003.png
> Type: image/png
> Size: 818 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20170320/50daa0c=
f/attachment.png>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


