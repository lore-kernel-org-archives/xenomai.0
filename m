Message-ID: <4416F36B.1070600@domain.hid>
Date: Tue, 14 Mar 2006 17:46:35 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM and Timer functions
References: <200603091443.25714.lbocseg@domain.hid>
	<200603132236.12791.lbocseg@domain.hid> <4416666B.5040201@domain.hid>
	<200603141127.02738.lbocseg@domain.hid>
In-Reply-To: <200603141127.02738.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCC6C793835BD19DC0273E6ED"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCC6C793835BD19DC0273E6ED
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Ter=E7a 14 Mar=E7o 2006 03:44, Jan Kiszka escreveu:
>=20
>> Rodrigo Rosenfeld Rosas wrote:
>>> Em Segunda 13 Mar=E7o 2006 20:05, Jan Kiszka escreveu:
>>>> ...
>>>>
>>>>>> We would definitely need a good name for it,
>>>>>> rtdm_clock_read_ex(<clock-id>), rtdm_clock_read_tsc(),
>>>>>> rtdm_clock_read_monotonic()? I'm not going to break rtdm_clock_rea=
d()
>>>>>> by adding an argument (otherwise, I would have to fix too many dri=
vers
>>>>>> on my own... :-/).
>>>>> That is the idea, I think. I agree that rtdm_clock_read() should be=
 kept
>>>>> as it is (the API/definition). No body is asking you to change it.
>>>>> Adding rtdm_clock_read_tsc() would be sufficient in my opinion whil=
st it
>>>>> maintain coherency with other skins.
>>>> Thinking about this more thoroughly, a few questions popped up for m=
e:
>>>>
>>>> o When we call it rtdm_clock_read_tsc(), we should actually return t=
he
>>>>  raw TSC values, shouln't we? But then we also need conversion
>>>>  functions (rtdm_clock_tsc2ns, rtdm_clock_ns2tsc). Or should we alwa=
ys
>>>>  convert to nanoseconds on return? POSIX and Native are different in=

>>>>  this regard.
>>> I would prefer returning always ns, but both solutions would fit my n=
eeds,
>>> so I'm not really worried about this topic.
>>>
>>>> o What would be the core rationale behind it, having a high-resoluti=
on
>>>>  time stamp? What are the primary use cases? I'm asking for this so
>>>>  that I can clearly differentiate between this new service and the
>>>>  existing one in the docs. Also, giving an abstract description woul=
d
>>>>  leave more options to the actual implementation on other archs or
>>>>  platforms.
>>> As I've said, I think that it is good to give some independency to th=
e
>>> driver, at least to the time related functions, for not depending on =
the
>>> user chosen timer behaviour for some delay routines. Eg, I would like=
 to
>>> wait a specified amount of us before testing some register. That is a=

>>> quite normal task when
>> This is what rtdm_task_busy_sleep() already provides - independent of
>> the system timer.
>=20
> I didn't know it was independent from the timer. Good to know. I think =
it=20
> would worth enforce this statement on its documentation.
>=20
>>> developing drivers. Another one is for timeouts on short delays. In t=
hose
>>> cases, we want a good resolution, but this should be independent of t=
he
>>> user's timer choice IMO.
>> And this is something rtdm_clock_read_tsc() will obviously not be for.=

>=20
> Please, take a look in my case. The specification recommends wait at le=
ast Xus=20
> before testing a bit. But the time to wait is not constant, it can vary=
 a few=20
> microseconds. So, I busy wait Xus and then do some code like:
>=20
> rtdm_task_busy_sleep(X*1000);
> start_time =3D rtdm_clock_read[_tsc]();
> do {
> condition=3Dtestbit();
> } while (! condition && (time_passed(start_time) < TIMEOUT));
>=20
> But if the user specifies a periodic timer, with tickval=3D1ms, then my=
 driver=20
> will be too slow. I could busy wait TIMEOUT before testing, and it woul=
d be=20
> faster then the above code in this case. But I would like to go away as=
 soon=20
> as possible, ie, just after the bit has been set...
>=20

This is how the eepr100 driver of RTnet handles it, though RTnet would
not work very well in periodic mode. Actually, this has been ported over
from Linux where you do not have a portable API for reading the TSC, I
think.

static inline int rt_wait_for_cmd_done(long cmd_ioaddr, const char *cmd)
{
    int wait =3D CONFIG_RTNET_DRV_EEPRO100_CMDTIMEOUT;

    while (inb(cmd_ioaddr) !=3D 0) {
        if (wait-- =3D=3D 0)
            return 1;
        rtdm_task_busy_sleep(1000);
    }
    return 0;
}
(Hmm, BTW, de-inlining might be worth considering...)

So this works at a polling period of 1 us, but you may also reduce it,
though this would certainly degrade the accuracy further. For sure, the
accuracy is slightly worse than with your pattern. Would this matter to y=
ou?

>> Again, when the user / system administrator decided to lower the timer=

>> resolution in favour of performance, it is not possible (and doesn't
>> make sense) to circumvent this decision at driver level (except for bu=
sy
>> waiting).
>=20
> But my situation is still a busy wait but written in another form.
>=20
>> So, I wonder what you plan to do with the return value of the=20
>> new function?
>=20
> I think I've already explained myself.
>=20
> Best regards,
>=20
> Rodrigo.
>=20
>=20

Jan


--------------enigCC6C793835BD19DC0273E6ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEFvNrniDOoMHTA+kRAtMZAJ0cqtMHZAbXni045nH39pH3G4LvzgCfWPn0
X9V9MNaGfbkwMDDndRm4oEY=
=F2Ub
-----END PGP SIGNATURE-----

--------------enigCC6C793835BD19DC0273E6ED--

