Message-ID: <4B90173C.9080008@domain.hid>
Date: Thu, 04 Mar 2010 21:25:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B8E24B4.9000806@domain.hid>
	<4B8E260D.7070809@domain.hid>	<4B8E281F.1040308@domain.hid>
	<4B8E28D2.6020808@domain.hid> <4B8FFBCD.9020305@domain.hid>
	<4B8FFDC0.4080903@domain.hid>
In-Reply-To: <4B8FFDC0.4080903@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7512E801F661141467D31A8D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Potential heap corruption on thread cleanup
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Mauerer, Wolfgang" <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>, "Hillier,
	Gernot" <gernot.hillier@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7512E801F661141467D31A8D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Hi Gilles,
>>>>>>
>>>>>> I'm pushing your findings to the list, also as my colleagues showe=
d
>>>>>> strong interest - this thing may explain rare corruptions for us a=
s well.
>>>>>>
>>>>>> I thought a bit about that likely u_mode-related crash in your tes=
t case
>>>>>> and have the following theory so far: If the xeno_current_mode sto=
rage
>>>>>> is allocated on the application heap (!HAVE_THREAD, that's also wh=
at we
>>>>>> are forced to use), it is automatically freed on thread terminatio=
n in
>>>>>> the context of the dying thread. If the thread is already migrated=
 to
>>>>>> secondary or if that happens while it is cleaned up (i.e. before c=
alling
>>>>>> for exit into the kernel), there is no problem, Xenomai will not t=
ouch
>>>>>> the mode storage anymore. But if the thread happens to delete the
>>>>>> storage "silently", without any migration, the final exit will tri=
gger
>>>>>> one further access. And that takes place against an invalid head a=
rea at
>>>>>> this point.
>>>>>>
>>>>>> Does this make sense?
>>>>> Yes, it is the issue we observed.
>>>>>
>>>>>> If that is true, all we need to do is to force a migration before
>>>>>> releasing the mode storage. Could you check this?
>>>>> No, that does not fly. Calling, for instance, __wrap_pthread_mutex_=
lock
>>>>> in another TSD cleanup function is which could be called after the
>>>>> current_mode TSD cleanup is allowed and could trigger a switch to
>>>>> primary mode and a write to the u_mode.
>>>>>
>>>> Good point. Mmh. Another, but ABI-breaking, way would be to add a
>>>> syscall for deregistering the u_mode pointer...
>>> That is the thing we did to verify that we had this bug. But this
>>> syscall would be also called too soon, and suffers from the TSD clean=
up
>>> functions order again.
>>>
>> Right, the only complete fix without losing functionality is to add an=

>> option to our ABI for requesting kernel-managed memory if dynamic
>> allocation is necessary (i.e. no TLS is available).
>=20
> No. TLS may as well suffer from the same issue, since it is handled by
> the glibc or libgcc, over which we have no control. So yes, it may work=

> by chance today, but may as well stop working tomorrow. We use
> kernel-managed memory all the time, final point.

I think we are still in the solution finding process, no need for early
conclusions.

See, we actually do not need kernel-managed storage for u_mode at all.
u_mode is an optimization, mostly for our fast user space mutexes. We
can indeed switch off all updates by the kernel and will still be able
to provide all required features - just less optimally. Adding a third
state, "invalid", we can make all mutex users assume they need the slow
syscall path on uncontended acquisition. And assert_nrt will probably be
happy about a syscall replacement for u_mode when it became invalid.

This invalid state (maybe u_mode =3D=3D -1 with TLS, and mode_key =3D=3D =
NULL
without it) is entered during thread clean up with the help of a TSD
destructor. The destructor will then deregister our u_mode storage from
the kernel so that it doesn't matter if we release the memory
immediately and explicitly (w/o TLS) or leave this to glibc (/w TLS).
And in this model, it also doesn't matter when precisely the destructor
is called.

>=20
>> But I thought a bit more about a workaround for the existing ABI. We
>> basically need a way to free some memory as late as possible on thread=

>> deletion. Even when leaving garbage collection that no one really want=
s
>> aside, there might be some semi-perfect user-space-only solution:
>>
>> pthread_create_key says that TSD destructors are re-run after the firs=
t
>> round if their key value is still non-NULL. So we could at least work
>> around the already rare case that some TSD destructor past ours tries =
to
>> access an RT mutex or otherwise migrates the thread to RT again. For
>> this, we just need a counter (next to the mode storages) for the round=
=2E
>> If we are in round #1, we would restore the key value again instead of=

>> freeing it. On run #n < PTHREAD_DESTRUCTOR_ITERATIONS, we would finall=
y
>> free it in the hope we are the last interested in it. This just requir=
es
>> PTHREAD_DESTRUCTOR_ITERATIONS > 1, and that the application does not d=
o
>> this ugly dance as well AND also performs Xenomai calls.
>=20
> I have thought of another simpler fix: we leak the u_mode when
> kernel-support is too old, and whine loudly about it. For the other cas=
e

Leaking is not nice, but I guess an application will crash sooner over
the bug than this leak becomes a reason for a failure.

> (newer kernel-support with older user-space support), I was thinking
> about something else, which I still find complicated and far from
> perfect: handling the exit syscall by setting the u_mode pointer to NUL=
L
> because we know at that time the u_mode pointer points to free memory.
>=20

That would reduce the probability of a crash, right. Probably the best
we can do for old user land. And I don't think if should take more than
two lines of code in the syscall dispatching path.

Jan


--------------enig7512E801F661141467D31A8D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuQFz8ACgkQitSsb3rl5xTSywCeM5qYO+ng/GhyWjzBeAY1Vsaa
VnQAoLGjK5lZVC1bCIKLTjwxCPvApJCW
=C/ea
-----END PGP SIGNATURE-----

--------------enig7512E801F661141467D31A8D--

