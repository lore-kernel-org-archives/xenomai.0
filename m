Message-ID: <43EDE6D7.8050506@domain.hid>
Date: Sat, 11 Feb 2006 14:29:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] provide rtdm_mmap_to_user / rtdm_munmap
References: <43EBD9D6.5090404@domain.hid>
	<43EBE032.40302@domain.hid>	<200602101858.21108.lbocseg@domain.hid>
	<200602101928.52899.lbocseg@domain.hid>
	<43ED3165.3090300@domain.hid> <43EDE275.5040307@domain.hid>
In-Reply-To: <43EDE275.5040307@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2F2F69BDA862327489EA580C"
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
--------------enig2F2F69BDA862327489EA580C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Jan Kiszka escreveu:
>> Rodrigo Rosenfeld Rosas wrote:
>> =20
>>> Hi Jan, it just happened once and I couldn't reproduce (I didn't want=

>>> to reproduce it too since I would need to restart my computer because=

>>> the driver wouldn't unload)...
>>>
>>> When it happened I forgot to start the timer running the latency
>>> program and    =20
>>
>> Already running latest SVN version?
> Almost there ;) That is why your patch didn't apply cleany, but I just
> needed to include two "#include" and "#define" lines to drvlib.c or
> something like...
>=20
>>  rt_timer_start&friends became
>> deprecated last weekend, so you can't forget this step anymore.
>>  =20
> I didn't use rt_timer_start at all. I was doing as you suggested,
> calling another program to start the timer, like "latency".
>=20
>>> my driver failed to load and due to some mistake I've made (I have
>>> not indentified it yet), it crashed on rmmoding. I need to check
>>> this, but I still think it is a good idea to make the sanity checks..=
=2E
>>>    =20
>>
>> We need some XENO_ASSERT that is only active when CONFIG_XENO_OPT_DEBU=
G
>> is set. I don't want to put such checks in production code, but I see
>> that they may help debugging early drivers.
>>  =20
> I understand your concernings but I really don't think they are
> relevant... This checks will be much faster then the procedure itself
> and it would conform to normal munmap behaviour. From man page:
>=20
> "The address start must be a multiple of the page size. All pages
> containing a part of the indicated range are unmapped, and subsequent
> references to these pages will generate SIGSEGV. It is not an error if
> the indicated range does not contain any mapped pages."

XENO_ASSERT will not be a procedure, it will be a macro containing the
check for the assertion and the code to be executed on failure. The
point is just to control if this code will make it into the kernel or
not - via CONFIG_XENO_OPT_DEBUG. Kind of #ifdef CONFIG_XENO_OPT_DEBUG,
just more comfortable. A typical bug-free driver will not need such
checks as it will just pass those values already use for or returned by
rtdm_mmap_to_user. This is not just about speed, it's also about code siz=
e.

>=20
> I think that if there was an extra parameter for user_info, it would
> also verify for validity. BTW, I think there is missing some
> documentation about the user_info parameter. I had to remember our
> conversation and look at the code to understand that I should record
> "current" on this parameter on the moment I called mmap and passing it
> again on munmap. And it would be good to see the rtdm_user_info_t
> defined as struct task_struct on the documentation.

