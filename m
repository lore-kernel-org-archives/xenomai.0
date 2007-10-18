Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Oct 2007 17:36:38 +0200
Message-ID: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E016389E6@domain.hid>
In-Reply-To: <47175C6C.9060805@domain.hid>
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E016387F8@domain.hid>
	<47175C6C.9060805@domain.hid>
From: "Thomas Necker" <thomas.necker@domain.hid>
Subject: Re: [Xenomai-help] xnpod_announce_tick when migrating from 2.3 to
	2.4
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

> > I'm trying to migrate our software from 2.3 to 2.4 and I'm=20
> struggling=20
> > with the new timebase concept.
> > Here is how it works in 2.3:
> > - I have a small kernel module that calls xnpod_stop_timer and then=20
> > xnpod_start_timer with a handling function of my own.
> > - This handling function does some housekeeping and then calls=20
> > xnpod_announce_tick to trigger the nucleus (and eventually the pSOS=20
> > skin).
> > This is basically what Philippe suggested about a year ago.
> > Now, all these functions are gone in 2.4, how's the best way to do=20
> > something similar now?
> > I couldn't figure out how the new timebase concept can be=20
> used for that.
> > Thanks in advance.
>=20
> Why do you need to hook into the internals of the timekeeping system?
> Why not simply register some xntimer with the unmodified=20
> core? Sorry in case that the original thread explains this,=20
> but I don't have it at hand.

We ported a pretty large pSOS legacy application that just relied on
that behaviour. And I wanted to make as few changes as possible when
changing to Xenomai. Not only that I was new to Xenomai, I also didn't
oversee all the possible side effects in our application.

