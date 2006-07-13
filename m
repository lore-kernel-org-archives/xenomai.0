Message-ID: <44B60E37.7060207@domain.hid>
Date: Thu, 13 Jul 2006 11:11:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] handling threads within a pod
References: <44B51D2C.10508@domain.hid> <44B52214.7050009@domain.hid>
	<44B60737.6050705@domain.hid>
In-Reply-To: <44B60737.6050705@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig40FC116655B156AC8D2DB45B"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Khalil GHORBAL <kg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig40FC116655B156AC8D2DB45B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Khalil GHORBAL wrote:
> Jan Kiszka wrote:
>=20
>> Khalil GHORBAL wrote:
>> =20
>>
>>> Hi,
>>>
>>> I'm trying to implement a new skin (IMA380) using xenomai framework.
>>>  =20
>>
>> Cool. Just learned that IMA380 is similar to ARNIC 653. Sounds quite
>> interesting. Will there be real partitioning? Will we get the chance t=
o
>> see/use the result some day?
>> =20
>>
> Thank you for your answer Jan.
>=20
> As I'm not the only concerned I can't give an answer rightnow,
> but if it depends only on me, yes, I'll share my work with every body,
> hoping it'll be useful.

Well, if you need some more argument for persuading those who may
decide: A contributed skin will also be easier to maintain. We may have
to adapt interfaces during future development, and if your code is part
of Xenomai then, it will be included in the required changes. Or the
modification will be reconsidered if it harms your skin unacceptably.

>=20
>> =20
>>
>>> When creating multiple xnthreads within a pod,
>>> I didn't found a way to access or handle these threads.
>>> Threads are linked to the global queue of a pod but how can I access =
to
>>> the other fields of xnthread structure ?
>>>
>>> hope it was clear :)
>>>  =20
>>
>> Not really. Do you mean how to handle references to those threads, how=

>> to pass them to the user and accept them back? Or do you mean how to
>> manipulate fields of the xnthread structure directly. The latter is
>> risky as you bypass the nucleus interface. Better check if some servic=
e
>> of the nucleus layer provide the required access. If not, elaborate wh=
at
>> kind of access you need.
>> =20
>>
> I'll give an example to explain the issue:
> Assuming having multiple threads in our active pod, these threads can b=
e
> in different states.
> The running thread have to get the *extinfo* field of thread named
> "COM_THREAD" (for example) if exists.

Looks like you'll be the first user of extinfo then. I wonder what it
should be useful for given that one normally embeds xnthread_t in a
container structure like this:

struct my_thread {
	xnthread_t thread_base;
	some_type some_additional_data;
};

Then, if you have a reference to a xnthread, you can easily resolve it
to your container thread:

my_thread_ptr =3D container_of(xnthread_ptr, struct my_thread,
			     thread_base);

To identify if this extension is valid, you can use the magic field in
xnthread (xnthread_get/set_magic).

[I'm picking on this as I feel like we could remove extinfo in the
future, but I might oversee some legitimate use-case right now.]

>=20
> All services of the nucleus need a *xnthread_t* structure to identify
> the thread to treat, we can't have a list or something similar to sweep=

> existing threads. All I've found is the global queue, doubly-linked and=

> circular, which link all threads.
> So all informations I have is the number of threads and a way to go fro=
m
> one holder to another
> without really be able to identify the thread and read the other fields=
=2E

Again, you can use the magic field. Or you can start maintaining your
own list of threads. The posix skin does it like this.

>=20
> I still misunderstood the function of global queue and how the pod
> schedule existing threads.

The global queue is mostly there for informative purposes, e.g. /proc
listings. There is also a usage scenario wrt round-robin. But scheduling
takes place based on the runqueues of each CPU.

Jan


--------------enig40FC116655B156AC8D2DB45B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEtg47niDOoMHTA+kRAo0dAJ0QPUGyb8oNx3l+US3/DSbBAaxa+gCfRIza
YoePnFFc+ctY4jv+YK3FNZ0=
=sCVJ
-----END PGP SIGNATURE-----

--------------enig40FC116655B156AC8D2DB45B--

