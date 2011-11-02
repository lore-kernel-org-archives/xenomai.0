Message-ID: <4EB16341.2060103@domain.hid>
Date: Wed, 02 Nov 2011 16:35:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAAeYjMmZxEkFRfKx8DPUen+RtzijdBn3PTBLkMNjbP74K_c84w@domain.hid>
In-Reply-To: <CAAeYjMmZxEkFRfKx8DPUen+RtzijdBn3PTBLkMNjbP74K_c84w@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] error messages
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?xYF1a2FzeiBTYWNoYQ==?= <dragilla@domain.hid>
Cc: xenomai@xenomai.org

On 11/02/2011 01:15 AM, =C5=81ukasz Sacha wrote:
> I managed to install xenoami 2.5.6 on my mini (with kernel 2.6.35.9).
> However I'm having problems even running the test scripts.
> For example the ouput of xeno-test is provided as an attachment, it
> looks somewhat like this:
>=20
> /usr/xenomai/bin/xeno-load: line 247: /usr/xenomai/bin/latency: not fou=
nd
>=20
> /usr/xenomai/bin # ls -al latency
> -rwxr-xr-x    1 root     root         29528 Nov  1  2011 latency
>=20
> Any hint on what's causing the errors?

Mismatch between libraries in the toolchain, and libraries installed?
Especially the loader ld-linux.so. Please try and copy ldd to the board
filesystem and try the command:
ldd /usr/xenomai/bin/latency

--=20
                                                                Gilles.


