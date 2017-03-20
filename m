From: =?UTF-8?Q?C=C3=A9dric_Perles?= <cperles@sepro-group.com>
References: <009e01d2a14e$eb682e00$c2388a00$@sepro-group.com>
 <1489998848.4037.3.camel@smigroup.net>
In-Reply-To: <1489998848.4037.3.camel@smigroup.net>
Date: Mon, 20 Mar 2017 15:29:56 +0100 (CET)
Message-ID: <00b501d2a186$6ffd0c30$4ff72490$@sepro-group.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Language: fr
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
To: Mauro Salvini <mauro.salvini@smigroup.net>
Cc: xenomai@xenomai.org

Hi Mauro,

First of all, thx for your answer. Knowing that Xenomai 3.0.3 is possible=
 on=20
iMX6 kernel 4.1.15 is already a relief for me.

I compile my kernel through BuildRoot that automatically builds the .conf=
ig=20
file.
However, when I check into kernel menuconfig, I can see I-PIPE is selecte=
d=20
(kernel Features -> -*- Interrupt pipeline) and Xenomai is selected ([*]=20
Xenomai/cobalt ).
My .config file is also OK (CONFIG_IPIPE=3Dy , CONFIG_IPIPE_CORE=3Dy,=20
CONFIG_XENOMAI=3Dy).

=3D=3D> What IPIPE patch did you use ?
=3D=3D> Does IPIPE need something from RootFS ?

Regards,

C=C3=A9dric

 Sepro<http://extranet.sepro-robotique.com/signatures/Logo_GROUP.jpg>

C=C3=A9dric PERLES
Software R&D engineer
SEPRO Robotique - Rue Henry Bessemer - Zone Acti-Est - CS 10084 - 85003 L=
a=20
Roche sur Yon Cedex (France)

Tel : +33 (0)2 51 45 05 31

________________________________

www.sepro-group.com <http://www.sepro-group.com/fr>  | twitter@SeproGroup=
=20
<https://twitter.com/seprogroup>




-----Message d'origine-----
De : Mauro Salvini [mailto:mauro.salvini@smigroup.net]
Envoy=C3=A9 : lundi 20 mars 2017 09:34
=C3=80 : C=C3=A9dric Perles
Cc : xenomai@xenomai.org
Objet : Re: [Xenomai] Trying to install Xenomai 3.0.3 on i.MX6 Kernel 4.1=
.15

On Mon, 2017-03-20 at 08:52 +0100, C=C3=A9dric Perles wrote:
> Hi community,
>
>
>
> I=E2=80=99m a Xenomai newby and I=E2=80=99m trying to install Xenomai 3=
.0.3 on my
> i.MX6 based board (kernel 4.1.15 from NXP).
>
>
>
> So I followed the =E2=80=9CInstalling Xenomai 3.x=E2=80=9D chapter in X=
enomai.org site
> and began to download ipipe-core-4.1.18-arm-8.patch.
>
> Since my kernel is not 4.1.18 but 4.1.15, I had to slightly adapt the
> patch to make it fit.
>
> Then I ran prepare-kernel.sh that tells me everything was OK.
>
> Finally I successfully compiled kernel (and saw a few ipipe and
> xenomai source files were built with into kernel).
>
>
>
> However, when I boot on that newly built kernel there is absolutely no
> xenomai nor ipipe logs into kernel boot logs, and no /proc/xenomai at a=
ll.
>
> I must have missed something or doing something wrong, but I don=E2=80=99=
t see.
>
>
>
> =3D=3D> Did somebody successfully run Xeno 3.0.3 on i.MX6 ?
>
> =3D=3D> What am I doing wrong ?
>
Hi C=C3=A9dric,

I'm using Xenomai 3.0.3 with 4.1.15 kernel from NXP community with succes=
s.

What defconfig have you used to configure your kernel? Before build it, d=
id=20
you check with 'make menuconfig' that i-pipe was enabled?

Regards
Mauro
>
>
> Regards,
>
>
>
> C=C3=A9dric
>
>
>
>
> Sepro
>
> C=C3=A9dric PERLES
> Software R&D engineer
> SEPRO Robotique - Rue Henry Bessemer - Zone Acti-Est - CS 10084 -
> 85003 La Roche sur Yon Cedex (France)
>
> Tel : +33 (0)2 51 45 05 31
>
>   _____
>
>  <http://www.sepro-group.com/fr> www.sepro-group.com |
> <https://twitter.com/seprogroup> twitter@SeproGroup
>
>
>
>
> -------------- next part -------------- A non-text attachment was
> scrubbed...
> Name: image001.jpg
> Type: image/jpeg
> Size: 22984 bytes
> Desc: not available
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20170320/50daa0cf/at
> tachment.jpg>
> -------------- next part -------------- A non-text attachment was
> scrubbed...
> Name: image003.png
> Type: image/png
> Size: 818 bytes
> Desc: not available
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20170320/50daa0cf/at
> tachment.png> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


