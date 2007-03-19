Message-ID: <45FF0DC8.6000007@domain.hid>
Date: Mon, 19 Mar 2007 23:25:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT-Socket-CAN bus error handling (was CAN errors
	and real-time behaviour (IRQ raise forever and may lock system))
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>	<45FDA81F.2080004@domain.hid>
	<E1HTD6v-0004qo-QI@mailer.emlix.com>	<E1HTDZN-0006rl-2g@domain.hid>	<45FE7578.4000306@domain.hid>
	<45FE8AA2.1030507@domain.hid> <45FEF649.9060205@domain.hid>
	<45FEFE64.5010206@domain.hid>
In-Reply-To: <45FEFE64.5010206@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9B7F8DA3535E1CB42709E343"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9B7F8DA3535E1CB42709E343
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
>>> The problem is to define what degree of error-related IRQ load is
>>> generally acceptable. We surely can't do this, so we have to document=

>>> the effect /at least/ and help the users to check it on their own - o=
r
>>> we have to avoid it / make it insignificant compared to normal CAN
>>> operation (I'm still in favour of this path).
>>
>> We speak about a pathological situation and therefore I do not share
>> your concerns. When there are electrical problems or even the cable is=

>> not connected, we do have an abnormal mode of operation and CAN
>> related real-time is broken anyhow. The bus error messages are then
>> useful for analyzing the problem. The effect of the bus error

I do understand, and that's why I was looking for some solution that
rate-controls such IRQs deterministically, but doesn't switch them off
altogether.

>> interrupts on non-CAN related latencies is another issue but I think
>> it's not that critical either (handling a bus error just requires the
>> reading of 2 SJA1000 registers). But I agree, a more detailed analysis=

>> of "bus error flooding" would help to understand the impact on the
>> real-time behavior.
>=20
> And also be aware, that heavy CAN traffic can cause similar latencies a=
s
> well and when there is more than one CAN controller, they can accumulat=
e
> (as I have observed with my PCAN dongle tests). Here a IRQ service task=


Well, this argumentation doesn't help if some concrete CAN bus was
specified to _not_ deliver such high traffic.

> or threaded IRQs would help. Maybe this is the right way to go.

Again: threaded IRQs are no magic bullet. First of all, they add
latencies, specifically on low-end. And they can only help if IRQ
priorities can actually be lowered appropriately (or if you apply
round-robin or a similar CPU bandwidth policy).

Jan


--------------enig9B7F8DA3535E1CB42709E343
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF/w3IniDOoMHTA+kRAj9rAJ9pQw8Hzg1b0/ZO3KJtou84Gm4a3gCfVSdO
QXX/ixBqjKt6lgiNAfBGrJA=
=0qwx
-----END PGP SIGNATURE-----

--------------enig9B7F8DA3535E1CB42709E343--

