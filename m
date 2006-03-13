Message-ID: <44155BFD.300@domain.hid>
Date: Mon, 13 Mar 2006 12:48:13 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM and Timer functions
References: <200603091443.25714.lbocseg@domain.hid>
	<200603101054.41122.lbocseg@domain.hid> <4411C646.80802@domain.hid>
	<200603101700.10820.lbocseg@domain.hid>
In-Reply-To: <200603101700.10820.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig52B5065C6E289723E7912270"
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
--------------enig52B5065C6E289723E7912270
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Sexta 10 Mar=E7o 2006 15:32, Jan Kiszka escreveu:
>=20
>> Rodrigo Rosenfeld Rosas wrote:
>>> Em Quinta 09 Mar=E7o 2006 17:33, Jan Kiszka escreveu:
>>>> Rodrigo Rosenfeld Rosas wrote:
>>>>> Hi Jan,
>>>>>
>>>>> I'm still concerned about the future of RTDM and timer functions. I=

>>>>> think there should be some function for starting the timer manually=
,
>>>>> since the automatic feature don't work great for RTDM drivers.
>>>>>
>>>>> It is not nice to have to run the latency (or any other) program fo=
r
>>>>> starting the timer before I can load my driver. And it is not suffi=
ce to
>>>>> run it once I booted. After I open/close my rtdm device and reload =
my
>>>>> driver the problem will occur again and I'll have to re-run the lat=
ency
>>>>> program.
>>>> Sorry I don't see the problem here.
>>>>
>>>> # modprobe xeno_nucleus; cat /proc/xenomai/timer
>>>> status=3Doff:setup=3D1392:tickval=3D0:jiffies=3D0
>>>>
>>>> # modprobe xeno_rtdm; cat /proc/xenomai/timer
>>>> status=3Doneshot:setup=3D1392:tickval=3D1:jiffies=3D8113917792696
>>>>
>>>> So the timer is running right since when rtdm is loaded?!
>>> Yes, here too.
>>>
>>>> And that simple heartbeat rtdm example on my rt-addon homepage now
>>>> cleanly runs even without any further helper to start some timer.
>>> Yes, here too. You are right, once the timer is in oneshot mode. My d=
river
>>> loads correctly without the helper. Then I start a user application t=
hat
>>> changes the timer to periodic mode and uses my driver. When I reload =
my
>>> driver, now in periodic mode, the problem raises.
>> What happens if you make the periodic timer the default one in the
>> kernel configuration?
>=20
> The same behaviour.
>=20
>>> It seems, there is no problem when the timer is set to oneshot. But w=
hen
>>> turning it to periodic, at least one of rtdm_task_busy_sleep() or
>>> rtdm_clock_read() doesn't seem to work. See below:
>>>
>>> cat /proc/xenomai/timer
>>>   status=3Dperiodic:setup=3D188:tickval=3D100000:jiffies=3D19972453
>>>
>>> start_time =3D rtdm_clock_read();
>>> rtdm_task_busy_sleep(84000);
>>> temp_time =3D rtdm_clock_read();
>>> rtdm_printk(KERN_INFO "Should be near 84000: %u\n", (unsigned int)
>>>                    (temp_time-start_time));
>>>
>>> Sometimes the result is "Should be near 84000: 100000", that is kind =
of
>>> correct, since the tickval is 100000, although I think that those
>>> functions in the RTDM driver context should be independent of the tic=
k
>>> value set by the user program... Maybe using oneshot in the driver ca=
lls
>>> and periodic in the application... I really don't know what would be =
the
>>> best approach here...
>> rtdm_clock_read always uses the nucleus clock.
>=20
> Do you mean that rtdm_clock_read will always read a multiple of tickval=
 value?=20
> If so, I think it would be good to make it clear on its documentation. =
"Get=20
> system time" isn't enough for getting this information, IMHO.

Please have a look at the two sentences of documentation I added to SVN
(didn't make it into the release).

I gave your scenario a try, and I was able to verify that
rtdm_task_busy_sleep works correctly under both timer modes. Indeed, the
behaviour of rtdm_clock_read may have been confusing due to lacking
information, but it was also correct.

>=20
>> Using something different=20
>> (e.g. always TSC) would break applications specifying absolute times
>> derived from the return values of other skins' functions.
>=20
> I did not understand. I'm talking about using TSC only for these two=20
> functions. I can not see why shouldn't it be possible... I mean, I thin=
k the=20
> driver should not depend on the userspace program timer for these two=20
> functions.
>=20
>>> But the worst case is that sometimes I get "Should be near 84000: 0" =
which
>>> clearly is a incorrect result.
>> That might be a rounding issue somewhere, as the sleep than clearly di=
d
>> not wait at least one tick. Will have to check this when time permits.=

>>
>>> After I run the latency program, the timer turns to be oneshot again =
and
>>> everything goes right.
>>>
>>> What can I do to solve this problem?
>> Use oneshot mode in the meantime - or even longer ;).
>=20
> That is what I'll gonna do, but I know it is not a definite solution. S=
ince=20
> I'm providing a framework, the user should decide which approach is bet=
ter=20
> for him/her, oneshot or periodic mode.
>=20
>> Why do you prefer=20
>> periodic mode for your application? Another workaround: reduce the tic=
k
>> interval.
>=20
> I have some loops in my userspace programs that a common 100us tick wou=
ld=20
> satisfy them all. I think the overhead would be lower than using the=20
> aperiodic oneshot mode... I'm not pretty sure about that. But that is n=
ot the=20
> question. My application is just an use case of my framework (actually =
I=20
> didn't even started building it). The final user should decide what is =
the=20
> best approach for him/her, not me. So, I would prefer that the driver b=
e=20
> independent from the timer source chosen by the user program.
>=20

I see your point. But when the user decides to pick a low-precision
timer source to reduce overhead, (s)he has to live with the side-effect.
There is no such thing like "user vs. kernel" timer source - it is
always the same. Thus, also the precision of time stamping in drivers
suffers.

Jan


--------------enig52B5065C6E289723E7912270
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEFVv9niDOoMHTA+kRAoRLAJ4slOktS+3cpcvYP5MYnhGpiJtkFACfQyBQ
BYQtqz97y6D5Wo5BpE02cJQ=
=jM+f
-----END PGP SIGNATURE-----

--------------enig52B5065C6E289723E7912270--

