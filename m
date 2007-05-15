Message-ID: <4649C8B6.2050304@domain.hid>
Date: Tue, 15 May 2007 16:50:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DD39B5C3F4963040ADC9768BE7E430CB01EB2004@domain.hid>
	<4649A485.5010102@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01EB20E6@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01EB20E6@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: Quoted-Printable
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
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
> > -----Original Message-----
> > From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
> > Sent: 15. ma=ED 2007 12:16
> > To: Daniel Schnell
> > Cc: xenomai@xenomai.org
> > Subject: Re: [Xenomai-help] memcpy performance on Xenomai
> >
> >
> > Improving clock_gettime overhead by reading directly the tsc is my ve=
ry next task. If you want to check if the effect you measure is the resul=
t of clock_gettime overhead, you can measure the duration of memcpy with =
the native api service rt_timer_tsc, and convert the tsc difference with =
rt_timer_tsc2ns.
>=20
> This was not the culprit. Same results.

Does your processor have a tsc ? If yes, do you compile Xenomai with
--enable-x86-tsc ? What happens if you disable the interruptions ?

>=20
> Does Xenomai replace the memcpy() call with an own implementation ? (I =
don't think so.)
>=20
> What about trashing of cash lines through context switches ? But then i=
f we run it on Linux alone we should also have trashed cache lines. There=
 should not be any difference.
> Is maybe the presence of a Xenomai POSIX thread cause a lot of ctx swit=
ches, even if only a memcpy is executed inside the thread ? Shouldn't Xen=
omai threads run totally uninterrupted if they have the highest prio ?
>=20
> Please could somebody actually run this test on his hardware and see if=
 these differences between Xenomai POSIX skin and Linux native are happen=
ing there as well ?

If you want us to test the code, please send it, I mean the one adapted
to the native skin.

--=20
                                                 Gilles Chanteperdrix

