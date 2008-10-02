Message-ID: <48E4E49A.3050206@domain.hid>
Date: Thu, 02 Oct 2008 17:11:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48E4A6C3.3080508@domain.hid> <48E4B927.6010706@domain.hid>
	<48E4D3A6.5010401@domain.hid> <48E4D6E2.1030309@domain.hid>
	<48E4E3E9.3020907@domain.hid>
In-Reply-To: <48E4E3E9.3020907@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] cross-compiling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Malek <souf_oued@domain.hid>
Cc: xenomai@xenomai.org

Malek wrote:
> Gilles Chanteperdrix a =E9crit :
>> Malek wrote:
>>>    $ ./configure --target=3Di686-linux --host=3Di686-linux --build=3Di3=
86-pc-linux-gnu=20
>>> --prefix=3D/usr --exec-prefix=3D/usr --sysconfdir=3D/etc --prefix=3D/us=
r/xenomai=20
>>> --disable-smp --disable-x86-sep --enable-x86-tsc
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> (...)
>>> The architecture of the host is x86 under (cross)uClibc (0.9.29), (cros=
s)GCC: 4.2.4,
>>> (cross)binutils 2.18.50.0.1, Xenomai 2.4.5.
>> So, you are compiling on x86 for x86 ? You are not cross-compiling then.
> Possible !!!
>> If your host is x86_64 and you are compiling for x86_32, you should pass
>> the -m32 option to gcc.
>>
> My host is x86_32 (Fedora 9) also but I do not use gcc that comes with Fe=
dora,
> I used Buildroot(http://buildroot.uclibc.org) to produce an isolated comp=
ilation=20
> environment for another x86_32, it looks like LFS (Linux From Scratch).

LFS meant LARGEFILE_SOURCE or Large File Support, or something like that.

> -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64

That is the problem I suspected. Will fix, thanks for reporting.

--=20
                                                 Gilles.

