Message-ID: <46C03422.10304@domain.hid>
Date: Mon, 13 Aug 2007 12:36:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <e39c9190708121709u765ab036w242c0c846c9c82f5@domain.hid>	
	<46C01909.5020308@domain.hid>
	<e39c9190708130254x421a54b8le92acbf974a6fa58@domain.hid>
In-Reply-To: <e39c9190708130254x421a54b8le92acbf974a6fa58@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC086162A51A485C8FC579176"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] RTDM 82527 Xenomai driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: juanba romance <juanba.romance@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC086162A51A485C8FC579176
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

juanba romance wrote:
> On 8/13/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> juanba romance wrote:
>>> Hello, all,
>>> I am currently developing a RTDM/xenomai driver for the CANbus chipse=
t
>> 82527
>>> that i think it could have some interest
>>> it has the next features:
>> Thanks for moving our private thread here! See, now we know that
>> Wolfgang is already working on 82527 support for RT-Socket-CAN -
>> something I wasn't aware of as well.
>>
>>>    1. Specific management for the remote frames CANbus feasibility, i=
t
>>>    couple the real-time data bus flow with a user software feedback t=
o
>>>    handshake remote frames and update mailbox callback for the
>> auto-replied
>>>    messages
>> Mind to elaborate what you precisely gain here compared to "open-coded=
"
>> designs (loop closed over the application)? Can you quantify the
>> improvements?
>=20
>=20
> After review your current user interface i can not understand how a RF =
cycle
> flows through the user application
> holding as much as possible the latency at the receiver side. Maybe it'=
s my
> own misunderstanding.
> The point is one node requests an information to another one issuing a =
RF,
> the CAN specification says that the RF receptor will handshake the cycl=
e
> issuing the corresponding DF, and right here is when/where i am fuzzy. =
We
> use this capability using real time as much as possible only relying on=
 the
> CANbus network load, i mean we perform the RF handshake using the RF
> receptor mailbox auto-reply capability, feedbacking the user software o=
nly
> when the DF handshake is decoded at the network, this event will trigge=
r the
> user actions i.e. the message data update with the new local variables
> state. This feature is requested through  the configuration stage, this=
 kind
> of information is labeled as "quick.ack" responses , cause are not rela=
ted
> with software at all. The RF requester has the guarantee  that the
> information is sampled with any jitter software coupled. The typical
> approach found in other stacks is labelled as "slow.ack", it avoids to
> response the RF-request up to reach any software area (kernel/user spac=
es)
> that explicitly issue the data-frame as usual, this is how can-festival=

> currently works.

The point is that quite a few CAN controllers do not support this
hardware-based RF reply. And as Socket-CAN aims at a _generic_ API, not
the n-th Intel or MSCAN or whatever CAN stack, we had to define the
basic interface without such special support first.

But that doesn't mean we would be unable to extend the profile with
optional or, when required, software-emulated accelerations like for RTR
handling. That's what we're interested in: How may such an extension
look like to exploit the hardware to its limits where available,
_without_ giving up CAN application portability?

>=20
> Both operations are included in the proposal.
>=20
>>    2. Transparent use to push/suck data from the driver using a common=

>>>    data format
>>>    3. Capability to push a bunch of CANbus messages in a single syste=
m
>>>    call. The bunch is copied to a kernel domain ring buffer to guaran=
tee
>> low
>>>    latencies at the user side. A specific kernel thread  sucks the ri=
ng
>> pushing
>>>    the user request into the chipset
>> That was discussed before in the context of Socket-CAN. My feeling is
>> that it /could/ be useful in case you have to issue longer streams of
>> CAN frames at high rates, and specifically if your CAN hardware can
>> handle these streams autonomously. Is the 82527 able to do so?
>>
>> In any case, this would complicate the existing stack and driver and
>> would first require careful evaluation of the achievable improvement
>> (lower latency, lower system load?).
>=20
> The i82527 has 15 mailboxes with fixed priority, the lowest one is hard=
wared
> to the RX operation. So theoretically  you can pipeline up to 14 TX
> messages. When the stuff is full, we are labeled it as a  "pileup"  bec=
ause
> the hardware handler has to wait up to get some free one, this operatio=
n is
> performed in our case through the either the mailbox-alarm mechanism or=
 the
> ISR transmission side . I have mention the "low latency" term, cause i =
have
> decoupled the loopback-tx feedback from the ISR to a kernel RT thread/t=
ask
> so the ISR only cleans/stops the mailbox software/hardware resources. T=
he

