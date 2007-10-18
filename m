Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Oct 2007 17:58:12 +0200
Message-ID: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E01638A0D@esealmw118.eemea.ericsson.se>
In-Reply-To: <1192716605.5884.35.camel@domain.hid>
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E016387F8@domain.hid>
	<1192714042.5884.20.camel@domain.hid>
	<1192715021.5884.32.camel@domain.hid>
	<1192716605.5884.35.camel@domain.hid>
From: "Thomas Necker" <thomas.necker@domain.hid>
Subject: Re: [Xenomai-help] xnpod_announce_tick when migrating from 2.3 to2.4
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

> > > The only difference compared to your current approach is that
> > Xenomai
> > > will have processed the incoming tick before calling your hook, so
> > you
> > > don't need to forward the tick anymore. Sidenote: this only works
> > with
> > > periodic timebases so far.
> > >=20
> >=20
> > Actually, I now think we should rather implement to the traditional=20
> > "daisy-chain" pattern here, with the user-defined hook=20
> being called in=20
> > replacement of the genuine tick processing code, and the=20
> hook expected=20
> > to call into xntbase_tick() to signal the incoming tick=20
> when it sees=20
> > fit. This would allow the skin to implement time slowdowns etc.
> >=20
> > Thomas, I'm going to send a patch asap to this end. Please=20
> rely on the=20
> > common behaviour (i.e. daisy-chain) you would expect from pSOS.
>=20
> Here we are. This patch is against 2.4-rc4, and allows to=20
> implement a daisy-chain of tick handlers.

Thanks for the quick fix. We were just discussing if (and if yes what
kind of) implications it has when the housekeeping is done afterwards.
It currently relies on being called before the nucleus gets the tick.
But of course I'm happy when the behaviour stays 2.3-like.
In the course of this discussion we thought about rewriting our code
so that we don't need the hook anymore. This could be possible with
moderate effort if there were some global variable available that
just counts the ticks and that could be read by the application. Is
there something like that available?

Btw:
ksrc/skins/psos+ needs an EXPORT_SYMBOL(psos_tbase) added at the
end for the patch to work.

Thanks again,
Thomas

