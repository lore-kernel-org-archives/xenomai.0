Message-ID: <49B3DC63.4000209@domain.hid>
Date: Sun, 08 Mar 2009 15:55:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49B3A126.6000602@domain.hid> <49B3CAFF.6090406@domain.hid>
	<49B3D4C9.2000801@domain.hid> <49B3D98C.2070805@domain.hid>
In-Reply-To: <49B3D98C.2070805@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA513A29CAA73D731EDB4D669"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Watchdog / immediate Linux signal delivery
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA513A29CAA73D731EDB4D669
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Linux (e.g. via xnpod_suspend_thread(<cpu-hog>). Unfortunately, ther=
e is
>>>> no way to force a shadow thread into secondary mode to handle pendin=
g
>>>> Linux signals unless that thread issues a syscall once in a while. A=
nd
>>>> that raises the question if we shouldn't improve this as well while =
we
>>>> are on it.
>>>>
>>>> Granted, non-broken Xenomai user space threads always issue frequent=

>>>> syscalls, otherwise the system would starve (and the watchdog would =
come
>>>> around). On the other hand, delaying signals till syscall prologues =
is
>>>> different from plain Linux behaviour...
>>>>
>>>> Comments, ideas?
>>> We discussed the issue of having a way to force threads to relax with=

>>> Philippe, and we both had patches to make this work. However, the iss=
ue
>>> we recently had with the emulated iret on x86 makes me think that we =
can
>>> not relax at any point in time, the code surrounding the relax has to=
 be
>>> made to allow a relax to occur.
>>>
>> Those issues were fixed. If we have similar problems around
>> __ipipe_handle_irq (I would expect the relaxation to take place in
>> xnintr_*_handler), then they should be fixed as well.
>>
>> The problem is that I currently do not see any other way of cleanly
>> terminating or debugging some Xenomai user space thread doing "while
>> (1);" (or any more complicated variation).
>=20
> I am not really opposed to the "force relax upon signal", thing, but th=
e
> current approach used to work, at least with v2.3.x, so it must be my
> recent rework of thread termination which broke things, maybe we can
> repair them?

That was my first impression as well, but I've some feeling that it was
only silently broken so far. IIRC, Xenomai shadow threads must not run
in unmapped state after deleting their nucleus counterpart (but that's
what we do when the watchdog fired!). Rather, proper termination for
shadow threads goes via relaxing and then do_exit.

Jan


--------------enigA513A29CAA73D731EDB4D669
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkmz3GcACgkQniDOoMHTA+lqkACfSScN2JMRFurNXG5lVgs/5wbp
dRAAnjdga6DkAsriIJAZlnwEfu0VLNmi
=4zHS
-----END PGP SIGNATURE-----

--------------enigA513A29CAA73D731EDB4D669--

