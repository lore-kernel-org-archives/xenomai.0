MIME-Version: 1.0
Date: Wed, 16 Jul 2008 08:41:12 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <487CF556.5090309@domain.hid>
References: <487CF556.5090309@domain.hid>
Message-ID: <b1ff76438a96cc50798c2d82c0d50e09@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
Reply-To: matthieu.connaulte_xenomai@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org



On Tue, 15 Jul 2008 21:07:02 +0200, Philippe Gerum <rpm@xenomai.org> wrot=
e:
> Matthieu wrote:
>> Hi,
>>
>> I would like to know if you finally plan to implement
> xntbase_bind/unbind ?
>>
>=20
> Why?

You told in one of your answers :

Normally, solving your issue would require to make the master timebase
paced by your PCI card, which would in turn provide the correct timing fo=
r
the VxWorks timebase (as the timebase doc states, periodic timebases are
cascaded from the master aperiodic one). However, doing so would also
require to adapt the Xenomai HAL code accordingly, and a PCI hw that is
oneshot programmable as well.

If you want to hack the Xenomai timer sub-system in order to only affect
the VxWorks timebase, what you actually need is to control the coupling
between the master timebase (paced by decrementer) and the slave VxWorks
one, so that decrementer ticks may be prevented from kicking the VxWorks
timebase. This way, you would be able to call tickAnnounce() freely to
announce any incoming VxWorks tick (i.e. from your PCI handler).

In short, when paced by the PCI interrupt, you will need to:

- call xntslave_stop(base2slave(wind_tbase))
- call tickAnnounce() from your PCI IRQ handler

When paced normally (simulation, "somebody stole by PCI card" mode), just
leave the burden to the system timer (i.e. ppc decrementer) as usual, by
coupling the VxWorks slave timebase to the master one anew:

- call xntslave_start(base2slave(wind_tbase),  xnarch_get_cpu_time() +
period, period); /* period is given in nanoseconds, depends on the master
timebase */

In any case, you don't need to change the VxWorks tick period.
Starting/stopping the VxWorks timebase should do the trick. NOTE: this is=
 a
hack exposing Xenomai internals -- we should probably encapsulate this in=
to
new xntbase_bind/unbind calls if this does eventually works for you.

...End of quote.

Well, it works for me. So do you intend to implement xntbase_bind/unbind
calls or do I use directly xntslave_start/stop ? Both solutions are ok fo=
r
me ...

=20
>> Matthieu
>>
>>
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
>=20
>=20
> --
> Philippe.


Matthieu



