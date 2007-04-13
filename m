Message-ID: <461FF950.7080608@domain.hid>
Date: Fri, 13 Apr 2007 23:42:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <461FE560.8070100@domain.hid>
In-Reply-To: <461FE560.8070100@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE748F4B3A013FCA6E2351EEB"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Execution error with rtdm heartbeat example
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jean-Luc Pamart <jlpamart@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE748F4B3A013FCA6E2351EEB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jean-Luc Pamart wrote:
> Hello
>=20
> I  try to execute the heartbeat example (xenomai 2.3 with kernel 2.6.19=
)
> With the unmodified sources when the heartbeat module
> is being unloaded (rmmod)  I obtain :
>=20
> atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying=20
> access hardware directly. =20
>=20
> and the unloading can't be finished.
>=20
> I try to slightly change the sources. It works with no bad kernel=20
> message and
> complete unloaded with this modification :
>=20
> void heartbeat(void *cookie)
> {
>       =20
>         while (!end) {
>               ...
>         }
>     set_leds(0);
>    =20
> }
> void cleanup_module(void)
> {
>     //  set_leds(0);
> } =20
>=20
> My interpretation :
> In the non modified example, We try to access directly to the keyboard
> after the end of the rt-driver(after =20
> rtdm_task_join_nrt(&heartbeat_task, 100);)
> So it is a problem for the kernel.

Hmm, the problem might be that set_leds(0) gets preempted. Could you try

local_irq_disable();
set_leds(0);
local_irq_enable();

for cleanup_module()?

Yes, this demo accesses shared hardware directly, and that can confuse
Linux or cause even worse situations. Moreover, this high-prio task also
causes fairly high latencies. So it is nothing for serious use anyway.
But if we can improve obvious issues, there is no need to hesitate.

>=20
> Is it a good interpretation ?
> =20
> what is the difference between rtdm_task_join_nrt(&heartbeat_task, 100)=
 and
>  rtdm_task_destroy(&heartbeat_task) ?
> What is the role of the polling argument (value 100) ?

Not being too lazy to answer, but I would like to know if the doc is
improvable: Did you read the API documentation [1]?

Jan

[1]http://www.xenomai.org/documentation/branches/v2.3.x/html/api/group__r=
tdmtask.html


--------------enigE748F4B3A013FCA6E2351EEB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGH/lQniDOoMHTA+kRAj1DAJ9N7lYlmgZwhlxR7vzBhHPQeOgBzgCdH1NM
ZScySIcDNKisrySrRK8gPEU=
=TbK7
-----END PGP SIGNATURE-----

--------------enigE748F4B3A013FCA6E2351EEB--

