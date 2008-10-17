Message-ID: <48F872BA.5010409@domain.hid>
Date: Fri, 17 Oct 2008 13:10:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081016145757.935266172@domain.hid>	<48F76068.7050903@domain.hid>	<48F76362.4010104@domain.hid>
	<48F79F7A.2030304@domain.hid> <48F7B98D.8040000@domain.hid>
	<48F84233.1050003@domain.hid> <48F844D8.3060601@domain.hid>
	<48F84A7C.8000909@domain.hid> <48F85012.40407@domain.hid>
	<48F85A9F.4090307@domain.hid> <48F8620A.5090206@domain.hid>
In-Reply-To: <48F8620A.5090206@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF5BD8FA7DE56EA8842E44EAA"
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
--------------enigF5BD8FA7DE56EA8842E44EAA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Philippe Gerum wrote:
>>>>>>>> Jan Kiszka wrote:
>>>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>>> Jan Kiszka wrote:
>>>>>>>>>>> This series fixes the issues around rt_task_inquire I posted =
yesterday.
>>>>>>>>>>> Additionally, it introduces an analogous services pthread_inq=
uire_np for
>>>>>>>>>>> the POSIX skin. That allows, among other things, to implement=
 test cases
>>>>>>>>>>> for the upcoming fast xnsynch/mutex patches.
>>>>>>>>>> Ok. Since this applies only for debugging purpose, and display=
ing
>>>>>>>>>> whether a task is in primary mode may be use badly by users, m=
aybe we
>>>>>>>>>> should make this service a shadow syscall, and not export any =
interface
>>>>>>>>>> to use it. This would further avoid duplication between the na=
tive and
>>>>>>>>>> posix skins.
>>>>>>>>> Debugging is not the holy, exclusive business of Xenomai hacker=
s.
>>>>>>>>>
>>>>>>>>> The inquire services are useful in libraries as well, when you =
want to
>>>>>>>>> check if the caller complies to the call convention ("don't use=
 in
>>>>>>>>> primary mode", "caller's priority must not exceed X" or whateve=
r).
>>>>>>>>>
>>>>>>>>> That said, I'm open for unifying the code, maybe introducing so=
me
>>>>>>>>> xnthread_inquire.
>>>>>>>>>
>>>>>>>> That would be much better than publishing an open interface to f=
iddle even more
>>>>>>>> with thread modes via rt_task_set_mode(). I would definitely mer=
ge that.
>>>>>>> Code refactoring is no problem, will work that out. I just want t=
o keep
>>>>>>> the user interface.
>>>>>> Looking into this, I come to the conclusion that xnthread_inquire =
is
>>>>>> only then a gain if both rt_task_inquire and pthread_inquire_np us=
e the
>>>>>> same data structure layout. And that means that both need to use t=
he
>>>>>> same time encodings, not struct timespec vs. RTIME like it is now.=
 That
>>>>>> would not be beautiful, but feasible (e.g. picking __u64 as type,
>>>>>> passing nanoseconds). Still, it does not yet convince me.
>>>>>>
>>>>> The idea behind xnthread_inquire() is not about replacing rt_task_i=
nquire()
>>>>> under the hood, but rather to get back only fundamental values, suc=
h as the
>>>>> current thread status, in order to determine whether XNRELAX is set=
 or not for
>>>>> instance.
>>>>>
>>>>> XENOMAI_SYSCALL1(__xn_sys_inquire) =3D> xnthread_inquire(xnpod_curr=
ent_thread())
>>>> OK, slowly getting to your core. Assume we had __xn_sys_inquire, wha=
t
>>>> should it return, and what should we mask from rt_task_inquire, and =
do
>>>> we still want pthread_inquire_np.
>>>>
>>> __xn_sys_inquire would return both the informational and status bitma=
sks, for
>>> debug and sanity check purposes.
>>>
>>>> But I really dislike this approach of artificially
>>>> complicating/crippling interfaces just to hide XNRELAX (I can't imag=
ine
>>>> you have problems with the other information rt_task_inquire returns=
).
>>>>
>>> It is not about crippling that interface at all, it is about not addi=
ng the
>>> XNRELAX bit - since it is NOT there ATM - to prevent further misuse o=
f the
>> Look at the code, it _is_ practically there, it _is_ usable, but it is=

>> inverted (T_PRIMARY=3D=3DXNRELAX). That's why I insist on the fact tha=
t the
>> current rt_task_inquire implementation is broken when taking its
>> documentation as a reference.
>>
>>> thread mode, which is a very real problem in lots of application code=
 now.
>>>
>>> Look, even Hannes who very well knows what co-kernel stuff is all abo=
ut
>>> misinterpreted the Xenomai API in that area:
>>> http://www.captain.at/review-rtai-versus-xenomai.php
>> Not directly his fault, he just copied our old, incorrect serial test
>> code (/me failed to review it before it saw the light of the internet)=
=2E
>> But I told him ages ago to update his page.
>>
>=20
> The point still stands, whoever made the mistake, that mistake was due =
to a
> misunderstanding of the API. This is the gist of the matter: let's remo=
ve the
> source of such issue.
>=20
>>> The reason is likely because people tend to think that if T_PRIMARY i=
s
>>> explicitly provided, that means that the real-time core does not hand=
le the
>>> issue implicitly, and then conclude that they ought to use rt_task_se=
t_mode() to
>>> do the job themselves. That's wrong, that's badly wrong.
>> Again, don't shoot the messenger, let's discuss how to overcome the
>> explicit mode switch interface! You are looking at the wrong spot, IMH=
O.
>>
>=20
> I'm not shooting the messenger, I'm just telling the messenger that his=
 message
