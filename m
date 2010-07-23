Message-ID: <4C497702.5010100@domain.hid>
Date: Fri, 23 Jul 2010 13:03:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikROCnKiEBnl2W92zNQUNkScJ0reqaKVtS2iFcw@domain.hid>	<4C4960F4.3020306@domain.hid>
	<AANLkTikuw=JJHLsfhevBF8=RA+bXOTd8vnsY7hLD=AEV@mail.gmail.com>
In-Reply-To: <AANLkTikuw=JJHLsfhevBF8=RA+bXOTd8vnsY7hLD=AEV@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] staging_dir install errors
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?R8O2cmtlbSBLYXJhZG/En2Fu?= <gkaradagan@domain.hid>
Cc: xenomai@xenomai.org

G=C3=B6rkem Karado=C4=9Fan wrote:
> $ cd /opt/linux-2.6.33
> $ /opt/xenomai-2.5.3/configure --build=3Di686-pc-linux-gnu
> --host=3Darm-none-linux-gnueabi --enable-arm-mach=3Domap3 --enable-arm-=
tsc
> $ mkdir staging_dir
> $ make DESTDIR=3D/opt/linux-2.6.33/staging_dir install
> =20
> ok i edited my installing document and it works thank you. now how can =
i
> test that? is it work or not?

We also have README.INSTALL. Run latency on the target.

--=20
					    Gilles.


