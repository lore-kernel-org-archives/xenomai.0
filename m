Message-ID: <443C1F49.30002@domain.hid>
Date: Tue, 11 Apr 2006 23:27:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Fixs doxygen doc
	on	rt_queue_read	in	ksrc/native/queue.c (for SVN version)
References: <200604101640.04255.lbocseg@domain.hid>	<443BA12F.9020505@domain.hid>
	<443BB6B3.8060601@domain.hid> <443C109F.5080208@domain.hid>
	<443C148C.1060504@domain.hid>
In-Reply-To: <443C148C.1060504@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig226AF97B1EE959B61DF7E7BD"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig226AF97B1EE959B61DF7E7BD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>
>>> [a few interruptions later]
>>>
>>> Jan Kiszka wrote:
>>>
>>>> Rodrigo Rosenfeld Rosas wrote:
>>>>
>>>>> BTW, please, could someone confirm the rt_task_delete(NULL) bug in
>>>>> SVN?
>>>>
>>>>
>>>> Half-confirmed, there is something fishy. I'm struggling with the
>>>> debugger ATM, not sure yet who's wrong ;). It tells me
>>>> rt_task_delete of
>>>> the skin module is entered with task !=3D NULL...
>>>
>>>
>>>
>>> ...which turns out to be fine, just appears redundant to me when
>>> comparing __rt_task_delete and rt_task_delete for the task=3DNULL cas=
e.
>>>
>>> Anyway, leaving a native task with rt_task_delete(NULL) raises SIGKIL=
L
>>> to the whole process instead of just the task (pthread). This lets yo=
ur
>>> program terminate unexpectedly - I would say: a bug. And this doesn't=

>>> happen with 2.1?
>>>
>>
>> It's a side-effect of a recent bug fix in ksrc/nucleus/shadow.c; now
>> killing
>=20
> Er, "deleting" is the right word here. Sending a thread a termination
> signal must kill the entire process as per POSIX, and will continue to
> do so. Calling rt_task_delete() to explicitely delete a single thread
> from within the containing process is another story. The current issue
> is due to the fact that no distinction is made on the caller:
> rt_task_delete() targeting a thread from another process should wipe ou=
t
> the entire target process; otherwise, only the local target thread
> should be deleted. It's not clear whether we should still wipe out the
> entire process when the target thread is not the current one, regardles=
s
> of the fact such thread is a member of the same process or not.
> I'm open to suggestions.

Killing other threads within the same process currently only works due
to pthread_cancel. I don't see a portable equivalent for foreign
processes yet as well. :-/

I guess the thread termination signal sent by pthread_cancel depends on
glibc internals, specifically its variant (NTPL or linux-threads),
doesn't it? Didn't we already have this discussion??

For now I would say the best we can do is to avoid the
rt_task_delete(NULL) side effect in userspace (as I suggested) and live
with the limitation of terminating the whole process when using the
(rather unusual) cross-process rt_task_delete.

>=20
>  a thread raises a group signal wiping out the entire process.
>> Ok, it's a bit drastic, will fix.
>>
>>> I guess the easiest way to solve this is to catch NULL in userspace a=
nd
>>> call pthread_exit() in favour of the skin service (the POSIX skin use=
s
>>> pthread_exit anyway), see attached patch. Someone just has to confirm=

>>> that there will be no problem hidden by this approach.
>>
>>
>> Passing NULL needs to work including from user-space; the kernel-space=

>> is ok with this, and the API must behave the same way regardless of
>> the execution space. Should fix as needed.
>>
>>>
>>> Jan
>>>
>>>
>>> PS: What's the reason for "if (err =3D=3D -ESRCH) return 0" in
>>> src/skins/native/task.c, rt_task_delete? Why is that error generate i=
n
>>> the first place if it is zeroed out here?
>>>

<attention: unanswered question above> ;)

Jan


--------------enig226AF97B1EE959B61DF7E7BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEPB9JniDOoMHTA+kRAhtfAJoDaqSNFm60+8RM+pglEOSW8XvTDQCeOdrl
VT7VhATOSStYKMQD81KQTHA=
=2RZK
-----END PGP SIGNATURE-----

--------------enig226AF97B1EE959B61DF7E7BD--

