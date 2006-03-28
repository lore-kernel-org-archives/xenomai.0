Message-ID: <44296668.10300@domain.hid>
Date: Tue, 28 Mar 2006 18:38:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] gigabit rate packet processing with xenomai
References: <2cf1ee820603280009r5adec759h99aa69809f68b457@domain.hid>
In-Reply-To: <2cf1ee820603280009r5adec759h99aa69809f68b457@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFEEF7EDA1DF96746A258C600"
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
To: emin ak <eminak71@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFEEF7EDA1DF96746A258C600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

emin ak wrote:
> Dear All;
> I'am new with xenomai (and also adeos), firstly I would like to thank=20
> who contributed to this project for this  high quality job. I have an
> project that needs gigabit rate ethernet packet processing in user
> space and need your recommendations.
> I want to archive this with minimal kernel level device driver changes.=

>  According to my plan, I'll create a realtime user level thread and
> this thread sleeps (with the mutex machanism in the native api) until

In general, mutexes are not the right mechanism to wait on a specific
event, they are used to synchronise concurrent access to resources. What
you are likely looking for are e.g. semaphores.

> receiving a valid ethernet packet on ethernet interface that is
> working regular linux domain. After receiving the packet, ethernet
> driver releases the lock and sends packet to user level thread (with
> shared memory or an other way).With this way, I have left the device
> driver in linux domain, I'll only need to add locking and shared
> memory system in the device driver.Does this system work? Does the

Not very well (which means: not deterministically). You need to put the
driver under Xenomai control to achieve predictable latencies.

> user level thread affect the functionallty of ethernet interface?Do I
> need to implement all my user space thread and kernel level driver in
> primaly domain?

Yep, but you might be lucky: there is one Gigabit Ethernet driver
already available with RTnet (Realtek 8169). If you are only looking for
deterministic packet processing in an arbitrary network, you just have
to load the RTnet core and the rt_r8169 driver, and then you can
register your protocol types for sending and receiving (via rt-packet
sockets). There are also examples available with RTnet. Feel free to ask
for more details on the RTnet list.

Jan


--------------enigFEEF7EDA1DF96746A258C600
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEKWZoniDOoMHTA+kRAj5nAJ9DlwRaT3VdKgj1aOnBQ7cW06aSwgCfbKSM
c1Y9mPJuiWF1+3PR53OZl0M=
=rZxZ
-----END PGP SIGNATURE-----

--------------enigFEEF7EDA1DF96746A258C600--

