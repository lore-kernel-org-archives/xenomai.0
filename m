Message-ID: <4736D034.5040606@domain.hid>
Date: Sun, 11 Nov 2007 10:49:40 +0100
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D3285C8@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D3285C8@domain.hid>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
From: Philippe Gerum <rpm@xenomai.org>
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] more geode issues
Reply-To: philippe.gerum@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> I=92m trying to get 2.6.23 to work with rc5. I=92ve also tried trunk. I=
=92m
> noticing the following behavior:
>=20
> =20
>=20
> I=92m using a geode GX1 board. The following relevant settings work with
> 2.6.22-2 and rc3:
>=20
> =20
>=20
> Tickless system, one shot, TSC, geode 2cx200hr timer, and high res timers.
>=20
> =20
>=20
> Everything is great with 2.6.22-2 and this config. The same settings on
> 2.6.23, however, yield an extremely fast blinking cursor in the
> framebuffer when xeno_nucleus is loaded. When xeno_native is loaded, the
> system runs fine except the timer interrupt is messed up for linux and
> the realtime tasks. A sleep 1 may take a couple minutes to return. If I
> switch to another VT and do a cat /lib/* or something, then it runs
> fine. I have a realtime task that acts as a sound driver.
>

Since you still have access to a shell, could you send the output of a
couple of "cat /proc/interrupts /proc/xenomai/irq" with roughly a
one-second delay between them? I'd like to know how many timer
interrupts are reported during this period.

> =20
>=20
> I=92ve talked to Philippe about this problem privately, and there=92s no
> real solution yet. I=92m just posting it on the list now.
>=20

It's a matter of being able to reproduce this behaviour, as usual. Your
.config for 2.6.23 would help too.

> =20
>=20
> Also, I=92m having an issue with select() locking up the system with
> pipes. I saw there was a change made to pipe in trunk and am going to
> try and get that going with 2.6.22-2 now. If anyone knows anything about
> these two issues, please let me know.

The latest change is meant to have the real-time side receive a zero
byte count when the channel is closed by the Linux-side peer while
reading from it. I'll have a look at the select() issue once -rc6 is out.

--
Philippe.