This is intentionally opaque to the driver developer. As you receive a
rtdm_user pointer via the device handler invocation (as documented in
rtdm_mmap_to_user - feel free to improve my description!), you don't
need to (and you actually shouldn't) deal with task_struct or even mm
directly.

Moreover, I have an experimental (and unreleased) Xenomai skin with RTDM
support here which maps rtdm_user_info_t to a different type.

>=20
>>> I have not written the user-space program yet, so you'll have to wait=

>>> until monday, when I'll be able to test it, hopefully. But it seems
>>> to be working... I changed my driver design. I do the mmap's on
>>> driver initialization and just pass the returned addresses on the
>>> IOCTL, so I can do them in a RT-context. The problem is that even if
>>> the user call an IOCTL to    =20
>>
>> Hmm, I guess there is still some lacking documentation about what is
>> possible with RTDM. If you call an IOCTL from RT context, you end up i=
n
>> the _rt-handler the driver of a device may have registered (if there i=
s
>> no _rt-handler at all, the _nrt one is invoked, but this is likely not=

>> relevant here).
>>
>> I assume that you were wondering how to call rtdm_mmap_to_user from th=
is
>> real-time handler, right?
> No. I know it is not possible from the moment. I think I did not explai=
n
> myself very well. I was wondering how to define a RT mmap like ioctl. A=
s
> I know I could not use rtdm_mmap_to_user then, I thought in another way=

> of doing it. So I mmaped on driver initialization. On the IOCTL I just
> passed the already known addresses to the user requesting it. I would
> have to explain you how these buffers work on V4L2. It is a bit long
> explanation but I can explain it on other message if you wish.

I had a look at a V4L2 tutorial, and I think I grabbed the idea. This
idea does *not* include any mmap during runtime, just once after device
opening and buffer setup. I think you shouldn't follow the syntactic
V4L2 interface, rather grab it's overall model.

That's also why I cannot follow your desire for a transparent rt-mmap
implementation. I tried to define such a wrapper, but I didn't find it
useful, rather problematic as a lot of restrictions from the normal mmap
had to be defined.

Don't forget that normal mmap is a very generic interface, covering also
a lot of use cases (files e.g.) we will never see with RTDM. As it is
the standard interface for mapping, V4L2 likely does this split-up of
buffer allocation (via IOCTL) and mapping (via mmap). With
rtdm_mmap_to_user, this is not required! There are a few DRM Linux
driver unifying those steps as well, BTW.

>=20
>> Well, the trick is to return -ENOSYS for those
>> IOCTL codes that can only be handled by the _nrt-handler. Xenomai will=

>> then switch your RT task to secondary mode, restart the IOCTL, and the=

>> mmap can safely be executed.
>>  =20
> But as I've said, it is not the behaviour I want :)
>=20
>> Well, maybe you do not have any arguments for rtdm_mmap_to_user that
>> should be influenced by the user's IOCTL.
> That is my case.
>=20
>> In this case your current driver design is ok as well. I just wanted
>> to underline that it is not necessarily the only way.
>>  =20
> But I couldn't find other way of doing it in a RT-context.

As explained before, it doesn't make sense to mmap in time-constraint
contexts, even if we are only talking about standard Linux. No
high-speed capturing application will do this - especially under Linux.

>=20
>>> munmap, it will still be possible to him to continue using the
>>> provided address and this would result in a problem. But, as in all
>>> situations, there    =20
>>
>> When rtdm_munmap is executed, the virtual address range becomes invali=
d
>> for the user. Thus any further access to it will raise a segfault.
>> That's the only problem, but it will not influence the driver integrit=
y.
>>  =20
> Yes, that is the problem. Since I only mark as unused on the munmap
> IOCTL, it would be possible to the user to continue using that address
> even after the munmap IOCTL call. It I was using a really rtdm_munmap,
> it wouldn't be possible. It would be a better behaviour, but it would
> not be run on RT-context. That is the trade-off.

If you avoid mmap in RT, there will also be no need for munmap in this
context. Just release it on closure.

>=20
>>> are trade-offs and I prefer to rely on the user, while providing a
>>> RT-MMAP-IOCTL. Of course it isn't really a mmap, but if the user
>>> don't mess with the pointers, it will work like if it was...
>>>    =20
>>
>> The user can only access the window you mapped in and only as long as =
it
>> is mapped.
> In my case, it is always mapped to make possible the RT-IOCTLs.
>> And if you map it read-only, there is even no chance to
>> destroy potential management structures of the hardware or the driver
>> within this range.
>>  =20
> I do not want to make it read-only because it will probably be very
> usefull to the user to write on it. The user may want to capture a fram=
e
> and do some image processing routines on the same memory area when it i=
s
> possible, avoiding to copy that memory region.

I see, this makes sense. Then just prepare enough buffers for the
capturing, preprocessing, and potentially forwarding steps so that you
can continue to capture even if the user still hogs on a few previously
filled buffers. In the end it's just a cyclic process, and the only
question is how many spare buffers have to be created to keep it running.=


>>> Hope you understood me, I wrote it a little confusing... :)
>>>    =20
>>
>> We will see...
>>  =20
> :)
>> Happy WE,
>>  =20
> Happy weekend for you too,
>=20
> Rodrigo.
>=20
>=20

Jan


--------------enig2F2F69BDA862327489EA580C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD7ebXniDOoMHTA+kRAjuMAJ4y1OaiWX6YLYg2seaCXmAiEFNdzACeNTuc
pCruRz6XJ292N9vAhGjk5/4=
=DLiY
-----END PGP SIGNATURE-----

--------------enig2F2F69BDA862327489EA580C--

