Message-ID: <455D8B23.20600@domain.hid>
Date: Fri, 17 Nov 2006 11:12:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <455D6F83.40008@domain.hid> <455D7FCE.5050209@domain.hid>
In-Reply-To: <455D7FCE.5050209@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig94F1AB3BC7200E88BBEEE095"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [Xenomai-help] Draft  for a RTDM I2C driver
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
--------------enig94F1AB3BC7200E88BBEEE095
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dirk Eibach wrote:
> jan.kiszka@domain.hid wrote:
>> Dirk Eibach wrote:
>>> Hello,
>>>
>>> I have spent some time designing a RTDM I2C driver based on the linux=

>>> i2c driver. It's stripped down in some aspects but porting existing
>>> clients and adapters should be fairly easy.
>>> For this draft I have ported the IBM PPC4xx driver, because that is w=
hat
>>> I have here for testing.
>>>
>>> It's my first RTDM project, so I hope I haven't messed things up too
>>> much.
>>>
>>> Any comments welcome!
>>>
>>
>> Great! I almost forgot this topic as it was quiet after my reply, but
>> now we even have code to discuss.
>=20
> It took some time for me to understand the RTDM concepts and to
> understand what the i2c linux driver is doing.
>=20
>> Before I start looking into implementation details, it would be nice i=
f
>> you could sketch the basic idea of your API proposal and the typical u=
se
>> cases. Code is more explicit, I know, but it's also a bit more tricky =
to
>> grab an overview from it. Do you also have some simple demo to show ho=
w
>> one should use your interface?
>=20
>> What I grabbed so far:
>>  - for each I2C interface, a RTDM device is registered
>>  - rti2c-api.h is ought to become the RTDM I2C device profile
>>  - we have read/write and a bunch of IOCTLs as API
>=20
> Here is a typical usecase:
>=20
>   int fd;
>=20
>   //open a instance of the RTDM device
>   fd =3D rt_dev_open( "rti2cppc4xx", 0);

I think we should define a more generic naming scheme here to make
application code easier portable. I guess there can alos be more than
one I2C controller on some system, right?

>=20
>   // set the address of the device on the bus
>   rt_dev_ioctl(fd, RTI2C_SLAVE, addr);

Is the typical use case to not change the slave address that often,
rather to use separate device instances for accessing different slaves?
I'm wondering if a combined address+request command may make sense.
Maybe even a socket-based protocol device would match as well, maybe
even better... (needs more thinking, I guess)

Does Linux expose a similar API via some character devices? Keeping the
distance to Linux low might be a reason to not go the socket path.

>=20
>   // write a value to register of the addressed device
>   rti2c_smbus_write_byte_data(fd, register, value);
>=20
>   rt_dev_close(fd);
>=20
>=20
> Many common i2c usecases are packed in inline functions in rti2c-api.h
> so you don't need to fiddle with IOCTLs that much.

Looks nice. A few of those inlines should become library functions,
though. But that's something to optimise later.

>=20
>> What I didn't grabbed:
>>  - is transfer synchronous or asynchronous?
>>  - can applications access an adapter concurrently?
>>  - what are the major differences to the Linux model?
>=20
> The interface is synchronous (just like its linux pendant). Application=
s
> can access an adapter concurrently, access is serialized in
> rti2-core.c/rti2c_smbus_xfer by a (per adapter) mutex.

So the typical path looks like this:
 1. [depending on data size: allocate temporary buffer]
 2. acquire interface mutex
 3. issue request
 4. pend on reply
hardware is working...
 5. completion IRQ arrives and wakes up pending task
 6. collect request result
 7. release mutex
 8. [release buffer]

A few thoughts on this:

 - What are typical delays between 4. and 5.? Does it makes sense for
   short requests to busy-wait (to avoid the scheduler/IRQ overhead)?
   I've seen that there is some polling path included in the code, but
   that would break as it calls into Linux.

 - Will a request always return? Or does it make sense to establish an
   (optional) timeout mechanism here?

 - Buffer allocation for short requests may also happen on the stack, I
   think.

 - Buffer allocation for large requests may (optionally) happen
   ahead-of-time via some special IOCTL. This would make a device
   independent of the current system heap usage/fragmentation.

 - During concurrent use, the latency of an user is defined by its
   priority, of course, and the number and lengths of potentially issued
   request of some lower priority user, right? Is there a way one could
   intercept a pending request list? Or is this list handled in toto to
   the hardware? Melts down to "how to manage the bandwidth according to
   the user's priority".

>=20
> The linux implementation has not only the device driver interface but
> also a kernel-api. There is a i2c_driver concept, that enables you to
> provide device drivers for i2c (client-)devices as kernel modules. I
> left out this concept because I thought it does not fit the RTDM concep=
t.

Actually, this fits very will in the RTDM concept in so far that RTDM
can provide exactly the same API you defined for user-space also in
kernel space. It just takes to handle the case "user_info =3D=3D NULL" wh=
ere
no address checks and copy_to/froms are needed. Check other RTDM drivers
on this.

Moreover, in-kernel drivers could make use of direct invocations of
RTI2C services, check this service

http://www.xenomai.org/documentation/trunk/html/api/group__interdrv.html#=
g99e8509f4c8b404f0d5795b575d4c9cb

Once you locked the context, you can call into the RTDM device's
handlers directly with the demux'ing of your current file descriptor.

> Further I left out all the sysfs stuff.

That's ok.

>=20
>> I'm looking forward to see some nice generic RTI2C in Xenomai soon(er =
or
>> later)!
>=20
> Me too :)

My current optimistic feeling is that this could very well become stuff
for 2.4. Takes to stabilise the API (even if not all parts are
implemented then), document it like other RTDM profiles (e.g. CAN), and
iron the implementation. Sounds like a plan, doesn't it? :)

Jan


--------------enig94F1AB3BC7200E88BBEEE095
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFXYsjniDOoMHTA+kRAncqAJwOznFD5zHkrOWUhDYHvY4e5AENlQCeIZ/9
q+yZIYNIhobFtNHcRcwSZzo=
=DaFw
-----END PGP SIGNATURE-----

--------------enig94F1AB3BC7200E88BBEEE095--

