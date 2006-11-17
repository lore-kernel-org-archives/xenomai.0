Message-ID: <455DAD3F.4090703@domain.hid>
Date: Fri, 17 Nov 2006 13:38:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <455D8B23.20600@domain.hid> <455DA508.4050400@domain.hid>
In-Reply-To: <455DA508.4050400@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAD57089CDA5F85A86EBE53B5"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [Xenomai-help] Draft   for a RTDM I2C driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dirk Eibach <eibach@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAD57089CDA5F85A86EBE53B5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dirk Eibach wrote:
>>>
>>>   //open a instance of the RTDM device
>>>   fd =3D rt_dev_open( "rti2cppc4xx", 0);
>>
>> I think we should define a more generic naming scheme here to make
>> application code easier portable. I guess there can alos be more than
>> one I2C controller on some system, right?
>=20
> At the moment the devicename is defined by the caller of
> rti2c_adapter_register().
> When the device is registered a number is assigned to the adapter. Mayb=
e
> the devicename could be made up of some fixed text like "rti2c" followe=
d
> by the number that is assigned to the adapter.

That was the idea behind it. Given the RTI2C is generic (and it looks
like it is), you can than write a generic application, opening "rti2c0"
more or less blindly without knowing the adapter behind it.

>=20
>>>   // set the address of the device on the bus
>>>   rt_dev_ioctl(fd, RTI2C_SLAVE, addr);
>>
>> Is the typical use case to not change the slave address that often,
>> rather to use separate device instances for accessing different slaves=
?
>> I'm wondering if a combined address+request command may make sense.
>> Maybe even a socket-based protocol device would match as well, maybe
>> even better... (needs more thinking, I guess)
>>
>> Does Linux expose a similar API via some character devices? Keeping th=
e
>> distance to Linux low might be a reason to not go the socket path.
>=20
> The linux API is exactly the same. I had the same thoughts concerning
> combined commands (address+request) but maybe we could offer such
> commands as wrappers.

My concern was rather about performance than convenience. If a usage
pattern consists of almost as many address-set driver invocations as
actual requests, then you would benefit quite a lot from a combined
service call. But the question is, given that Linux uses the same API,
if that is really an expected use case and worth an optimisation effort.

=2E..
>> A few thoughts on this:
>>
>>  - What are typical delays between 4. and 5.? Does it makes sense for
>>    short requests to busy-wait (to avoid the scheduler/IRQ overhead)?
>>    I've seen that there is some polling path included in the code, but=

>>    that would break as it calls into Linux.
>=20
> Oops. I missed that schedule() call. Regarding typical delays I have to=

> admit that I have not measured yet, but I would estimate about 500 us
> for the above usecase. What would you estimate the scheduler/IRQ overhe=
ad?

Oh, 500 us is far more than you should see as "suspend-me +
switch-to-someone-else + raise-irq-and-switch-back-to-me" overhead even
on low-end PPC. Busy-waiting is something for a few microseconds.

>=20
>>  - Will a request always return? Or does it make sense to establish an=

>>    (optional) timeout mechanism here?
>=20
> A timeout mechanism is already there: rti2c_ppc4xx_wait_for_tc() uses
> rtdm_event_timedwait to wait for the interrupt to complete. Certainly
> that is left to the implementation of the adapter.

True, I missed this.

>=20
>>  - Buffer allocation for short requests may also happen on the stack, =
I
>>    think.
>=20
> That is already done. Have a look at the RTI2C_SMBUS IOCTL. Do you thin=
k
> it should also be possible to do this in the read/write calls denpendin=
g
> on the requested size?

I currently see allocations in RTI2C_RDWR (BTW, there is a forgotten
kmalloc) and in read/write. As I don't know the typical sizes of those
requests, I cannot judge on this. So take it as some food to think about.=


In contrast, the rtdm_malloc on adapter registration is overkill - this
will not happen in RT context, will it?

>=20
>>  - Buffer allocation for large requests may (optionally) happen
>>    ahead-of-time via some special IOCTL. This would make a device
>>    independent of the current system heap usage/fragmentation.
>>
>>  - During concurrent use, the latency of an user is defined by its
>>    priority, of course, and the number and lengths of potentially issu=
ed
>>    request of some lower priority user, right? Is there a way one coul=
d
>>    intercept a pending request list? Or is this list handled in toto t=
o
>>    the hardware? Melts down to "how to manage the bandwidth according =
to
>>    the user's priority".
>=20
> Concurrent use means that single RTI2C requests are called from
> different tasks. Each request is atomic (and usually quite small). So
> when a low-pri thread does a lot of requests a high-pri thread can get
> inbetween anytime. I think this way bandwidth is already managed proper=
ly.

So there is no interface where you can submit several requests as an
atomic chunk? Then I'm fine with what we have.

=2E..
>> Moreover, in-kernel drivers could make use of direct invocations of
>> RTI2C services, check this service
>>
>> http://www.xenomai.org/documentation/trunk/html/api/group__interdrv.ht=
ml#g99e8509f4c8b404f0d5795b575d4c9cb
>>
>>
>> Once you locked the context, you can call into the RTDM device's
>> handlers directly with the demux'ing of your current file descriptor.
>=20
> Are there any examples for this?

Hopelessly outdated, but the principle should be visible:

http://www.rts.uni-hannover.de/rtnet/lxr/source/examples/broken/netshm/ne=
tshm.c?v=3DSVN

Jan


--------------enigAD57089CDA5F85A86EBE53B5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFXa0/niDOoMHTA+kRAquSAJ9vR2E6rujjc/roznCMIyanS2J+ywCeIsIk
dRR7FlOej4/l5m4DvUhUKvI=
=5eRA
-----END PGP SIGNATURE-----

--------------enigAD57089CDA5F85A86EBE53B5--

