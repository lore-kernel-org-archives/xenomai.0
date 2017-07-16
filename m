From: Johannes Scheller <johannes.scheller@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Sun, 16 Jul 2017 19:40:33 +0200
References: <mailman.3.1500199202.6544.xenomai@xenomai.org>
In-Reply-To: <mailman.3.1500199202.6544.xenomai@xenomai.org>
Message-Id: <4EF8B5FC-BE35-43C0-B763-8D988A07442B@gmail.com>
Subject: [Xenomai] Sensoray Model 826
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi everyone,

I=E2=80=99m currently looking into building a real-time control system =
and there is quite a lot of analog inputs so I=E2=80=99ve been looking =
at compatible ADC/DAC Card. I=E2=80=99ve come across the Sensoray 626 =
which apparently has already been used and drivers for Xenomai are =
available however I was wondering if anyone has had any experience with =
the successor the model 826 and especially regarding its compatibility =
with Xenomai? Also any other recommendations would be welcome as I=E2=80=99=
m just starting my project.

Thanks a lot in advance

Cheers

Johannes

> On Jul 16, 2017, at 12:00, xenomai-request@xenomai.org wrote:
>=20
> Send Xenomai mailing list submissions to
> 	xenomai@xenomai.org
>=20
> To subscribe or unsubscribe via the World Wide Web, visit
> 	https://xenomai.org/mailman/listinfo/xenomai
> or, via email, send a message with subject or body 'help' to
> 	xenomai-request@xenomai.org
>=20
> You can reach the person managing the list at
> 	xenomai-owner@xenomai.org
>=20
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Xenomai digest..."
>=20
>=20
> Today's Topics:
>=20
>   1. Xv3.0.5 /Lv4.9.35 on wandboard: page domain fault in	rtudp.ko
>      (Andreas Glatz)
>=20
>=20
> ----------------------------------------------------------------------
>=20
> Message: 1
> Date: Sat, 15 Jul 2017 21:37:32 +0100
> From: Andreas Glatz <andi.glatz@gmail.com>
> To: xenomai@xenomai.org
> Subject: [Xenomai] Xv3.0.5 /Lv4.9.35 on wandboard: page domain fault
> 	in	rtudp.ko
> Message-ID:
> 	=
<CAKJ14NcXwHkEFSgrnQWG1KacvOhTp9BT9oQNZn_bdzJTCgqhvw@mail.gmail.com>
> Content-Type: text/plain; charset=3D"UTF-8"
>=20
> Hi
>=20
> I managed to compile and bring-up Xenomai v3.0.5, Ipipe v2, Linux
> v4.9.35 on a Wandboard Quad C1 [1]. I ran all unit-tests sucessfully
> [2] and was able to get RTnet ping to an external PC working. RT ping
> stops working after about 1000 pings... but that's a different story,
> I guess.
>=20
> So when I try to get a simple UDP server [3] running on top of RTnet I
> get "Unhandled fault: page domain fault (0x01b)" oopses, where the
> stacktrace indicates it has to do with rtudp.ko, e.g.
> rt_udp_recvmsg+03c/0x38c. Further googling [4] told me that these
> faults are related to missing copy_from_user() calls in the udp
> driver, which seems to have been enforced in the most recent kernel
> versions (after 4.1.x?). So if I go into the rtudp.ko source code and
> start introducing copy_to_user() statements, the the page domain
> faults go away one after the other...
>=20
> At my company I basically want to propose to upgrade our current
> kernel (3.0.35) with a more recent one. So I'm looking for a hint
> what's the best+latest+supported kernel version for i.MX6 in a
> production grade setup, which can be patched with Xenomai3 (incl.
> RTnet)?
>=20
> Cheers,
>=20
> Andreas
>=20
>=20
>=20
> [1] https://www.wandboard.org
> [2] =
https://xenomai.org/installing-xenomai-3-x/#Testing_the_real-time_system_b=
oth_cores
> [3] http://www.binarytides.com/programming-udp-sockets-c-linux/
> [4] =
https://stackoverflow.com/questions/39515407/how-to-handle-a-page-domain-f=
ault-in-a-self-written-character-device-kernel-modu
>=20
>=20
>=20
> ------------------------------
>=20
> Subject: Digest Footer
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>=20
>=20
> ------------------------------
>=20
> End of Xenomai Digest, Vol 63, Issue 13
> ***************************************


