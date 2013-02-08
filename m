Message-ID: <5114C302.5020209@xenomai.org>
Date: Fri, 08 Feb 2013 10:18:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5113BFD0.7050501@hilscher.com> <5113D225.8030900@xenomai.org>
	<5114C05B.7040507@hilscher.com>
In-Reply-To: <5114C05B.7040507@hilscher.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?U3TDqXBoYW5lIExPUw==?= <slos@hilscher.com>
Cc: xenomai@xenomai.org

On 02/08/2013 10:07 AM, St=C3=A9phane LOS wrote:

> Le 07/02/2013 17:11, Gilles Chanteperdrix a =C3=A9crit :
>> On 02/07/2013 03:53 PM, St=C3=A9phane LOS wrote:
>>
>>> Hello Sirs,
>>>
>>> Hilscher is offering a Linux driver based on UIO for cifX boards.
>>>
>>> In my understanding, down to 1ms cycle time, a PREEMPT RT solution
>>> should be enough.
>>>
>>> The cifX boards can manage with bus cycle times down to 250=C2=B5s li=
ke with
>>> EtherCAT or Sercos III firmwares.
>>>
>>> So it seems in that cases that using Xenomai would be the way to go.
>>> I suppose that it would be needed to modify or change the existing
>>> driver but I can't figure out how things (Xenomai / RTDM / UIO) fit
>>> together.
>>>
>>> UIO is the kernel module that allows the mapping of the board memory =
to
>>> user space.
>>>
>>> The cifX driver uses the libpciaccess to pick up the board and retrie=
ve
>>> some board information from UIO before the mapping.
>>> Then it uses pthread and rt functions when accessing the board.
>>>
>>> Since UIO and libpciaccess are only used during the initialization, i=
s
>>> it a problem for a Xenomai application ?
>>>
>>> We have setup a Xenomai system and tried to compile the user land
>>> library with Xenomai options and flags and it seems we have been succ=
essful.
>>> The driver should be using the POSIX skin of Xenomai if we have been =
lucky.
>>>
>>> I can't see why we would need RTDM. Any hint please ?
>>>
>>> I am an absolute beginner in the Xenomai arena, don't throw me to the=

>>> lions...
>>>
>>
>> If UIO is used to register an interrupt handler for instance, the
>> interrupt handler will not be called in real-time context when used wi=
th
>> Xenomai, so, you would have to use the (deprecated) native or posix sk=
in
>> services to register a user-space interrupt handler, or more likely
>> write an RTDM driver. On the other hand, if what you need is simply
>> accessing the board registers through MMIO, then you do not need RTDM.=

>>
>> While accessing registers from user-space may be tempting, there is a
>> risk of ending up with an application where the driver code is not
>> clearly separated. Writing a driver separated from the application is
>> preferable, as it provides a sane isolation between the two. If you
>> change the hardware, you just have to rewrite a driver which follows t=
he
>> same profile, if you want to write another application using the same
>> driver, you can keep the driver.
>>
>=20
> Thank you for your kind support Gilles.
>=20
> The cifX Device Driver is Hilscher's library to deal with cifX boards=20
> and is available for the major OSes.
> Additionally it is available to anybody as source code, the cifX Driver=
=20
> Toolkit when one has to create a driver for his own OS.
>=20
> This driver library accesses the board interface which is a Dual Port=20
> Memory.
>=20
> So the user application shall use this layer and gets independence from=
=20
> the target OS.
>=20
> I understand that we should create an RTDM driver instead of a UIO=20
> driver and adapt the user library so that it uses the RTDM driver.

>=20
> Am I right ?


I tried to explain why it may be better to create an RTDM driver, but in
this case this may not be the best option. The answer to your question
depends on what you have to do to implement the driver. As I said, if
you simply have to access MMIO registers, user-space may be fine, if you
have to handle interrupts kernel-space (so, RTDM) is preferable.

--=20
                                                                Gilles.


