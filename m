Message-ID: <46BB0777.7010907@domain.hid>
Date: Thu, 09 Aug 2007 14:24:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <op.twsifzeqt06gyn@domain.hid>
In-Reply-To: <op.twsifzeqt06gyn@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC455F6082445355C2F4EDF53"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Sourcecode 16550A.c
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Axel Beierlein <belatronix@domain.hid>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC455F6082445355C2F4EDF53
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Axel Beierlein wrote:
> Hello Jan,
>=20
> could you explain me the meaning of the variable in_nwait, in_tail and =
=20
> in_npend of the rt_16550_context structure?
> Especially i?ll try to find out the functionality of the if statements =
=20
> behind the while in rt_16650_interrupt(...).
>=20
> Or, do you have a more commented Version?

struct rt_16550_context {
	struct rtser_config config;	/* current device configuration */

	rtdm_irq_t irq_handle;		/* device IRQ handle */
	rtdm_lock_t lock;		/* lock to protect context struct */

	unsigned long base_addr;	/* hardware IO base address */
#ifdef CONFIG_XENO_DRIVERS_16550A_ANY
	int io_mode;			/* hardware IO-access mode */
#endif
	int tx_fifo;			/* cached global tx_fifo[<device>] */

	int in_head;			/* RX ring buffer, head pointer */
	int in_tail;			/* RX ring buffer, tail pointer */
	size_t in_npend;		/* pending bytes in RX ring */
	int in_nwait;			/* bytes the user waits for */
	rtdm_event_t in_event;		/* raised to unblock reader */
	char in_buf[IN_BUFFER_SIZE];	/* RX ring buffer */
	volatile unsigned long in_lock;	/* single-reader lock */
	uint64_t *in_history;		/* RX timestamp buffer */

	int out_head;			/* TX ring buffer, head pointer */
	int out_tail;			/* TX ring buffer, tail pointer */
	size_t out_npend;		/* pending bytes in TX ring */
	rtdm_event_t out_event;		/* raised to unblock writer */
	char out_buf[OUT_BUFFER_SIZE];	/* TX ring buffer */
	rtdm_mutex_t out_lock;		/* single-writer mutex */

	uint64_t last_timestamp;	/* timestamp of last event */
	int ioc_events;			/* recorded events */
	rtdm_event_t ioc_event;		/* raised to unblock event waiter */
	volatile unsigned long ioc_event_lock;	/* single-waiter lock */

	int ier_status;			/* IER cache */
	int mcr_status;			/* MCR cache */
	int status;			/* cache for LSR + soft-states */
	int saved_errors;		/* error cache for RTIOC_GET_STATUS */
};

There are a few "volatiles" less in the above version. For in_nwait
becoming truely non-volatile, some code changes to rt_16550_read() are
pending (need more review). Will commit later.

[Sometimes it's good to be forced to look at old code again and rethink
if everything is already/still perfect...]

Jan


--------------enigC455F6082445355C2F4EDF53
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGuwd3niDOoMHTA+kRAhqqAJ9ensequP+Mib8EmiLwvws57m1SkwCggxhJ
leNJnLjH0ClahzfJ9MkvtMw=
=frUa
-----END PGP SIGNATURE-----

--------------enigC455F6082445355C2F4EDF53--

