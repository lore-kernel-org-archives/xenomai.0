Message-ID: <4469B31E.60506@domain.hid>
Date: Tue, 16 May 2006 13:10:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtdm_event_timedwait non-realtime alternative
References: <200605161221.11119@domain.hid>
In-Reply-To: <200605161221.11119@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA61AA82A4F539DABED58333A"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA61AA82A4F539DABED58333A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Petr Cervenka wrote:
> Hello,
> I need to wait in my ioctl handler for an interrrupt. Is it possible to=
 use some rtdm_event_timedwait alternative in non-realtime?
> I'm thinking about using wait_event_interruptible_timeout. Is it a good=
 idea or is there a better solution (e.g. rtdm_event compatible))?

So your interrupt is RT while one of your waiters is non-RT? Then you
have to forward the RT event (i.e. the IRQ occurrence) via an
rtdm_nrtsig_t from the IRQ handler to an nrtsig-event handler in non-RT
context. This handler can then wakeup non-RT waiters.

This may sound a bit complicated, but you have to remind that there is
no safe way to schedule a non-RT (Linux) thread directly from the RT
(Xenomai) domain, because all Linux scheduling services are fully
preemptible by Xenomai at any time (including the RT IRQ handler).

Hmm, as you were asking for a non-RT-safe rtdm_event now: the pattern I
described above might be generalisable to an extended rtdm_event
supporting both RT and non-RT waiters (non-RT wakers already work). Need
to think about this...

Jan


--------------enigA61AA82A4F539DABED58333A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFEabMeniDOoMHTA+kRAmKDAJ9KoGyrhxDsq3rSCaKv2TE00Q2DSQCYuMMT
wLkKxi68TrXylr/IwQT0fQ==
=CThh
-----END PGP SIGNATURE-----

--------------enigA61AA82A4F539DABED58333A--

