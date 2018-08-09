Date: Thu, 9 Aug 2018 17:48:14 +0300 (EEST)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <2083420812.26300683.1533826094280.JavaMail.zimbra@triolcorp.com.ua>
In-Reply-To: <220836364.25837204.1533717370253.JavaMail.zimbra@triolcorp.com.ua>
References: <220836364.25837204.1533717370253.JavaMail.zimbra@triolcorp.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] qt creator IDE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

if somebody need
How to work with

to work with Qt creator should add such lines to .pro file
to use Xenomai at userspace

XENO_DIR =3D /usr/xenomai
XENO_CONFIG =3D $$XENO_DIR/bin/xeno-config
XCFLAGS  =3D $(shell  $$XENO_CONFIG --posix --alchemy --cflags)
XLDFLAGS =3D $(shell  $$XENO_CONFIG --posix --alchemy --ldflags)
QMAKE_CXXFLAGS +=3D$$XCFLAGS
LIBS +=3D$$XLDFLAGS

don't forget  re-run Qmake   to changes will take effect

=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.

----- Original Message -----
From: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
To: "xenomai" <xenomai@xenomai.org>
Sent: =D1=F0=E5=E4=E0, 8 =C0=E2=E3=F3=F1=F2 2018 =E3 11:36:10
Subject: [Xenomai] qt creator IDE

Good day!=20
I want to use qt creator IDE to write Xenomai user-space code=20
If somebody use it=20
Could you share .pro or Makefile for such project?=20
Thank you=20


_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai

