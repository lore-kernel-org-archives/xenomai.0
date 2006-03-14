Message-ID: <4417279B.4030103@domain.hid>
Date: Tue, 14 Mar 2006 21:29:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM and Timer functions
References: <200603091443.25714.lbocseg@domain.hid>
	<200603141545.29301.lbocseg@domain.hid> <441712EB.5040401@domain.hid>
	<200603141640.18539.lbocseg@domain.hid>
In-Reply-To: <200603141640.18539.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0975854C43E80D4DB47CD995"
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
--------------enig0975854C43E80D4DB47CD995
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Ter=E7a 14 Mar=E7o 2006 16:00, Jan Kiszka escreveu:
>=20
>> Rodrigo Rosenfeld Rosas wrote:
>>> Em Ter=E7a 14 Mar=E7o 2006 13:59, Rodrigo Rosenfeld Rosas escreveu:
>>>> Em Ter=E7a 14 Mar=E7o 2006 13:46, Jan Kiszka escreveu:
>>>>>>>> ... Another one is for timeouts on short delays. In
>>>>>>>> those cases, we want a good resolution, but this should be
>>>>>>>> independent of the user's timer choice IMO.
>>>>>>> And this is something rtdm_clock_read_tsc() will obviously not be=
 for.
>>>>>> Please, take a look in my case. The specification recommends wait =
at
>>>>>> least Xus before testing a bit. But the time to wait is not consta=
nt,
>>>>>> it can vary a few microseconds. So, I busy wait Xus and then do so=
me
>>>>>> code like:
>>>>>>
>>>>>> rtdm_task_busy_sleep(X*1000);
>>>>>> start_time =3D rtdm_clock_read[_tsc]();
>>>>>> do {
>>>>>> condition=3Dtestbit();
>>>>>> } while (! condition && (time_passed(start_time) < TIMEOUT));
>>>>>>
>>>>>> But if the user specifies a periodic timer, with tickval=3D1ms, th=
en my
>>>>>> driver will be too slow. I could busy wait TIMEOUT before testing,=
 and
>>>>>> it would be faster then the above code in this case. But I would l=
ike
>>>>>> to go away as soon as possible, ie, just after the bit has been se=
t...
>>>>> This is how the eepr100 driver of RTnet handles it, though RTnet wo=
uld
>>>>> not work very well in periodic mode. Actually, this has been ported=
 over
>>>>>
>>>> >from Linux where you do not have a portable API for reading the TSC=
, I
>>>>> think.
>>>>>
>>>>> static inline int rt_wait_for_cmd_done(long cmd_ioaddr, const char =
*cmd)
>>>>> {
>>>>>    int wait =3D CONFIG_RTNET_DRV_EEPRO100_CMDTIMEOUT;
>>>>>
>>>>>    while (inb(cmd_ioaddr) !=3D 0) {
>>>>>        if (wait-- =3D=3D 0)
>>>>>            return 1;
>>>>>        rtdm_task_busy_sleep(1000);
>>>>>    }
>>>>>    return 0;
>>>>> }
>>>>> (Hmm, BTW, de-inlining might be worth considering...)
>>>>>
>>>>> So this works at a polling period of 1 us, but you may also reduce =
it,
>>>>> though this would certainly degrade the accuracy further. For sure,=
 the
>>>>> accuracy is slightly worse than with your pattern. Would this matte=
r to
>>>>> you?
>>>> No, in my case it doesn't matter. I'll adopt this way of doing it.
>>> Thinking better, I would need such a function for registering the
>>> timestamp of the captured frame on the irq handler...
>> What will this timestamp be used for, relative time calculations? I ju=
st
>> would like to remind that the output of rtdm_clock_read_tsc() will not=

>> be in sync with the system clock in periodic mode (one of my major
>> concern: that driver writers forget this fact).
>=20
> But that is exactly what I need. Suppose that a robot control system us=
es two=20
> images to estimate the robot speed. The application may need a control =
loop=20
> of, say, 100ms, putting the periodic timer set to 1, 10 or 100ms. But, =

> suppose that in each loop it takes two images in a short time interval =
(less=20
> then 100ms or even less then 1ms) and the real time interval is very=20
> important. So the driver must pass the timestamp of each captured frame=
 to=20
> application loop. But those times shouldn't be multiple of the timer ti=
ck,=20
> but the real time with all precision it can get.

Ok, your framework is effectively aiming for relative times here, that's
clear now. But your driver will deliver individual frames with absolute
timestamp, right? Then it's up to the user to NOT mix up these
timestamps with dates obtained from the system clock. You will have to
state this clearly!

Moreover, when considering the TSC as high-resolution timestamp source,
this is not applicable on SMP / multicore systems. Those tend to have
unsynchronised and drifting TSCs. So if the first picture was taken on
one CPU and the second on some other...

>=20
> I'm not talking especifically about this application, but giving you a =
general=20
> idea of what is not possible to do currently with RTDM if the applicati=
on set=20
> the timer to periodic.

And as I have this general view in mind, I want to avoid that the TSC
issue gets exported via RTDM drivers to the user. That's already
problematic for the other skins, but having to write special notes all
over the documentation of dozens of driver using mixed clocks would be
very unhandy.

I see the need for having a high-resolution timestamp aside a
low-overhead and low-resolution timer now, and I think we need to look
for a way to avoid its negative sides. Not sure yet if it will be
feasible, but I will come up with a new thread on this topic soon...

Jan


--------------enig0975854C43E80D4DB47CD995
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEFyeeniDOoMHTA+kRArjIAJ0eztabDB4IoC73ww+M2muaaunu4QCeIzlC
R+PRO38losh8ZjZEMvwJEBM=
=16oR
-----END PGP SIGNATURE-----

--------------enig0975854C43E80D4DB47CD995--

