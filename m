Message-ID: <4607EA58.1070004@domain.hid>
Date: Mon, 26 Mar 2007 17:44:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Spinlock question.
References: <4607E038.8070505@domain.hid>
In-Reply-To: <4607E038.8070505@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDBFA7995E6B7E1BD8BAF8C4A"
Sender: jan.kiszka@domain.hid
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDBFA7995E6B7E1BD8BAF8C4A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Hi,
>=20
> I am porting a network driver from Linux to RTnet, and I have a sudden
> doubt about what I am doing: is it safe to call a function like
> wake_up_interruptible, from a non real-time context, with CONFIG_PREEMP=
T
> enabled, while holding an rthal spinlock ? Do not I risk a rescheduling=

> with the spinlock locked ?

Mmh, doesn't stalling the primary domain (what rthal_spin_lock_irqsave
surely does) also make the root domain think it is running in interrupt
context, thus will prevent any Linux reschedule?

However, there is one big fat issue with this approach:
wake_up_interruptible takes some Linux spin lock. So you must never call
it from primary context on UP to avoid corruption. And an SMP, you
create a nice source for priority inversion: CPU2 holds wait_queue lock,
gets preempted by Xenomai and runs some longer low-prio RT job.
Meanwhile CPU1 tries to acquire wait_queue as well with IRQs disabled,
blocking any RT task on that CPU.

Better defer the Linux wake-up via a rtdm_nrtsig. Alternatively, make
the Linux waiter also a Xenomai task and use a rtdm_event e.g. (mmh,
maybe we should discuss the auto-shadow-any-Linux-task-on-demand feature
for Xenomai once again...).

Jan


--------------enigDBFA7995E6B7E1BD8BAF8C4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGB+pYniDOoMHTA+kRAmqdAJ9cPexJIwRbR9e/ufJ2O0rGmyE3tgCcCMwJ
w9ACzylUU9HuKOxWN3sLFfA=
=MSju
-----END PGP SIGNATURE-----

--------------enigDBFA7995E6B7E1BD8BAF8C4A--

