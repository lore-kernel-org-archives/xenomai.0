Date: Sun, 30 Aug 2015 13:27:54 +0000 (UTC)
From: =?UTF-8?Q?=E2=80=ABMohamed_Fawzy=E2=80=AC_=E2=80=AB?=
 <m.fawzy307@yahoo.com>
Message-ID: <344433068.3425598.1440941274716.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <20150830131052.GI20679@hermes.click-hack.org>
References: <20150830131052.GI20679@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] =?utf-8?b?2KjYrti12YjYtTogIHhlbm9tYWkgb24gZGViaWFu?=
Reply-To: =?UTF-8?Q?=E2=80=ABMohamed_Fawzy=E2=80=AC_=E2=80=AB?=
 <m.fawzy307@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi=C2=A0=C2=A0 Gilles.=C2=A0
sorry if my question wasn't clear but i told all i did=C2=A0
=C2=A0
i downloaded debian version for my udo board from here=C2=A0
http://www.udoo.org/downloads/

then followed the instructions :

apt-get install devscripts debhelper dh-kpatches findutilsapt-get install g=
it-core git-buildpackagegit clone git://xenomai.org/xenomai-2.6.gitcd xenom=
ai-2.6 && git fetch origingit checkout -b v2.6.0-deb v2.6.0xenomai-2.6$ DEB=
EMAIL=3D"m.fawzy307@yahoo.com" DEBFULLNAME=3D"mohamed" \debchange -v 2.6.0 =
Release 2.6.0git commit -a -m 2.6.0git-buildpackage \--git-debian-branch=3D=
v2.6.3-deb =C2=A0\--git-export-dir=3D.. =C2=A0 \-uc -us=C2=A0

so i don't know the =C2=A0I-pipe patch=C2=A0=C2=A0Regards ,=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0

      =D9=85=D9=86: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
 =D8=A5=D9=84=D9=89: =E2=80=ABMohamed Fawzy=E2=80=AC =E2=80=AB <m.fawzy307@=
yahoo.com>=20
=D9=86=D8=B3=D8=AE=D8=A9 =D9=83=D8=B1=D8=A8=D9=88=D9=86=D9=8A=D8=A9: "xenom=
ai@xenomai.org" <xenomai@xenomai.org>=20
 =D8=AA=D8=A7=D8=B1=D9=8A=D8=AE =D8=A7=D9=84=D8=A5=D8=B1=D8=B3=D8=A7=D9=84:=
 =D8=A7=D9=84=D8=A3=D8=AD=D8=AF 30 =D8=A3=D8=BA=D8=B3=D8=B7=D8=B3=D8=8C 201=
5=E2=80=8F 3:10 =D9=85
 =D8=A7=D9=84=D9=85=D9=88=D8=B6=D9=88=D8=B9: Re: [Xenomai] xenomai on debia=
n
  =20
On Sun, Aug 30, 2015 at 12:34:35PM +0000, =E2=80=ABMohamed Fawzy=E2=80=AC =
=E2=80=AB wrote:


> i followed these instructions to install xenomai 2.6.0 on debian wheezy=
=C2=A0
> http://xenomai.org/2014/06/building-debian-packages/
> but when i built=C2=A0the packages using (debuild -uc -us )i got this mes=
sge and build failed=C2=A0
>=20
>=20
> {standard input}: Assembler messages:{standard input}:144: Error: thumb c=
onditional instruction should be in IT block -- `strexeq r0,r1,[r3]'{standa=
rd input}:538: Error: thumb conditional instruction should be in IT block -=
- `strexeq r5,r4,[r3]'
>=20
> what's the wrong with me ?=C2=A0

As usual, you do not give us enough information. What I-pipe patch
are you using? You get this error when compiling which file? What
version of gcc are you using?

IOW: please read:
https://xenomai.org//asking-for-help/

--=20
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 Gilles.
https://click-hack.org


  
