Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 3 Feb 2008 14:00:27 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D3768BA@slcmail.slc.mew.int>
In-Reply-To: <18342.10131.452022.345890@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D3768B2@domain.hid>
	<18342.10131.452022.345890@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] periodic issues/watchdog
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

With the watchdog timeout set to 2 seconds, everything runs correctly
both in periodic and aperiodic mode.

Is there an alternate way to sync all threads on a common timebase
rather than periodic timing? I don't understand why periodic timing
requires more CPU usage than aperiodic, when all it has to do is reset
the interrupt. You'd think without calculations for absolute time
expirations, it would be faster.

Steven

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Sunday, February 03, 2008 1:44 PM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] periodic issues/watchdog
>=20
> Steven Seeger wrote:
>  > It seems that for now, I'll have to disable the watchdog as I see
this
>  > behavior with periodic mode or aperiodic mode. (My watchdog timeout
is
>  > set for 1 second.)
>=20
> What happens if you set the timeout to 2 seconds ?
>=20
> --
>=20
>=20
> 					    Gilles Chanteperdrix.

