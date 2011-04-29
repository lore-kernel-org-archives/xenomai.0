Message-ID: <4DBB05A6.10704@domain.hid>
Date: Fri, 29 Apr 2011 20:38:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1QFme6-0000lI-Pf@domain.hid>
In-Reply-To: <E1QFme6-0000lI-Pf@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : x86: Fix return type
 of DO_SYSCALL_INNER macro
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

GIT version control wrote:
> Module: xenomai-jki
> Branch: for-upstream
> Commit: 852c130d16410a597536c39d06b6abd1c9c6c822
> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=3D852c=
130d16410a597536c39d06b6abd1c9c6c822
>=20
> Author: Jan Kiszka <jan.kiszka@domain.hid>
> Date:   Fri Apr 29 14:12:13 2011 +0200
>=20
> x86: Fix return type of DO_SYSCALL_INNER macro
>=20
> gcc will complain about 'conversion to =E2=80=98int=E2=80=99 from =E2=80=
=98long int=E2=80=99 may alter
> its value' with -Wconversion as DO_SYSCALL treats the return value of
> DO_SYSCALL_INNER as int. Align DO_SYSCALL_INNER to its user.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

Should not it be aligned the other way around? Using longs everywhere?
In case a syscall returns a pointer?

--=20
                                                                Gilles.


