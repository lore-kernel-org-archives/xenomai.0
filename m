Message-ID: <4C2B0043.1070108@domain.hid>
Date: Wed, 30 Jun 2010 10:28:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <22150A2C94CC924695BE248F94CD11F2CD0F@EXDB4.ug.kth.se>
	<4C2A518F.8030302@domain.hid>
	<22150A2C94CC924695BE248F94CD11F2CDC2@domain.hid>
In-Reply-To: <22150A2C94CC924695BE248F94CD11F2CDC2@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai and Gumstix Overo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fredrik Asplund <fasplund@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Fredrik Asplund wrote:
>> Xenomai 2.5.3 was tested on OMAP3 with the mainline kernel. If you=20
>> absolutely want to use this vendor branch, you will have to fix the
>>  patch rejects by hand.
>=20
> Ok, yes, I thought so. I guess I was hoping someone had done the same
> thing and had some pointers on what to do in this specific case (i.e.
> applying Xenomai using Bitbake on a vendor branch).
>=20
> I will try to apply the patch rejects (I want to deviate from the
> original setup as little as possible, at least to begin with)

If you do not want to deviate from Xenomai usual setup, use the mainline
kernel. If I were you, I would have serious doubts on a vendor kernel
which touches generic files such as include/asm/cacheflush.h in order to
add some board-specific code.

, but
> when I went through the source folder I couldn=C2=B4t find any "*.rej"
> files (even though the log suggests they were created). Do I need to
> call the prepare-kernel.sh script differently somehow or is the
> problem in my tool environment?

The log is the result of running patch in "dry-run" mode, so that if it
fails, prepare-kernel.sh does not break your sources. Apply the adeos
patch by hand with the patch command. Once the sources are fixed,
prepare-kernel.sh will be able to detect that your kernel is already
patched and will skip that step.

>=20
> / Fredrik


--=20
					    Gilles.


