Message-ID: <5114E175.4080908@siemens.com>
Date: Fri, 08 Feb 2013 12:28:53 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <5113BFD0.7050501@hilscher.com> <5113D225.8030900@xenomai.org>
	<5114C05B.7040507@hilscher.com> <5114C302.5020209@xenomai.org>
In-Reply-To: <5114C302.5020209@xenomai.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, =?UTF-8?B?U3TDqXBoYW5lIExPUw==?= <slos@hilscher.com>
Cc: xenomai@xenomai.org

On 2013-02-08 10:18, Gilles Chanteperdrix wrote:
> On 02/08/2013 10:07 AM, St=C3=A9phane LOS wrote:
>=20
>> Le 07/02/2013 17:11, Gilles Chanteperdrix a =C3=A9crit :
>>> On 02/07/2013 03:53 PM, St=C3=A9phane LOS wrote:
>>>
>>>> Hello Sirs,
>>>>
>>>> Hilscher is offering a Linux driver based on UIO for cifX boards.
>>>>
>>>> In my understanding, down to 1ms cycle time, a PREEMPT RT solution
>>>> should be enough.
>>>>
>>>> The cifX boards can manage with bus cycle times down to 250=C2=B5s l=
ike with
>>>> EtherCAT or Sercos III firmwares.
>>>>
>>>> So it seems in that cases that using Xenomai would be the way to go.
>>>> I suppose that it would be needed to modify or change the existing
>>>> driver but I can't figure out how things (Xenomai / RTDM / UIO) fit
>>>> together.
>>>>
>>>> UIO is the kernel module that allows the mapping of the board memory=
 to
>>>> user space.
>>>>
>>>> The cifX driver uses the libpciaccess to pick up the board and retri=
eve
>>>> some board information from UIO before the mapping.
>>>> Then it uses pthread and rt functions when accessing the board.
>>>>
>>>> Since UIO and libpciaccess are only used during the initialization, =
is
>>>> it a problem for a Xenomai application ?
>>>>
>>>> We have setup a Xenomai system and tried to compile the user land
>>>> library with Xenomai options and flags and it seems we have been suc=
cessful.
>>>> The driver should be using the POSIX skin of Xenomai if we have been=
 lucky.
>>>>
>>>> I can't see why we would need RTDM. Any hint please ?
>>>>
>>>> I am an absolute beginner in the Xenomai arena, don't throw me to th=
e
>>>> lions...
>>>>
>>>
>>> If UIO is used to register an interrupt handler for instance, the
>>> interrupt handler will not be called in real-time context when used w=
ith
>>> Xenomai, so, you would have to use the (deprecated) native or posix s=
kin
>>> services to register a user-space interrupt handler, or more likely
>>> write an RTDM driver. On the other hand, if what you need is simply
>>> accessing the board registers through MMIO, then you do not need RTDM.
>>>
>>> While accessing registers from user-space may be tempting, there is a
>>> risk of ending up with an application where the driver code is not
>>> clearly separated. Writing a driver separated from the application is
>>> preferable, as it provides a sane isolation between the two. If you
>>> change the hardware, you just have to rewrite a driver which follows =
the
>>> same profile, if you want to write another application using the same
>>> driver, you can keep the driver.
>>>
>>
>> Thank you for your kind support Gilles.
>>
>> The cifX Device Driver is Hilscher's library to deal with cifX boards=20
>> and is available for the major OSes.
>> Additionally it is available to anybody as source code, the cifX Drive=
r=20
>> Toolkit when one has to create a driver for his own OS.
>>
>> This driver library accesses the board interface which is a Dual Port=20
>> Memory.
>>
>> So the user application shall use this layer and gets independence fro=
m=20
>> the target OS.
>>
>> I understand that we should create an RTDM driver instead of a UIO=20
>> driver and adapt the user library so that it uses the RTDM driver.
>=20
>>
>> Am I right ?
>=20
>=20
> I tried to explain why it may be better to create an RTDM driver, but i=
n
> this case this may not be the best option. The answer to your question
> depends on what you have to do to implement the driver. As I said, if
> you simply have to access MMIO registers, user-space may be fine, if yo=
u
> have to handle interrupts kernel-space (so, RTDM) is preferable.

Are we talking about linux/drivers/uio/uio_cif.c here? That one
obviously has interrupt support.

If your customers may want to use Xenomai 3 with I-pipe instead of
Preempt-RT underneath (both options will exist), RTDM will still be
required for interrupt handling. If you like to, you could propose such
a driver for Xenomai integration. That would ensure it will come with
future releases.

I also wonder if it didn't make sense for us to provide an UIO-like
infrastructure for such use cases (single-user device drivers with IRQ
event channel needs).

Jan

--=20
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

