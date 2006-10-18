Message-ID: <45361870.7060005@domain.hid>
Date: Wed, 18 Oct 2006 14:05:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
References: <1161099585.5024.48.camel@domain.hid>
	<1161167105.5053.34.camel@domain.hid>
In-Reply-To: <1161167105.5053.34.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Tue, 2006-10-17 at 17:39 +0200, Schl=E4gl Manfred jun. wrote:
>=20
> [...]
>=20
>=20
>>1. With enabled kernel-debugging (spin_debug), while loading xeno_nativ=
e
>>(built-in and as module) I get:
>=20
>=20
> [...]
>=20
>=20
>>Is this normal, or could this also depend on a "main-bug".
>>
>=20
>=20
> No, that's absolutely abnormal. Switching the Linux kernel debug option=
s
> on is the usual way most of us work, and no warning should be emitted
> under Xenomai operations. What you get on ARM, and which I cannot
> reproduce on x86, ppc or blackfin, is worrying.

Some ARMs do not boot when spinlock debugging is enabled, so it would be
interesting to check if the error also occurs with I-pipe and Xenomai
off.

--=20
                                                  Gilles Chanteperdrix

