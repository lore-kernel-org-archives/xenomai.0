Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 May 2007 14:40:18 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01EB20E6@domain.hid>
In-Reply-To: <4649A485.5010102@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB01EB2004@domain.hid>
	<4649A485.5010102@domain.hid>
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

This was not the culprit. Same results.

Does Xenomai replace the memcpy() call with an own implementation ? (I =
don't think so.)

What about trashing of cash lines through context switches ? But then if =
we run it on Linux alone we should also have trashed cache lines. There =
should not be any difference.
Is maybe the presence of a Xenomai POSIX thread cause a lot of ctx =
switches, even if only a memcpy is executed inside the thread ? =
Shouldn't Xenomai threads run totally uninterrupted if they have the =
highest prio ?

Please could somebody actually run this test on his hardware and see if =
these differences between Xenomai POSIX skin and Linux native are =
happening there as well ?


Best regards,

Daniel Schnell


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: 15. ma=ED 2007 12:16
To: Daniel Schnell
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] memcpy performance on Xenomai


Improving clock_gettime overhead by reading directly the tsc is my very =
next task. If you want to check if the effect you measure is the result =
of clock_gettime overhead, you can measure the duration of memcpy with =
the native api service rt_timer_tsc, and convert the tsc difference with =
rt_timer_tsc2ns.

--=20
                                                 Gilles Chanteperdrix

