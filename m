Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 May 2007 15:28:53 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01EB2122@domain.hid>
In-Reply-To: <4649C8B6.2050304@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB01EB2004@domain.hid>
	<4649A485.5010102@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01EB20E6@domain.hid>
	<4649C8B6.2050304@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: Re: [Xenomai-help] memcpy performance on Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

Some interesting insights about my last tests.

1.) The culprit is mlockall(MCL_FUTURE|MCL_CURRENT);

As soon I leave this away, I get much better results:

Without mlockall():
Test (10) memcpy of sizes (10485760)
10 memcpy. Time per memcpy: 78147209 [nsec] (134 MB/sec)
 finished.

With mlockall():
Test (10) memcpy of sizes (10485760) ....
10 memcpy. Time per memcpy: 124194618 [nsec] (84 MB/sec)
 finished.

Then again I cannot use Xenomai without mlockall()=20
:(

2.) rt_timer_tsc
If I use clock_gettime() this needs 3100 ns,
If I use rt_timer_tsc() this needs 74 (!) ns.


Oooh, we are using clock_gettime() a lot, so this makes a big difference =
for us.

Best regards,

--=20
Daniel Schnell                   | daniel.schnell@domain.hid
Hugb=FAna=F0arger=F0                   | www.marel.com

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: 15. ma=ED 2007 14:51
To: Daniel Schnell
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] memcpy performance on Xenomai

Daniel Schnell wrote:
> > -----Original Message-----
> > From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> > Sent: 15. ma=ED 2007 12:16
> > To: Daniel Schnell
> > Cc: xenomai@xenomai.org
> > Subject: Re: [Xenomai-help] memcpy performance on Xenomai
> >
> >
> > Improving clock_gettime overhead by reading directly the tsc is my =
very next task. If you want to check if the effect you measure is the =
result of clock_gettime overhead, you can measure the duration of memcpy =
with the native api service rt_timer_tsc, and convert the tsc difference =
with rt_timer_tsc2ns.
>=20
> This was not the culprit. Same results.

Does your processor have a tsc ? If yes, do you compile Xenomai with =
--enable-x86-tsc ? What happens if you disable the interruptions ?

>=20
> Does Xenomai replace the memcpy() call with an own implementation ? (I =

> don't think so.)
>=20
> What about trashing of cash lines through context switches ? But then =
if we run it on Linux alone we should also have trashed cache lines. =
There should not be any difference.
> Is maybe the presence of a Xenomai POSIX thread cause a lot of ctx =
switches, even if only a memcpy is executed inside the thread ? =
Shouldn't Xenomai threads run totally uninterrupted if they have the =
highest prio ?
>=20
> Please could somebody actually run this test on his hardware and see =
if these differences between Xenomai POSIX skin and Linux native are =
happening there as well ?

If you want us to test the code, please send it, I mean the one adapted =
to the native skin.

--=20
                                                 Gilles Chanteperdrix

