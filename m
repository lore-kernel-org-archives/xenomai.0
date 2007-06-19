Message-ID: <4677D352.9010205@domain.hid>
Date: Tue, 19 Jun 2007 15:00:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <OF815057E3.6D5C9810-ONC12572FF.00287AFE-C12572FF.0028A289@domain.hid>	
	<46778964.3070608@domain.hid>	
	<b647ffbd0706190452g16e98684p13873b09f48eb185@domain.hid>	
	<4677C8A9.2010004@domain.hid>
	<b647ffbd0706190541m297ddb05kcc3028a6459dce90@domain.hid>
In-Reply-To: <b647ffbd0706190541m297ddb05kcc3028a6459dce90@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig03A6FAB51048F36A4DBF4A6F"
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
--------------enig03A6FAB51048F36A4DBF4A6F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 19/06/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Dmitry Adamushko wrote:
>> > On 19/06/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> >> apittaluga@domain.hid wrote:
>> >> > Hi,
>> >> > running a simple test application which spawns a periodic task
>> >> writing on a
>> >> > serial interface
>> >> > the system hangs performing the rt_dev_close.
>> >> > The test program ran fine with xeno 2.2.6 with "Shared Interrupts=
"
>> >> enabled,
>> >> > so as with
>> >> > xeno 2.3.1 with "Shared Interrupts" disabled. It fails with xeno
>> >> 2.3.1 with
>> >> > "Shared Interrupts" enabled, so the problem seems to be in the
>> shared
>> >> > interrupts handling area.
>> >> > kernel is 2.6.20 adeos patched
>> >> >
>> >> > Any suggestion?
>> >
>> > Does the fix below eliminate the problem?
>> >
>> > The problem (allegedly) is cause by the following reinitialization a=
t
>> > the end of the loop:
>> >
>> > ...
>> >                if (!(intr =3D intr->next))
>> >                        intr =3D shirq->handlers;
>> > ...
>> >
>> > 'end' may point to some of the elements ... and shirq->handlers may
>> > become NULL (all elements have been deleted)..
>>
>> Good catch.
>>
>> >
>> > (white-space damaged version.. enclosed a normal one)
>> >
>> > --- ksrc/nucleus/intr.c-orig    2007-06-19 13:44:55.090623404 +0200
>> > +++ ksrc/nucleus/intr.c 2007-06-19 13:45:53.867440067 +0200
>> > @@ -273,7 +273,7 @@ static void xnintr_edge_shirq_handler(un
>> >        xnintr_shirq_lock(shirq);
>> >        intr =3D shirq->handlers;
>> >
>> > -       while (intr !=3D end) {
>> > +       while (intr && intr !=3D end) {
>> >                int ret, code;
>> >
>> >                xnstat_runtime_switch(sched,
>> >
>> >
>>
>> But your patch looks incomplete: What if someone removes "end" but
>> leaves other handlers behind while we are looping? Neither intr would
>> then become NULL nor would we hit the end again. This seems to be more=

>> tricky...
>=20
> Yeah.. what's about smth like this? (quick approach: if not ok, will
> have to elaborate it thoroughly :-)
>=20
>=20
> --- ksrc/nucleus/intr.c-orig    2007-06-19 13:44:55.090623404 +0200
> +++ ksrc/nucleus/intr.c 2007-06-19 14:38:36.073535255 +0200
> @@ -259,7 +259,7 @@ static void xnintr_edge_shirq_handler(un
>        xnstat_runtime_t *prev;
>        xnticks_t start;
>        xnintr_shirq_t *shirq =3D &xnshirqs[irq];
> -       xnintr_t *intr, *end =3D NULL;
> +       xnintr_t *intr, *end =3D NULL, *old_end =3D NULL;
>        int s =3D 0, counter =3D 0;
>=20
>        xnarch_memory_barrier();
> @@ -273,7 +273,7 @@ static void xnintr_edge_shirq_handler(un
>        xnintr_shirq_lock(shirq);
>        intr =3D shirq->handlers;
>=20
> -       while (intr !=3D end) {
> +       while (intr && intr !=3D end) {
>                int ret, code;
>=20
>                xnstat_runtime_switch(sched,
> @@ -297,8 +297,14 @@ static void xnintr_edge_shirq_handler(un
>                if (counter++ > MAX_EDGEIRQ_COUNTER)
>                        break;
>=20
> -               if (!(intr =3D intr->next))
> +               if (!(intr =3D intr->next)) {
>                        intr =3D shirq->handlers;
> +
> +                       /* 'end' has been removed in the mean time. */
> +                       if (end && old_end =3D=3D end)
> +                               intr =3D NULL;
> +                       old_end =3D end;
> +               }

"end" may still remain stuck on an xnintr object that was removed.
Unless some other element becomes "end" while continuing with the chain,
I don't see a way out of this loop.

I currently have a new approach in mind:

- work with two chains, one is active and remains so as long as we
  iterate over it in the hander, the other gets modified and then marked
  active for succeeding handler entries

- turn the shared-edge chains into rings (make the last point to the
  first) so that we can drop "if (!(intr =3D intr->next))"

The latter is actually an unrelated optimisation, I just wanted to save
the idea. :)

Jan


--------------enig03A6FAB51048F36A4DBF4A6F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGd9NSniDOoMHTA+kRAg/1AJwJNl65IDV7NSgKFzYHZxxsNDOuewCfcZiA
zjwegr2/kiLm5YUqqUgZAyg=
=51J+
-----END PGP SIGNATURE-----

--------------enig03A6FAB51048F36A4DBF4A6F--

