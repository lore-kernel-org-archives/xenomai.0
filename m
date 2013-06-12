Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <CAFNBfte827XTvCApOaGaUYVcj_uLn67Yz5=qBcY4pmAPEHVbvg@mail.gmail.com>
Date: Wed, 12 Jun 2013 17:02:14 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A5AAC86-19FD-4D29-9E02-516AD9D996BD@mah.priv.at>
References: <51B73421.3050506@siemens.com>
	<CAFNBfte827XTvCApOaGaUYVcj_uLn67Yz5=qBcY4pmAPEHVbvg@mail.gmail.com>
Subject: Re: [Xenomai] Stable update for ipipe-3.8
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gentlemen in the know,

Am 12.06.2013 um 16:26 schrieb Flavio Castro Alves Filho =
<flavio.alves@gmail.com>:

> Hello,
>=20
> This weekend I'll try to test it with the current kernel version for
> BeagleBone Black and I'll let you know about the results.

since I venture the same, please clarify: would I merge this branch over =
stock v3.8.13 _after_ or _before_ vendor patches?

working theory: before, but I'll stand corrected

-m

>=20
> 2013/6/11 Jan Kiszka <jan.kiszka@siemens.com>:
>> Hi all,
>>=20
>> I've merged 3.8.13 into our stable 3.8 branch. This triggered some =
minor
>> conflicts in generic and ARM code. Please see
>>=20
>> git://git.xenomai.org/ipipe-jki for-upstream/3.8
>>=20
>> for details. The result works fine for x86, and if it's also OK for =
the
>> other arch, I'd propose this to be merged into the official 3.8 =
stable
>> branch.
>>=20
>> Jan
>>=20
>> --
>> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
>> Corporate Competence Center Embedded Linux
>>=20
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
>=20
>=20
>=20
> --=20
> Flavio de Castro Alves Filho
>=20
> flavio.alves@gmail.com
> www.linuxembarcado.com
> Twitter: http://twitter.com/#!/fraviofii
> LinkedIn profile: www.linkedin.com/in/flaviocastroalves
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai


