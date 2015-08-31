Date: Mon, 31 Aug 2015 08:09:14 +0000 (UTC)
From: =?UTF-8?Q?=E2=80=ABMohamed_Fawzy=E2=80=AC_=E2=80=AB?=
 <m.fawzy307@yahoo.com>
Message-ID: <795260343.3753533.1441008554562.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <20150831012041.GO15616@csclub.uwaterloo.ca>
References: <20150831012041.GO15616@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] =?utf-8?b?2KjYrti12YjYtTogINio2K7YtdmI2LU6ICB4ZW5vbWFp?=
 =?utf-8?q?_on_debian?=
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
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

thanks for your reply=C2=A0
i succeed to build and The build results in the following packages:
xenomai-runtime =E2=80=93 Xenomai runtime utilitieslibxenomai1 =E2=80=93 Sh=
ared libraries for Xenomailibxenomai-dev =E2=80=93 Headers and static libra=
ries for Xenomaixenomai-kernel-source =E2=80=93 Sources of the Xenomai 2.x =
kernelxenomai-doc =E2=80=93 Xenomai documentation
then i installed them using (dpkg -i *.deb )

now , how i can test xenomai ?

      =D9=85=D9=86: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
 =D8=A5=D9=84=D9=89: =E2=80=ABMohamed Fawzy=E2=80=AC =E2=80=AB <m.fawzy307@=
yahoo.com>=20
=D9=86=D8=B3=D8=AE=D8=A9 =D9=83=D8=B1=D8=A8=D9=88=D9=86=D9=8A=D8=A9: Gilles=
 Chanteperdrix <gilles.chanteperdrix@xenomai.org>; "xenomai@xenomai.org" <x=
enomai@xenomai.org>=20
 =D8=AA=D8=A7=D8=B1=D9=8A=D8=AE =D8=A7=D9=84=D8=A5=D8=B1=D8=B3=D8=A7=D9=84:=
 =D8=A7=D9=84=D8=A5=D8=AB=D9=86=D9=8A=D9=86 31 =D8=A3=D8=BA=D8=B3=D8=B7=D8=
=B3=D8=8C 2015=E2=80=8F 3:20 =D8=B5
 =D8=A7=D9=84=D9=85=D9=88=D8=B6=D9=88=D8=B9: Re: [Xenomai] =D8=A8=D8=AE=D8=
=B5=D9=88=D8=B5: xenomai on debian
  =20
On Sun, Aug 30, 2015 at 01:30:23PM +0000, =E2=80=ABMohamed Fawzy=E2=80=AC =
=E2=80=AB wrote:
> i tried 2.6.0 because when i searched for xenomai package for debian whee=
zy in this site=C2=A0
> https://packages.debian.org/source/wheezy/devel/
> i found it is xenomai 2.6.0=C2=A0
> can i use 2.6.4 ?

Building a debian package using the debian/* files in the current
xenomai-2.6 git tree works fine for me.=C2=A0 The packages in Debian are
ancient and a waste of time.

Now for patching your kernel with ipipe and xenomai, that's a separate


problem.

--=20
Len Sorensen


  
