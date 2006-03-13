From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] RTDM and Timer functions
Date: Mon, 13 Mar 2006 14:31:35 -0300
References: <200603091443.25714.lbocseg@domain.hid> <4411C646.80802@domain.hid>
	<17429.43814.412464.35016@domain.hid>
In-Reply-To: <17429.43814.412464.35016@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603131431.35216.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Em Segunda 13 Mar=3DE7o 2006 14:25, Gilles Chanteperdrix escreveu:

>Jan Kiszka wrote:
> > > Sometimes the result is "Should be near 84000: 100000", that is kind =
=3D
of
> > > correct, since the tickval is 100000, although I think that those
> > > functions in the RTDM driver context should be independent of the tick
> > > value set by the user program... Maybe using oneshot in the driver
> > > calls and periodic in the application... I really don't know what wou=
=3D
ld
> > > be the best approach here...
> >
> > rtdm_clock_read always uses the nucleus clock. Using something different
> > (e.g. always TSC) would break applications specifying absolute times
> > derived from the return values of other skins' functions.
>
>Maybe adding a service to RTDM would allow users to measure short time
>intervals with RTDM using the TSC ?
>
>The native (rt_timer_tsc()) and posix (clock_gettime(CLOCK_MONOTONIC))
>skins have a way to do this.

This would fit great for my needs (and most developers I think)!

Thanks for the suggestion,

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


