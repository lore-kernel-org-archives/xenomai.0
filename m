Message-ID: <48BE2B29.6070608@domain.hid>
Date: Wed, 03 Sep 2008 08:14:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <ff1d78710809020250g57e6d871kf9284a46ae4685ec@domain.hid>	
	<48BD13F1.2010300@domain.hid>
	<ff1d78710809020518o6bc21376k6d06544754b85aa@domain.hid>
In-Reply-To: <ff1d78710809020518o6bc21376k6d06544754b85aa@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE27B9BE05323520969A2E534"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Kernel Oops calling rt_dev_close
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Kauffmann <steven.kauffmann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE27B9BE05323520969A2E534
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Steven Kauffmann wrote:
> On Tue, Sep 2, 2008 at 12:22 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Steven Kauffmann wrote:
>>> Hi all,
>>>
>>> I'm getting Kernel oops when calling rt_dev_close in my application
>>> [*]. The application creates a new real-time task and in this task
>>> rt_dev_recvfrom is waiting for incoming CAN messages.
>>>
>>> In the close function of the application I first call rt_dev_close an=
d
>>> after that I kill the thread with rt_task_delete. I also wait for the=

>>> termination of this thread with rt_task_join. But when rt_dev_close i=
s
>>> called, the kernel oops occurs.
>> Do you have a (small) test case for this issue? Does it work with a
>> virtual CAN device as well? That would be the fastest way to track dow=
n
>> the issue.
>=20
> The test case (see attached file) reproduces the kernel oops.
>=20
> The kernel oops also occurs when using the virtual CAN device.

Fixed both in SVN HEAD and 2.4.x. I also happen to fix a nasty 64-bit
issue of RTDM at this chance.

But you now have to fix your test case as well: read_can() will enter a
tight endless loop when you close the socket underneath it and don't
check for the error rt_dev_recvfrom returns.

Jan


--------------enigE27B9BE05323520969A2E534
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAki+Ky4ACgkQniDOoMHTA+nm6QCeI98xPZIvKd7akE9fcKWbQE7F
Fr4AnA8REGSpwUpznilXUK+Glkmox8Hd
=9dfN
-----END PGP SIGNATURE-----

--------------enigE27B9BE05323520969A2E534--

