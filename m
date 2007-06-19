Message-ID: <4677C9FD.2050507@domain.hid>
Date: Tue, 19 Jun 2007 14:20:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <OF815057E3.6D5C9810-ONC12572FF.00287AFE-C12572FF.0028A289@domain.hid>	
	<46778964.3070608@domain.hid>
	<b647ffbd0706190452g16e98684p13873b09f48eb185@domain.hid>
	<4677C8A9.2010004@domain.hid>
In-Reply-To: <4677C8A9.2010004@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig13D454FC3EB9B10311C72ED1"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] xeno-2.3.1 shared interrups BUG?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>, apittaluga@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig13D454FC3EB9B10311C72ED1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Dmitry Adamushko wrote:
>> On 19/06/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>> apittaluga@domain.hid wrote:
>>>> Hi,
>>>> running a simple test application which spawns a periodic task
>>> writing on a
>>>> serial interface
>>>> the system hangs performing the rt_dev_close.
>>>> The test program ran fine with xeno 2.2.6 with "Shared Interrupts"
>>> enabled,
>>>> so as with
>>>> xeno 2.3.1 with "Shared Interrupts" disabled. It fails with xeno
>>> 2.3.1 with
>>>> "Shared Interrupts" enabled, so the problem seems to be in the share=
d
>>>> interrupts handling area.
>>>> kernel is 2.6.20 adeos patched
>>>>
>>>> Any suggestion?
>> Does the fix below eliminate the problem?
>>
>> The problem (allegedly) is cause by the following reinitialization at
>> the end of the loop:
>>
>> ...
>>                if (!(intr =3D intr->next))
>>                        intr =3D shirq->handlers;
>> ...
>>
>> 'end' may point to some of the elements ... and shirq->handlers may
>> become NULL (all elements have been deleted)..
>=20
> Good catch.
>=20
>> (white-space damaged version.. enclosed a normal one)
>>
>> --- ksrc/nucleus/intr.c-orig    2007-06-19 13:44:55.090623404 +0200
>> +++ ksrc/nucleus/intr.c 2007-06-19 13:45:53.867440067 +0200
>> @@ -273,7 +273,7 @@ static void xnintr_edge_shirq_handler(un
>>        xnintr_shirq_lock(shirq);
>>        intr =3D shirq->handlers;
>>
>> -       while (intr !=3D end) {
>> +       while (intr && intr !=3D end) {
>>                int ret, code;
>>
>>                xnstat_runtime_switch(sched,
>>
>>
>=20
> But your patch looks incomplete: What if someone removes "end" but
> leaves other handlers behind while we are looping? Neither intr would
> then become NULL nor would we hit the end again. This seems to be more
> tricky...
>=20
> Quick idea: mark the xnintr object as being removed, check for this
> state of "end" at the end of the while loop and null'ify "end" in this =
case.

May also race. So we need both your test and mine, I think. This looks
increasingly ugly, screaming for something different.

Jan


--------------enig13D454FC3EB9B10311C72ED1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGd8n9niDOoMHTA+kRArxkAJ4gOFb7RsxGTmnqWhN6x4nLJaGUYgCdHh1/
OSPg6QiPcq3HYqqJeNMyvT4=
=rBe+
-----END PGP SIGNATURE-----

--------------enig13D454FC3EB9B10311C72ED1--

