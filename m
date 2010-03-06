Message-ID: <4B9222D1.1000207@domain.hid>
Date: Sat, 06 Mar 2010 10:39:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B90ED0A.40101@domain.hid> <4B90F2D3.8020508@domain.hid>
	<4B91290C.7070005@domain.hid> <4B9131B4.6060105@domain.hid>
	<4B913C71.4060006@domain.hid> <4B914107.3000108@domain.hid>
In-Reply-To: <4B914107.3000108@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC77565C83E2EA276840D6052"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC][PATCH v2] Allow for deregistering current
 mode user space address
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC77565C83E2EA276840D6052
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> This adds __xn_sys_drop_u_mode, a syscall to deregister the u_mode=
 user
>>>>>> space address passed on shadow creation for the current thread. We=
 need
>>>>>> this in order to safely shut down a thread that wants to release i=
ts
>>>>>> u_mode memory (either malloc'ed or TLS-allocated). So far, the ker=
nel
>>>>>> might have touched this memory even after the release which caused=

>>>>>> subtle corruptions.
>>>>>>
>>>>>> After we released u_mode, we can no longer make reliable decisions=
 based
>>>>>> on it. For the fast mutex use case, we then assume the worst case,=
 ie.
>>>>>> we enforce syscall-based acquisitions unconditionally. For the
>>>>>> assert_nrt case, we simply acquire the required information via
>>>>>> __xn_sys_current_info.
>>>>> As usual, you are firing patches too fast:
>>>>> - you are lacking the exit syscall trap.
>>>> Don't worry, my memory is not yet _that_ bad. :)
>>>>
>>>>> - the patch is not correct and will cause kernel-space addresses to=
 be
>>>>> passed to put_user, which probably yields bugs when the kernel is
>>>>> compiled with proper debug flags;
>>>> Right, e.g. ARM requires set_fs() fiddling in addition. But then a s=
imple
>>>> NULL-check is way better. Fixed.
>>>>
>>>>> - I do not see the point where the new syscall is called with __thr=
ead,
>>>>> but I am not sure it is missing, and if it is missing, you will get=
 the
>>>>> rightfull warning when hitting the exit syscall.
>>>> Destructor of (now unconditionally used) xeno_current_mode_key.
>>>>
>>>>> - the user-space users of the function to get current_mode are stil=
l
>>>>> cluttered with special cases to handle the invalid state. And
>>>>> illustrating nicely the deficiency of this approach, you have forgo=
t one
>>>>> user.
>>>> My impression is that you are still a bit biased due to TLS limitati=
ons
>>>> on ARM.
>>> No, I think the __thread stuff thinks make C code look too much like =
C++
>>> where the compiler makes things behind your back for such simple code=
 as:
>>>
>>> void *foo =3D &bar;
>>>
>>> This is not what I expect from a C compiler, and I suspect a lot of C=

>>> developers, including the people who advocate that C, as a simple
>>> language, and not C++ should be used for free software development.
>>>
>>> Yes, there is no gain on ARM, where this generates a function call as=

>>> pthread_getspecific and causes bugs with gcc >=3D 4.3, but not much g=
ain
>>> on x86 either where a function call is so cheap.
>> As are individual memory accesses. The sum makes the difference.
>=20
> Ok. If you find before 2.5.3 a platform where this makes a difference o=
f
> more than 5% of this platform's latency, I do not remove the __thread
> stuff. Deal?

If you manage to remove 5% of the configuration variables of Xenomai
that way. Or 5% of the conditional code.

>=20
>> Once someone starts testing mutexes or other stuff from TSD destructor=
s,
>> not earlier. And this is so special that anyone of us interested in th=
is
>> test case will naturally be aware of its specifics.
>=20
> As you said to err is human. And having a single point for handling an
> exceptional case is a good idea. And this shortens your patch.
>=20
>=20
>>> I think every sane free-software projects ask people to test their
>>> patches/pull requests before sending them, even the Linux kernel. See=

>>> for instance:
>>> http://lwn.net/Articles/377091/
>>>
>>> I am not asking you for one week. 24 hours would be enough.
>> As you may know, complete test coverage is near to impossible.
>=20
> That is no excuse for not making any test.
>=20
>=20
>> On unlucky days, I happen to send out stuff that broke while continuin=
g to
>> type after the last test ran. But specifically these things were teste=
d
>> in various combinations.
>>
>> It is not very polite to assume the contrary.
>=20
> When you send a patch every 5 minutes, it is obvious that it was not
> tested. No politeness involved. Everybody can check the timestamps in
> the mailing lists and do the math.

I think my workflow was misleading regarding this. Not necessarily all
stuff I push into my 'for-upstream' branch is done with all tests at the
time when I push. Official pull request mails are supposed to mark this.
I'm pushing to save my work and, of course, to expose it. So I
appreciate comments, but I surely don't expect them within minutes.

>=20
>  I'm trying to avoid the
>> same assumption about other people as well, even when things look
>> differently from time to time. To err is human, to always write correc=
t
>> code is divine.
>>
>> But as you already mentioned in another mail, there is room for
>> improvement /wrt testability. On step forward would be an automated
>> build and run of some git tree that we can check into. One board per
>> arch would be enough to avoid issues we face from time to time when we=

>> only stress our favorite archs with new features or fixes.
>=20
> We have the automated build.

Then we just need to run it against some 'build-test' branches of
everyone's git repositories on checkin. That would be great.

> I plan seriously to work on the automated
> run for 2.5.3. But it is too late for 2.5.2. Also note that I gave you
> access to my server where several targets are configured and usable. If=

> you forgot the password, I can reset it.

I do remember this, but I thought this was for a specific test. If I'm
supposed to access that box regularly, I'm fine, we can arrange this.

>=20
>>> In fact, the mistake is partly mine too, I am replying to your patche=
s
>>> as fast as you send them. We were going crazy tuesday with the condit=
ion
>>> variable patches, I do not think it gives a reassuring image to the
>>> users.
>> I can only say that, as a developer in this business, I trust code
>> having been discussed to the extreme _way_ more than stuff a single
>> clever person checked in even after meditating over it for weeks. I've=

>> seen enough of this, produced by non-clever /me as well as way more
>> clever people in all kinds of projects.
>>
>>> So that at some point, I stopped reviewing your patches. I have
>>> not even read the last 8 you sent. Without going to the other extreme=
 of
>>> a "closed door" development model, I think we can find a more reasona=
ble
>>> trade off than the current one.
>> Well, you have to decide which piece to take, or to request it to be
>> rewritten, or to write yourself.
>=20
> Yes. That is the plan. Tomorrow.
>=20
>>> Our objective now, is to put 2.5.2 in a stable state.
>>>
>>>> +substitute_linux_syscall(xnthread_t *thread, struct pt_regs *regs)
>>>> +{
>>>> +	if (unlikely(__xn_reg_mux(regs) =3D=3D __NR_exit))
>>>> +		handle_shadow_exit(thread);
>>>> +
>>> Not your fault, but this does not work on ARM. Do not know if
>>> __xn_reg_mux needs fixing there or if we need to add a new macro to g=
et
>>> the roots syscall number.
>> And that's the point of sending patches for discussion.
>>
>> It's regs->ARM_r7 =3D=3D __NR_SYSCALL_BASE + __NR_MY_SYSCALL, right? I=
f
>> __xn_reg_mux is supposed to be only a mux value for Xenomai, we need a=

>> separate accessor for the Linux syscall number on all archs.
>=20
> or __NR_OABI_SYSCALL_BASE + __NR_MY_SYSCALL depending on CONFIG_OABI_CO=
MPAT.
>=20

Patch is in my queue if you are interested.

Jan

PS: Note that this u_mode fix exposed an issue of the sigtest:
cancel_with_signals fails if there is some TSD destructor registered
that issues a Xenomai syscall. Not sure yet if it is a fundamental issue
or just related to the test itself.


--------------enigC77565C83E2EA276840D6052
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuSItcACgkQitSsb3rl5xT+KwCfUF6D5SyEXSy58BZZ2sEMAHOR
DE8Anjm5VheH1mmcr+GTmXbUbafYMoX8
=rHRy
-----END PGP SIGNATURE-----

--------------enigC77565C83E2EA276840D6052--

