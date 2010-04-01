Message-ID: <4BB511C7.1050507@domain.hid>
Date: Thu, 01 Apr 2010 23:36:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B97BA0C.9000702@domain.hid> <4B9AD0DE.4020103@domain.hid>	
	<1268472523.27899.135.camel@domain.hid>	
	<4B9BB9B1.5050003@domain.hid>	
	<1268498034.27899.167.camel@domain.hid>	
	<4B9C2100.6090806@domain.hid>	
	<1268584465.27899.197.camel@domain.hid>	
	<4BB4F857.5020906@domain.hid> <4BB50C8B.2000405@domain.hid>	
	<1270156940.2418.403.camel@domain.hid>
	<4BB50F7C.1020102@domain.hid>
	<1270157507.2418.409.camel@domain.hid>
In-Reply-To: <1270157507.2418.409.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig84961767BA79B3859130BCD3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Analogy cmd_write example explanation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig84961767BA79B3859130BCD3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2010-04-01 at 23:26 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Thu, 2010-04-01 at 23:13 +0200, Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Philippe Gerum wrote:
>>>>>> On Sun, 2010-03-14 at 00:34 +0100, Alexis Berlemont wrote:
>>>>>>> Philippe Gerum wrote:
>>>>>>>> On Sat, 2010-03-13 at 17:13 +0100, Alexis Berlemont wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> Philippe Gerum wrote:
>>>>>>>>>> On Sat, 2010-03-13 at 00:40 +0100, Alexis Berlemont wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> Sorry for answering so late. I took a few days off far from a=
ny internet
>>>>>>>>>>> connection.
>>>>>>>>>>>
>>>>>>>>>>> It seems you sent many mails related with Analogy. Many thank=
s for your
>>>>>>>>>>> interest. I have not read all of them yet. However, I am begi=
nning by
>>>>>>>>>>> this one (which seems unanswered). The answer is quick and ea=
sy :)
>>>>>>>>>>>
>>>>>>>>>>> Daniele Nicolodi wrote:
>>>>>>>>>>>> Hello. I'm looking into the analogy cmd_write example.
>>>>>>>>>>>>
>>>>>>>>>>>> I'm not sure I understand the reason for the rt_task_set_mod=
e() function
>>>>>>>>>>>> call into the data acquisition loop (lines 413 or 464 in the=
 code
>>>>>>>>>>>> shipped with xenomai 2.5.1).
>>>>>>>>>>>>
>>>>>>>>>>>> I do not understand why we have to set the primary mode at e=
very
>>>>>>>>>>>> iteration, when we set it before for the task (line 380).
>>>>>>>>>>>>
>>>>>>>>>>>> Is it because the dump_function() uses system calls that can=
 make the
>>>>>>>>>>>> task to switch to secondary mode, or there is a deeper reaso=
n I'm missing?
>>>>>>>>>>>>
>>>>>>>>>>> You are right. The dumping routine triggers a switch to secon=
dary mode.
>>>>>>>>>>> That is why, the program switches back to primary mode after.=

>>>>>>>>>> This is wrong. The Xenomai core will switch your real-time thr=
ead to
>>>>>>>>>> primary mode automatically when running a4l_insn* calls that e=
nd up
>>>>>>>>>> invoking rt_dev_ioctl(), since you did declare a real-time ent=
ry point
>>>>>>>>>> for this one.
>>>>>>>>>>
>>>>>>>>> I don't understand. I thought that rt_dev_ioctl() triggered an
>>>>>>>>> __rtdm_ioctl syscall, which, according to the rtdm systab, is d=
eclared
>>>>>>>>> with the flags "__xn_exec_current | __xn_exec_adaptive".
>>>>>>>>>
>>>>>>>>> So as __rt_dev_ioctl (the kernel handler behind the ioctl sysca=
ll) will
>>>>>>>>> return -ENOSYS neither in RT nor in NRT mode (because analogy d=
eclares
>>>>>>>>> both RT and NRT fops entries), I thought there was no automatic=