So you already have task context here (+ the challenge to manage
priorities). Did you measure the difference in latencies between kernel
and user space on your platform? If your hardware is slow (ISA...)
and/or the platform is fast, that doesn't make much difference anymore,
thus you are already half way to use the standard API, maybe with some
CAN library for the boring routine work.

> user call is only blocked the time required to push the message bunch i=
nto
> the transmission ring. The physical user transmission is performed in
> open-loop if no error/alarm is sampled..
>=20
>=20
>>>    4. Driver readout using a native RT message queue where the contro=
l
>>>    and data flow is published
>> And this way you make your driver unportable, e.g. to move it over the=

>> RTDM layer Wolfgang wrote for the -rt kernel. RTDM drivers are ought t=
o
>> use RTDM services (or Linux ones), not other skins. If a generally
>> useful service is lacking, we need to think about adding it - to RTDM.=

>>
> Fully deliberated. this is one the reason cause i labelled the stuff as=

> "xenomai-RTDM" instead of "RTDM". I assume that the native layer is
> available to be used at all. My first intention is not to build somethi=
ng
> fully compliance with the RTDM layer, this is a second step from my poi=
nt of
> view. I need ASAP the driver ready to be used in a Xenomai framework  w=
here
> our applications are running..

Yeah, the old problem: "But we need it immediately!" However, keep in
mind: CAN controllers come and go (just as SoC come an go), the
programming model should be there to stay. And using a standard API,
maybe tuning it in the direction you need, raises the chances that
future hardware vendors get "inspired" by that interface as well.

>=20
>>    5. Multichipset capabilities, right now a commercial PC104 board wi=
th
>>>    two devices is used. The on board CPU is a SBC VIA C3 1GHz process=
or
>>>    softwared with the stack xenomai-2.3,1/vanilla-2.6.20-15/Adeos-
>>>    ipipe-1.7-03
>>>    6. board monitoring through the /proc file system entry
>>>    7. Local Data Transfers controlled with RT-alarms
>> Another violation - but this one is easily avoidable with RTDM timers
>> that come with API revision 6 (upcoming Xenomai 2.4).
>=20
> Same as above
>=20
>=20
>>    8. Virtual support to check applications/driver usage/design, right=

>>>    now only the chipset is virtualised, but plans to have network
>> transactions
>>>    are on going
>>>    9. ISR hardware optimizations focused on the network readout to
>>>    gurantee low latencies
>> Any numbers?
>=20
> Right now i am on holidays and i can't not run any scope test, but i
> remember that the worst case was around to 100usec to fully read the ma=
ilbox
> plenty of 8 bytes. It is fully coupled to the hardware ISA mapping, eve=
ry
> chipset register read cycle requires three io operations to write the
> addressed register, perform a dummy read  and the valid read one. This
> killer takes 500nsec to each chipset select activation, but the most bu=
rner
> is 1000nsec between each in,out IO address space instruction so around
> 4usec/sucked byte,
> We have implementing the chipset clearing and data sucking with ~ 20 io=

> cycles , so the numbers fit quite with the xenomai-i386 latencies.

So the programming model of the driver is actually not the core issue
(taking aside true hardware acceleration where available).

>=20
>>    10. Easy porting to other i82527 based on boards
>>>    11. Full transmission operation handling the 16 message object set=

>>>
>>> We have in plan also
>>>
>>>    1. Capabilities to filtering/masking the incoming flow at the driv=
er
>>>    stage allowing that the same context, using the "xenomai
>> nomenclature" feed
>>>    specific threads using some kind of binding/configuration process.=

>> This is
>>>    an open issue cause i don't have a clear approach to follow..
>>>    2. can-festival coupling
>> Look, with Socket-CAN, you would now already have CAN-Festival binding=
=2E :)
>=20
> Yes, i know it's clear motivation to use it ;-)
>=20
>=20
>> But maybe this library scenario can be used to explain why you need to=

>> do things in a special way and what you can gain that way. Looking
>> forward!
>=20
> From my point of view the RTDM layout is ideal to perform linux porting=

> The fact related on with the missed chipset support and the gained
> experience developing standard linux drivers using this chipset biased =
my
> approach a lot. For sure, that if the chipset support were provided in =
time
> we will re-consider the stuff to re-usage/patch the official stack if t=
he
> latencies are similar..

You will definitely be welcome to contribute!

Jan


--------------enigC086162A51A485C8FC579176
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGwDQiniDOoMHTA+kRAry3AJ9IHAMe6llvRmr91m5tjRLsE+WjcwCfbBcE
ojVrZEDPpnHnqIGBcJ5HQZw=
=hkZW
-----END PGP SIGNATURE-----

--------------enigC086162A51A485C8FC579176--

