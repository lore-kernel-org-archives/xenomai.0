Message-ID: <4ADB56C1.8020103@domain.hid>
Date: Sun, 18 Oct 2009 19:56:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AD8A87C.4040706@domain.hid>	
	<1255799737.2862.15.camel@domain.hid> <4ADB100B.1060300@domain.hid>
	<1255884524.2862.77.camel@domain.hid>
In-Reply-To: <1255884524.2862.77.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE1432293737F22C25250945A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Native: Fixing auto-cleanup
List-Id: Xenomai life and development <xenomai.xenomai.org>
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
--------------enigE1432293737F22C25250945A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2009-10-18 at 14:54 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Fri, 2009-10-16 at 19:08 +0200, Jan Kiszka wrote:
>>>> Hi,
>>>>
>>>> our automatic object cleanup on process termination is "slightly" br=
oken
>>>> for the native skin. The inline and macro magic behind
>>>> __native_*_flush_rq() blindly calls rt_*_delete(), but that's not
>>>> correct for mutexes (we can leak memory and/or corrupt the system he=
ap),
>>>> queues and heaps (we may leak shared heaps).
>>> Please elaborate regarding both queues and heaps (scenario).
>> Master creates heap, slave binds to it, master wants to terminate (or =
is
>> killed, doesn't matter), heap cannot be released as the slave is still=

>> bound to it, slave terminates but heap object is still reserved on the=

>> main heap =3D> memory leak (just confirmed with a test case).
>=20
> This fixes it:
>=20
> diff --git a/ksrc/skins/native/heap.c b/ksrc/skins/native/heap.c
> index 0a24735..0fcb3c2 100644
> --- a/ksrc/skins/native/heap.c
> +++ b/ksrc/skins/native/heap.c
> @@ -340,6 +340,11 @@ static void __heap_post_release(struct xnheap *h)
>  		xnpod_schedule();
> =20

+ xeno_mark_deleted(heap);

But I still think this approach has too complex (and so far
undocumented) user-visible semantics and is going the wrong path.

>  	xnlock_put_irqrestore(&nklock, s);
> +
> +#ifdef CONFIG_XENO_OPT_PERVASIVE
> +	if (heap->cpid)
> +		xnfree(heap);
> +#endif
>  }
> =20
>  /**
> diff --git a/ksrc/skins/native/queue.c b/ksrc/skins/native/queue.c
> index 527bde8..50af544 100644
> --- a/ksrc/skins/native/queue.c
> +++ b/ksrc/skins/native/queue.c
> @@ -303,6 +303,11 @@ static void __queue_post_release(struct xnheap *he=
ap)
>  		xnpod_schedule();
> =20
>  	xnlock_put_irqrestore(&nklock, s);
> +
> +#ifdef CONFIG_XENO_OPT_PERVASIVE
> +	if (q->cpid)
> +		xnfree(q);
> +#endif
>  }
> =20
>  /**
>=20
>> I'm not sure if that object migration to the global queue helps to som=
e
>> degree here (it's not really useful due to other problems, will post a=

>> removal patch) - I've build Xenomai support into the kernel...
>>
>=20
> This is a last resort action mainly aimed at kernel-based apps, assumin=
g
> that rmmoding them will ultimately flush the pending objects. We need
> this.

Kernel-based apps do not stress this path at all, their objects are
already in the global queue. Only user-allocated objected can be requeued=
=2E

And that either indicates open issues in the cleanup path (ie. some
objects may practically never be deleted) or is superfluous as a
deferred cleanup mechanism will take care (namely the one of the xnheap).=


>=20
> We might want to avoid linking to the global queue whenever the deletio=
n
> call returns -EBUSY though, assuming that a post-release hook will do
> the cleanup, but other errors may still happen.

Even more important: -EIDRM, or we continue to risk serious corruptions.
Better remove this altogether.

>=20
>>>> I'm in the process of fixing this, but that latter two are tricky. T=
hey
>>>> need user space information (the user space address of the mapping b=
ase)
>>>> for ordinary cleanup, and this is not available otherwise.
>>>>
>>>> At the time we are called with our cleanup handler, can we assume th=
at
>>>> the dying process has already unmapped all its rtheap segments?
>>> Unfortunately, no. Cleanup is a per-skin action, and the process may =
be
>>> bound to more than a single skin, which could turn out as requiring a=

>>> sequence of cleanup calls.
>>>
>>> The only thing you may assume is that an attempt to release all memor=
y
>>> mappings for the dying process will have been done prior to receive t=
he
>>> cleanup event from the pipeline, but this won't help much in this cas=
e.
>> That's already very helpful!
>>
>=20
> Not really, at least this is not relevant to the bug being fixed.
> Additionally, the release attempt may fail due to pending references.

For which kind of objects? What kind of references? At least according
to the docs, there is only the risk of -EBUSY with heaps and queues. All
other objects terminate properly.

>=20
>>> This attempt may fail and be postponed though, hence the deferred
>>> release callback fired via vmclose.
>> I already started to look into the release callback thing, but I'm sti=
ll
>> scratching my head: Why do you set the callback even on explicit
>> rt_heap/queue_delete? I mean those that are supposed to fail with -EBU=
SY
>> and then to be retried by user land?
>=20
> Userland could retry, but most of the time it will just bail out and
> leave this to vmclose.
>=20
>>  What happens if rt_heap_unbind and
>> retried rt_heap_delete race?
>>
>=20
> A successful final unmapping clears the release handler.

rt_heap_unbind would trigger the release handler, thus the object
deletion, and the actual creator would find the object destroyed under
its feet despite failed deletion is supposed to leave the object intact.
That's the kind of complex semantics I was referring to.

Let's get this right: If the creator of a shared semaphore deletes that
object, it's synchronously removed; anyone trying to use it is informed.
That's reasonable to expect from heaps and queues as well, IMHO. The
only exception is the mapped memory of the associated heaps. It must not
vanish under other users feet. But they will no longer be able to issue
native commands on those objects.

>=20
>> Anyway, auto-cleanup of heap and queue must be made none-failing, ie.
>> the objects have to be discarded, just the heap memory deletion has to=

>> be deferred. I'm digging into this direction, but I'm still wondering =
if
>> the none-automatic heap/queue cleanup is safe in its current form.
>>
>=20
> This seems largely overkill for the purpose of fixing the leak. Granted=
,
> the common pattern would rather be to invalidate the front-end object
> (heap/queue desc) and schedule a release for the backend one (i.e.
> shared mem). However, the only impact this has for now is to allow apps=

> to keep an object indefinitely busy by binding to it continuously albei=
t
> a deletion request is pending; I don't think this deserves a major
> change in the cleanup actions at this stage of 2.5. Cleanup stuff
> between userland and kernel space is prone to regression.

It's not overkill, it's required to reduce complexity, simplify the
semantics, and reducing risks of more hidden bugs in yet unstressed
corner cases. IMHO, -EBUSY on rt_heap/queue_delete is inappropriate.

Jan


--------------enigE1432293737F22C25250945A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrbVsgACgkQitSsb3rl5xT3dgCfXnJLIePJ7zcrIL5jNwJytU9w
hTMAoO1jXXGEXW6bDReuq0tH5ICwmE+r
=K7KW
-----END PGP SIGNATURE-----

--------------enigE1432293737F22C25250945A--