>>>>>>>>> mode-switching.
>>>>>>>> The point is that your ioctl_nrt handler should return -ENOSYS w=
hen it
>>>>>>>> detects that the current request should be processed by the conv=
erse
>>>>>>>> domain, to trigger the switch to primary mode. This is why the a=
daptive
>>>>>>>> tag is provided in the first place.
>>>>>>> The problem is that rtdm does not provide any function to know wh=
ether
>>>>>>> the thread is shadowed. We just have rtdm_in_rt_context() which t=
ells us
>>>>>>> whether the thread is RT or not. If it is NRT, we cannot distingu=
ish a
>>>>>>> Linux thread from a Xenomai one.
>>>>>>>
>>>>>>> I thought with a little patch like this in ksrc/skins/rtdm/core.c=
, we=20
>>>>>>> could force -ENOSYS if the calling thread was a Xenomai NRT threa=
d:
>>>>>>>
>>>>>>>   diff --git a/ksrc/skins/rtdm/core.c b/ksrc/skins/rtdm/core.c
>>>>>>> index 8677c47..cc0cfe9 100644
>>>>>>> --- a/ksrc/skins/rtdm/core.c
>>>>>>> +++ b/ksrc/skins/rtdm/core.c
>>>>>>> @@ -423,6 +423,9 @@ do {									\
>>>>>>>   									\
>>>>>>>   	if (rtdm_in_rt_context())					\
>>>>>>>   		ret =3D ops->operation##_rt(context, user_info, args);	\
>>>>>>> +	else if (xnshadow_thread(user_info) !=3D NULL &&			\
>>>>>>> +		 ops->operation##_rt !=3D (void *)rtdm_no_support)	\
>>>>>>> +		ret =3D -ENOSYS;						\
>>>>>>>   	else								\
>>>>>>>   		ret =3D ops->operation##_nrt(context, user_info, args);	\
>>>>>>>   									\
>>>>>> No, this would be a half-working kludge. But I think you have pinp=
ointed
>>>>>> a more general issue with RTDM: syscalls should be tagged as both
>>>>>> adaptive and conforming, instead of bearing the __xn_exec_current =
bit.
>>>>>> Actually, we do want the current domain to change when it is not t=
he
>>>>>> most appropriate, which __xn_exec_current prevents so far.
>>>>>>
>>>>>> What we rather want is to have shadows migrating to primary mode w=
hen
>>>>>> running rtdm_ioctl, since this is the preferred mode of operation =
for
>>>>>> Xenomai threads, so that ioctl_rt is always invoked first when pre=
sent,
>>>>>> giving an opportunity to forward the request to secondary mode by
>>>>>> returning -ENOSYS. Conforming calls always enforce the preferred r=
untime
>>>>>> mode, i.e. primary for Xenomai shadows, secondary for plain Linux =
tasks.
>>>>>> That logic applies to all RTDM syscalls actually.
>>>>>>
>>>>>> __xn_exec_current allows application code to infer that the RTDM d=
river
>>>>>> might behave differently depending on the current runtime mode of =
the
>>>>>> calling thread, which is very much error-prone, and likely not wha=
t was
>>>>>> envisioned initially.
>>>>> Argh.... The switchtest driver is relying on __xn_exec_current to h=
ave
>>>>> context switches occur precisely in the mode we want. __xn_exec_ada=
ptive
>>>>> introduce more context switches around which we can not place separ=
ate
>>>>> checks for fpu context, so, in short, breaks it badly. Fixing this
>>>>> requires turning the switchtest driver into a skin with its own sys=
calls.
>>>>>
>>>>> Note the sequence which occurs when a shadowed thread running in
>>>>> secondary mode calls an ioctl for which only an nrt implementation =
occurs:
>>>>> the thread is hardened to handle the ioctl
>>>>> ioctl_rt is called which returns -ENOSYS
>>>>> the thread is relaxed
>>>>> ioctl_nrt is called
>>>>>
>>>>> It boils down to putting an rt_task_set_mode(PRIMARY) before each r=
tdm
>>>>> syscall made by a thread with a shadow, and in fact seems to result=
 in
>>>>> as bad a result. Is it really what we want? The __xn_exec_current b=
it
>>>>> resulted in a more lazy behaviour.
>>>>>
>>>>> Also note that, at least when using the posix skin, almost all thre=
ads
>>>>> have shadows, and only the priority makes the difference between a
>>>>> really critical thread, and non critical threads with the null prio=
rity.
>>>>> So, this will happen all the time.
>>>> Right. Actually, we only need the conforming property for the (fairl=
y
>>>> rare) case that a service is provided in both flavors.
>>> Wrong. You want conforming because real-time is the preferred mode of=

>>> operations for real-time threads.
>> Sorry, wrong as well. :)
>>
>> Setup/reconfiguration phases happening over already shadowed threads c=
an
>> suffer significantly when playing ping-pong via mode switches. That's
>> why threads stay in secondary mode after their first Linux syscall and=

>> are not immediately switched back.
>=20
> I decided to implement lazy switch in that case because it made sense
> not to add overhead when it is not needed. The situation you describe i=
s
> a code that actually cares for an extra switch at the expense of a
> proper design, by imposing a lot of mode switches in tight loops. Pleas=
e
> fix the app, not the core, really.

You still assume that there aren't many non-RT services provided by an
RTDM driver. That's true - for some drivers. It's totally wrong for
others. RTDM simply doesn't know this.

The core was designed for flexibility - as it has to deal with all those
kinds of drivers. So the best decision here is to give control back to
the driver, not try to be overly clever at the most generic point in RTDM=
=2E

Jan


--------------enig84961767BA79B3859130BCD3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAku1EccACgkQitSsb3rl5xS/HgCeK67z1CTBS5Vc1a0ScAPrMluR
yloAnjI5UbWuXRJ2Fxc9TJQ/kn9eD6Dg
=oB9f
-----END PGP SIGNATURE-----

--------------enig84961767BA79B3859130BCD3--

