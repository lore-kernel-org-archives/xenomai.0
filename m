Message-ID: <4AEFE941.1050805@domain.hid>
Date: Tue, 03 Nov 2009 09:26:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20091020113724.9069.23594.stgit@domain.hid>	<20091020113725.9069.28060.stgit@domain.hid>	<1256404942.2862.498.camel@domain.hid>	<1257177854.2065.616.camel@domain.hid>	<4AEF0BCC.2020208@domain.hid>	<1257180716.2065.618.camel@domain.hid>	<4AEF0F7F.2060603@domain.hid>
	<4AEF1E91.6030407@domain.hid>
	<1257186409.2210.0.camel@domain.hid>
In-Reply-To: <1257186409.2210.0.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig07A071E5819B5BA18A93C7D7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH v3 5/9] nucleus: Avoid returning errors
	from xnheap_destroy_mapped
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig07A071E5819B5BA18A93C7D7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2009-11-02 at 19:01 +0100, Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> On Mon, 2009-11-02 at 17:41 +0100, Jan Kiszka wrote:
>>>>> Philippe Gerum wrote:
>>>>>> On Sat, 2009-10-24 at 19:22 +0200, Philippe Gerum wrote:
>>>>>>> On Tue, 2009-10-20 at 13:37 +0200, Jan Kiszka wrote:
>>>>>>>> Allowing xnheap_delete_mapped to return an error and then attemp=
ting to
>>>>>>>> recover from it does not work out very well: Corner cases are ra=
cy,
>>>>>>>> intransparent to the user, and proper error handling imposes a l=
ot of
>>>>>>>> complexity on the caller - if it actually bothers to check the r=
eturn
>>>>>>>> value...
>>>>>>>>
>>>>>>>> Fortunately, there is no reason for this function to fail: If th=
e heap
>>>>>>>> is still mapped, just install the provide cleanup handler and sw=
itch to
>>>>>>>> deferred removal. If the unmapping fails, we either raced with s=
ome
>>>>>>>> other caller of unmap or user space provided a bogus address, or=

>>>>>>>> something else is wrong. In any case, leaving the cleanup callba=
ck
>>>>>>>> behind is the best we can do anyway.
>>>>>>>>
>>>>>>>> Removing the return value immediately allows to simplify the cal=
lers,
>>>>>>>> namemly rt_queue_delete and rt_heap_delete.
>>>>>>>>
>>>>>>>> Note: This is still not 100% waterproof. If we issue
>>>>>>>> xnheap_destroy_mapped from module cleanup passing a release hand=
ler
>>>>>>>> that belongs to the module text, deferred release will cause a c=
rash.
>>>>>>>> But this corner case is no new regression, so let's keep the hea=
d in the
>>>>>>>> sand.
>>>>>>> I agree with this one, eventually. This does make things clearer,=
 and
>>>>>>> removes some opportunities for the upper interfaces to shot thems=
elves
>>>>>>> in the foot. Merged, thanks.
>>>>>> Well, actually, it does make things clearer, but it is broken. Ena=
bling
>>>>>> list debugging makes the nucleus pull the break after a double unl=
ink in
>>>>>> vmclose().
>>>>>>
>>>>>> Basically, the issue is that calling rt_queue/heap_delete() explic=
itly
>>>>>> from userland will break, due to the vmclose() handler being indir=
ectly
>>>>>> called by do_munmap() for the last mapping. The nasty thing is tha=
t
>>>>>> without debugs on, kheapq is just silently trashed.
>>>>>>
>>>>>> Fix is on its way, along with nommu support for shared heaps as we=
ll.
>>>>> OK, I see. Just on minor add-on to your fix:
>>>>>
>>>>> diff --git a/ksrc/nucleus/heap.c b/ksrc/nucleus/heap.c
>>>>> index ec14f73..1ae6af6 100644
>>>>> --- a/ksrc/nucleus/heap.c
>>>>> +++ b/ksrc/nucleus/heap.c
>>>>> @@ -1241,6 +1241,7 @@ void xnheap_destroy_mapped(xnheap_t *heap,
>>>>>  		down_write(&current->mm->mmap_sem);
>>>>>  		heap->archdep.release =3D NULL;
>>>>>  		do_munmap(current->mm, (unsigned long)mapaddr, len);
>>>>> +		heap->archdep.release =3D release;
>>>>>  		up_write(&current->mm->mmap_sem);
>>>>>  	}
>>>>> =20
>>>>> @@ -1252,7 +1253,6 @@ void xnheap_destroy_mapped(xnheap_t *heap,
>>>>>  	if (heap->archdep.numaps > 0) {
>>>>>  		/* The release handler is supposed to clean up the rest. */
>>>>>  		XENO_ASSERT(NUCLEUS, release !=3D NULL, /* nop */);
>>>>> -		heap->archdep.release =3D release;
>>>>>  		return;
>>>>>  	}
>>>>> =20
>>>>>
>>>>> This is safer than leaving a potential race window open between dro=
pping
>>>>> mmap_sem and fixing up archdep.release again.
>>>>>
>>>> Actually, we have to hold the kheap lock, in case weird code starts
>>>> mapping randomly from userland without getting a valid descriptor
>>>> through a skin call.
>>> Yep, that as well.
>>>
>> Note that 6b1a185b46 doesn't obsolete my patch (pull it from my tree i=
f
>> you like).
>=20
> Are you still referring to a race with the vmclose() handler?
>=20

Went through it again, and it's safe as it is (my patch would actually
open a new whole) - dropped.

Jan


--------------enig07A071E5819B5BA18A93C7D7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrv6UUACgkQitSsb3rl5xSMXACfUA2y0OV8CbjiY+pqi59beRyY
8WgAoOw2CRGbC2PvE+uqRRTXxx9fkhAC
=NI4V
-----END PGP SIGNATURE-----

--------------enig07A071E5819B5BA18A93C7D7--

