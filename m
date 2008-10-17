Message-ID: <48F85A9F.4090307@domain.hid>
Date: Fri, 17 Oct 2008 11:27:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081016145757.935266172@domain.hid>	<48F76068.7050903@domain.hid>	<48F76362.4010104@domain.hid>
	<48F79F7A.2030304@domain.hid> <48F7B98D.8040000@domain.hid>
	<48F84233.1050003@domain.hid> <48F844D8.3060601@domain.hid>
	<48F84A7C.8000909@domain.hid> <48F85012.40407@domain.hid>
In-Reply-To: <48F85012.40407@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4A6D32F3F8A2B220C643AAEC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 0/2] Fix and improve task/thread inquire
	services
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4A6D32F3F8A2B220C643AAEC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Jan Kiszka wrote:
>>>>> Philippe Gerum wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>> Jan Kiszka wrote:
>>>>>>>>> This series fixes the issues around rt_task_inquire I posted ye=
sterday.
>>>>>>>>> Additionally, it introduces an analogous services pthread_inqui=
re_np for
>>>>>>>>> the POSIX skin. That allows, among other things, to implement t=
est cases
>>>>>>>>> for the upcoming fast xnsynch/mutex patches.
>>>>>>>> Ok. Since this applies only for debugging purpose, and displayin=
g
>>>>>>>> whether a task is in primary mode may be use badly by users, may=
be we
>>>>>>>> should make this service a shadow syscall, and not export any in=
terface
>>>>>>>> to use it. This would further avoid duplication between the nati=
ve and
>>>>>>>> posix skins.
>>>>>>> Debugging is not the holy, exclusive business of Xenomai hackers.=

>>>>>>>
>>>>>>> The inquire services are useful in libraries as well, when you wa=
nt to
>>>>>>> check if the caller complies to the call convention ("don't use i=
n
>>>>>>> primary mode", "caller's priority must not exceed X" or whatever)=
=2E
>>>>>>>
>>>>>>> That said, I'm open for unifying the code, maybe introducing some=

>>>>>>> xnthread_inquire.
>>>>>>>
>>>>>> That would be much better than publishing an open interface to fid=
dle even more
>>>>>> with thread modes via rt_task_set_mode(). I would definitely merge=
 that.
>>>>> Code refactoring is no problem, will work that out. I just want to =
keep
>>>>> the user interface.
>>>> Looking into this, I come to the conclusion that xnthread_inquire is=

>>>> only then a gain if both rt_task_inquire and pthread_inquire_np use =
the
>>>> same data structure layout. And that means that both need to use the=

>>>> same time encodings, not struct timespec vs. RTIME like it is now. T=
hat
>>>> would not be beautiful, but feasible (e.g. picking __u64 as type,
>>>> passing nanoseconds). Still, it does not yet convince me.
>>>>
>>> The idea behind xnthread_inquire() is not about replacing rt_task_inq=
uire()
>>> under the hood, but rather to get back only fundamental values, such =
as the
>>> current thread status, in order to determine whether XNRELAX is set o=
r not for
>>> instance.
>>>
>>> XENOMAI_SYSCALL1(__xn_sys_inquire) =3D> xnthread_inquire(xnpod_curren=
t_thread())
>> OK, slowly getting to your core. Assume we had __xn_sys_inquire, what
>> should it return, and what should we mask from rt_task_inquire, and do=

>> we still want pthread_inquire_np.
>>
>=20
> __xn_sys_inquire would return both the informational and status bitmask=
s, for
> debug and sanity check purposes.
>=20
>> But I really dislike this approach of artificially
>> complicating/crippling interfaces just to hide XNRELAX (I can't imagin=
e
>> you have problems with the other information rt_task_inquire returns).=

>>
>=20
> It is not about crippling that interface at all, it is about not adding=
 the
> XNRELAX bit - since it is NOT there ATM - to prevent further misuse of =
the

Look at the code, it _is_ practically there, it _is_ usable, but it is
inverted (T_PRIMARY=3D=3DXNRELAX). That's why I insist on the fact that t=
he
current rt_task_inquire implementation is broken when taking its
documentation as a reference.

> thread mode, which is a very real problem in lots of application code n=
ow.
>=20
> Look, even Hannes who very well knows what co-kernel stuff is all about=

> misinterpreted the Xenomai API in that area:
> http://www.captain.at/review-rtai-versus-xenomai.php

Not directly his fault, he just copied our old, incorrect serial test
code (/me failed to review it before it saw the light of the internet).
But I told him ages ago to update his page.

>=20
> The reason is likely because people tend to think that if T_PRIMARY is
> explicitly provided, that means that the real-time core does not handle=
 the
> issue implicitly, and then conclude that they ought to use rt_task_set_=
mode() to
> do the job themselves. That's wrong, that's badly wrong.

Again, don't shoot the messenger, let's discuss how to overcome the
explicit mode switch interface! You are looking at the wrong spot, IMHO.

BTW, RTnet no longer requires explicit mode switch. And for Xenomai 2.5,
I will remove rtdm_device.open_rt/socket_rt as well as
rtdm_operations.close_rt, ie. a whole bunch of handlers that motivated
most of the explicit switches from my POV. So I would be fine with
deprecating that switch service for 2.5 and maybe remove it with 2.6 (or
whatever comes next).

>=20
> Aside of this, using rt_task_inquire() in instrumentation/debug/sanity =
checking
> code would be overkill most of the time. If the purpose is to implement=

> constructs like:
>=20
> 	if (!task_in_primary_mode()) {
> 		blah;
> 	}
>=20
> Then, you likely don't want the overhead of copying useless things like=
 the task
> name, fetching the outstanding timeout values, or any other values we m=
ay want
> to add in the future to RT_TASK_INFO (e.g. we did not use to send back =
any kind
> of statistical information via that structure in 2.3.x, but we started =
to do so
> with 2.4.x).

That overhead is negligible compared to the anyway required syscall. If
we needed to optimize debugging stuff (I doubt so), we would have to
push that data (also the thread prio etc.) continuously to user space.

Jan


--------------enig4A6D32F3F8A2B220C643AAEC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkj4WqYACgkQniDOoMHTA+kFDgCeJlFpRymsWOOPGBmtLM6zYJys
ZrIAnAzeZxa80L9Y4TZKKROmxNRhCkS/
=2O5f
-----END PGP SIGNATURE-----

--------------enig4A6D32F3F8A2B220C643AAEC--