> is currently wrong.
>=20
> Please look at the code again:
>=20
> - __rt_task_inquire() does not remap XNRELAX to some still undefined T_=
PRIMARY
> bit because I never wanted to do so.
>=20
> - The comments attached to the status bits in question do make pretty c=
lear that
> I did not want those statuses to exist actually, there were just meant =
to be
> placeholders for rt_task_set_mode() only. T_JOINABLE is arguably a good=

> candidate for conversion to an actual status , that is not disputed.
>=20
> #define T_PRIMARY  0x00000200	/* Recycle internal bits status which */
> #define T_JOINABLE 0x00000400	/* won't be passed to the nucleus.  */

The "won't be passed _to_ the nucleus", there is no comment about what
is returned _from_ it.

>=20
> - __rt_task_set_mode() is currently trying to set T_PRIMARY within the =
old mode
> mask to be returned to the user to be consistent with the input paramet=
ers that
> may set it, but that fails, and beyond that, it's plain silly (I wrote =
this
> code, so I can tell you it is, right?). It is silly because __rt_task_s=
et_mode()
> has to be tagged as __xn_exec_primary; so, what is the point?
>=20
> What we need is:
>=20
> - to prevent the thread mode from being explicitly manipulated from the=
 public
> interface. So we need to get rid of T_PRIMARY in rt_task_set_mode(). At=
 the same
> time, we still need to provide a way for low-level code to control that=
 mode,
> That service already exists, i.e. XENOMAI_SYSCALL(__xn_sys_migrate).
>=20
> - a way to get the current thread status for debugging/sanity checks/lo=
gging
> etc; but since we want to move the primary mode bit away from the publi=
c
> interface of rt_task_set_mode(), and that is XENOMAI_SYSCALL(__xn_sys_i=
nquire).
> There would be no point in returning T_PRIMARY back explicitly via
> rt_task_inquire(). It would even be counter-productive. I don't care if=
 we don't
> mask out XNRELAX and other unwanted bits from RT_TASK_INFO::status; the=
 point is
> that we should not mention those internal bits in the rt_task_inquire()=

> documentation.

When there is no official way to "manipulate" the mode, there is ZERO
point in hiding it, urging Native or Posix user to talk to
Xenomai-internal APIs. We actually should want users to be _very_ well
aware of the different modes, otherwise they continue to write too much
broken code (/wrt RT).

>=20
>> BTW, RTnet no longer requires explicit mode switch. And for Xenomai 2.=
5,
>> I will remove rtdm_device.open_rt/socket_rt as well as
>> rtdm_operations.close_rt, ie. a whole bunch of handlers that motivated=

>> most of the explicit switches from my POV. So I would be fine with
>> deprecating that switch service for 2.5 and maybe remove it with 2.6 (=
or
>> whatever comes next).
>>
>>> Aside of this, using rt_task_inquire() in instrumentation/debug/sanit=
y checking
>>> code would be overkill most of the time. If the purpose is to impleme=
nt
>>> constructs like:
>>>
>>> 	if (!task_in_primary_mode()) {
>>> 		blah;
>>> 	}
>>>
>>> Then, you likely don't want the overhead of copying useless things li=
ke the task
>>> name, fetching the outstanding timeout values, or any other values we=
 may want
>>> to add in the future to RT_TASK_INFO (e.g. we did not use to send bac=
k any kind
>>> of statistical information via that structure in 2.3.x, but we starte=
d to do so
>>> with 2.4.x).
>> That overhead is negligible compared to the anyway required syscall. I=
f
>> we needed to optimize debugging stuff (I doubt so), we would have to
>> push that data (also the thread prio etc.) continuously to user space.=

>>
>=20
> It is not about debugging stuff only, you said you wanted to add sanity=
 checks
> as well, like I just sketched above and will redo below:
>=20
>  	if (!task_in_primary_mode())
>  		return -CANTDOTHAT;
>=20
>=20
> In that case, you certainly don't want to pay for such overhead. Theref=
ore, what
> you need is XENOMAI_SYSCALL(__xn_sys_inquire).

If you really insist on reducing the information which skin inquire
services are allowed to return and leave me with a special approach for
task_in_primary_mode(), then I will rather come up with a syscall-less
variant.

Jan


--------------enigF5BD8FA7DE56EA8842E44EAA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkj4csQACgkQniDOoMHTA+nfJwCfXIznDZ0HSjDIKm3S+YmQasby
LcoAnj1rQFjCVpbdKvDJGQ5vTb5ly64y
=0YVQ
-----END PGP SIGNATURE-----

--------------enigF5BD8FA7DE56EA8842E44EAA--

