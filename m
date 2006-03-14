Message-ID: <441712EB.5040401@domain.hid>
Date: Tue, 14 Mar 2006 20:00:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM and Timer functions
References: <200603091443.25714.lbocseg@domain.hid> <4416F36B.1070600@domain.hid>
	<200603141359.59268.lbocseg@domain.hid>
	<200603141545.29301.lbocseg@domain.hid>
In-Reply-To: <200603141545.29301.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6C28BB204AAF03ED2C6BE92D"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6C28BB204AAF03ED2C6BE92D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Ter=E7a 14 Mar=E7o 2006 13:59, Rodrigo Rosenfeld Rosas escreveu:
>=20
>> Em Ter=E7a 14 Mar=E7o 2006 13:46, Jan Kiszka escreveu:
>>>>>> ... Another one is for timeouts on short delays. In
>>>>>> those cases, we want a good resolution, but this should be indepen=
dent
>>>>>> of the user's timer choice IMO.
>>>>> And this is something rtdm_clock_read_tsc() will obviously not be f=
or.
>>>> Please, take a look in my case. The specification recommends wait at=

>>>> least Xus before testing a bit. But the time to wait is not constant=
, it
>>>> can vary a few microseconds. So, I busy wait Xus and then do some co=
de
>>>> like:
>>>>
>>>> rtdm_task_busy_sleep(X*1000);
>>>> start_time =3D rtdm_clock_read[_tsc]();
>>>> do {
>>>> condition=3Dtestbit();
>>>> } while (! condition && (time_passed(start_time) < TIMEOUT));
>>>>
>>>> But if the user specifies a periodic timer, with tickval=3D1ms, then=
 my
>>>> driver will be too slow. I could busy wait TIMEOUT before testing, a=
nd it
>>>> would be faster then the above code in this case. But I would like t=
o go
>>>> away as soon as possible, ie, just after the bit has been set...
>>> This is how the eepr100 driver of RTnet handles it, though RTnet woul=
d
>>> not work very well in periodic mode. Actually, this has been ported o=
ver
>> >from Linux where you do not have a portable API for reading the TSC, =
I
>>> think.
>>>
>>> static inline int rt_wait_for_cmd_done(long cmd_ioaddr, const char *c=
md)
>>> {
>>>    int wait =3D CONFIG_RTNET_DRV_EEPRO100_CMDTIMEOUT;
>>>
>>>    while (inb(cmd_ioaddr) !=3D 0) {
>>>        if (wait-- =3D=3D 0)
>>>            return 1;
>>>        rtdm_task_busy_sleep(1000);
>>>    }
>>>    return 0;
>>> }
>>> (Hmm, BTW, de-inlining might be worth considering...)
>>>
>>> So this works at a polling period of 1 us, but you may also reduce it=
,
>>> though this would certainly degrade the accuracy further. For sure, t=
he
>>> accuracy is slightly worse than with your pattern. Would this matter =
to
>>> you?
>> No, in my case it doesn't matter. I'll adopt this way of doing it.
>=20
> Thinking better, I would need such a function for registering the times=
tamp of=20
> the captured frame on the irq handler...
>=20

What will this timestamp be used for, relative time calculations? I just
would like to remind that the output of rtdm_clock_read_tsc() will not
be in sync with the system clock in periodic mode (one of my major
concern: that driver writers forget this fact).

Jan


--------------enig6C28BB204AAF03ED2C6BE92D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEFxLrniDOoMHTA+kRAr45AJ41/TKby0TX/mdMGT2KkdrXwJ50eQCdH8p8
GwzNmhaIM2ylgGemRehdTbw=
=PWsl
-----END PGP SIGNATURE-----

--------------enig6C28BB204AAF03ED2C6BE92D--

