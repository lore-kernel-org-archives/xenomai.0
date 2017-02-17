Date: Fri, 17 Feb 2017 11:45:54 +0100
From: "Mariusz Janiak" <mariuszjaniak@wp.pl>
Message-ID: <58a6d462bfc384.64095769@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai] Odp:  RtNet and Interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Norbert Lange <nolange79@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

Dnia Pi=B1tek, 17 Lutego 2017 11:18 Norbert Lange <nolange79@gmail.com> nap=
isa=B3(a)=20
> Hello,
>=20
> I wonder if the Rtnet Stack is driven at packet level, ie. if after
> every one received packet( or even buffer) an IRQ is received.
> I worked on a Project where a similar Problem with Ethernet
> communication had to be solved, and I just queued up enough receive
> buffers and just picked up anything that arrived at the start of a
> timeslot.
>=20
> On 100Mbit and a 1ms timeslot, I calculated a max. of 150 received
> pakets. Not that realtime communication can get anywhere close to
> that, but you have to deal with worst cases and guarantee that your
> system aint missing the cpu time spend in IRQs for other things - even
> if you just decide to drop all those packets, the IRQ overhead would
> be there.
>=20
> So is Rtnet using "polling" at timeslots, or irqs?

Hi,

As far as I know, RTnet is interrupt driven stack, it means that after rece=
ption of each packet the interrupt is generated and handled by the NIC driv=
er. This is one of the reasons why porting of the RT driver  to new NICs is=
 so problematic, especially now when new drivers support NAPI.

> Kind Regards,
> Norbert
>=20
> PS.
> Complete unrelated, but are there any big companies using Xenomai /
> Rtnet that can be named?

I know that Universities use it a lot in the field of robotics (eg. SOEM + =
OROCOS). There is a port of the RTnet stack for microcontrolers if you are =
interested (RTnet Embedded)

https://bitbucket.org/mariuszjaniak/rtnet-embedded

Best regards,
Mariusz



> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai




