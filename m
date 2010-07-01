Message-ID: <4C2C65C5.8020708@domain.hid>
Date: Thu, 01 Jul 2010 11:54:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <22150A2C94CC924695BE248F94CD11F2CD0F@EXDB4.ug.kth.se>	<4C2A518F.8030302@domain.hid>	<22150A2C94CC924695BE248F94CD11F2CDC2@domain.hid>	<4C2B0043.1070108@domain.hid>	<AANLkTikdRdEXJd97HKlWzUmon8bu94n-ATNozWyOmTOu@domain.hid>
	<22150A2C94CC924695BE248F94CD11F2CFB8@domain.hid>
	<22150A2C94CC924695BE248F94CD11F2CFEB@EXDB4.ug.kth.se>
In-Reply-To: <22150A2C94CC924695BE248F94CD11F2CFEB@EXDB4.ug.kth.se>
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
>>> I am actually trying to do the exact same thing.
>> Looking at forums and email archives it seems a lot of
>> people have been trying to do this, but that no-one has posted their r=
esults. :/
>>
>>> Anyway, I've managed to change the files manually - the changes seem =

>>> very minor (the changes in include/asm/cacheflush.h just move a=20
>>> function elsewhere, no code changes at all).
>> I have attached a patch file showing the changes I have done (and an u=
pdated Adeos patch file). This was
>> fairly trivial, but I guess the problem could be if Gumstix have added=
 some changes which will require
>> additional patching for Adeos. Anyway, could you share a patch file of=
 exactly what you have changed?
>>
>>> So, any clues? I can send my changes and logs tomorrow morning, if th=
ey are of any help.
>> Sure, please do so. I don=C2=B4t have much time to put on this, so I h=
ave actually only have
>> had to go through the source files since yesterday. Today (or during t=
he weekend if I don=C2=B4t
>> get the time) I will create a new defconfig file, compile, test and de=
bug. If you have
>> updated BitBake file, Defconfig file, Logs, etc., please share them.
>=20
> Sorry,
> I attached the wrong updated Xenomai Patch file, this is the one I use.=

> / Fredrik

Ok. Next time you post this patch, could you give the attached file a
less confusing name? Such as
adeos-ipipe-2.6.33-arm-1.16-01-overo-sakoman.diff

calling it adeos_blabla_updated.diff could give the impression that it
is an updated adeos patch.

--=20
					    Gilles.


