Message-ID: <46C01909.5020308@domain.hid>
Date: Mon, 13 Aug 2007 10:40:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <e39c9190708121709u765ab036w242c0c846c9c82f5@domain.hid>
In-Reply-To: <e39c9190708121709u765ab036w242c0c846c9c82f5@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig77EF35C988C5D0D7F9DE830A"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig77EF35C988C5D0D7F9DE830A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

juanba romance wrote:
> Hello, all,
> I am currently developing a RTDM/xenomai driver for the CANbus chipset =
82527
> that i think it could have some interest
> it has the next features:

Thanks for moving our private thread here! See, now we know that
Wolfgang is already working on 82527 support for RT-Socket-CAN -
something I wasn't aware of as well.

>=20
>    1. Specific management for the remote frames CANbus feasibility, it
>    couple the real-time data bus flow with a user software feedback to
>    handshake remote frames and update mailbox callback for the auto-rep=
lied
>    messages

Mind to elaborate what you precisely gain here compared to "open-coded"
designs (loop closed over the application)? Can you quantify the
improvements?

>    2. Transparent use to push/suck data from the driver using a common
>    data format
>    3. Capability to push a bunch of CANbus messages in a single system
>    call. The bunch is copied to a kernel domain ring buffer to guarante=
e low
>    latencies at the user side. A specific kernel thread  sucks the ring=
 pushing
>    the user request into the chipset

That was discussed before in the context of Socket-CAN. My feeling is
that it /could/ be useful in case you have to issue longer streams of
CAN frames at high rates, and specifically if your CAN hardware can
handle these streams autonomously. Is the 82527 able to do so?

In any case, this would complicate the existing stack and driver and
would first require careful evaluation of the achievable improvement
(lower latency, lower system load?).

>    4. Driver readout using a native RT message queue where the control
>    and data flow is published

And this way you make your driver unportable, e.g. to move it over the
RTDM layer Wolfgang wrote for the -rt kernel. RTDM drivers are ought to
use RTDM services (or Linux ones), not other skins. If a generally
useful service is lacking, we need to think about adding it - to RTDM.

>    5. Multichipset capabilities, right now a commercial PC104 board wit=
h
>    two devices is used. The on board CPU is a SBC VIA C3 1GHz processor=

>    softwared with the stack xenomai-2.3,1/vanilla-2.6.20-15/Adeos-
>    ipipe-1.7-03
>    6. board monitoring through the /proc file system entry
>    7. Local Data Transfers controlled with RT-alarms

Another violation - but this one is easily avoidable with RTDM timers
that come with API revision 6 (upcoming Xenomai 2.4).

>    8. Virtual support to check applications/driver usage/design, right
>    now only the chipset is virtualised, but plans to have network trans=
actions
>    are on going
>    9. ISR hardware optimizations focused on the network readout to
>    gurantee low latencies

Any numbers?

>    10. Easy porting to other i82527 based on boards
>    11. Full transmission operation handling the 16 message object set
>=20
> We have in plan also
>=20
>    1. Capabilities to filtering/masking the incoming flow at the driver=

>    stage allowing that the same context, using the "xenomai nomenclatur=
e" feed
>    specific threads using some kind of binding/configuration process. T=
his is
>    an open issue cause i don't have a clear approach to follow..
>    2. can-festival coupling

Look, with Socket-CAN, you would now already have CAN-Festival binding. :=
)

But maybe this library scenario can be used to explain why you need to
do things in a special way and what you can gain that way. Looking forwar=
d!

>=20
> I think this is the full picture, i look forward..
>=20
> Best regards..
>=20

Jan


--------------enig77EF35C988C5D0D7F9DE830A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGwBkJniDOoMHTA+kRApOEAJ0TvcU7zTnQ091LIdpumms4fz+EVQCfWZCC
e9Zwez3aMITFAjfkwkKDbYI=
=0mNv
-----END PGP SIGNATURE-----

--------------enig77EF35C988C5D0D7F9DE830A--

