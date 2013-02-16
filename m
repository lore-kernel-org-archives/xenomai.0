Message-ID: <511F788E.9030405@xenomai.org>
Date: Sat, 16 Feb 2013 13:16:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <37FC08B05779524B9F78C36BD9D8375E340A6591@vExchange2010.basler.com>
In-Reply-To: <37FC08B05779524B9F78C36BD9D8375E340A6591@vExchange2010.basler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Losing Real Time Response During ARP Flood
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Deiters <SteveDeiters@BASLER.com>
Cc: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 02/15/2013 11:48 PM, Steve Deiters wrote:

> We seem to be losing real time response during an ARP flood.  We
> recently had a misconfigured switch that caused an ARP flood and
> caused a lot of our devices to reboot.  After looking at it a bit we
> found the external watchdog circuit was resetting the boards.  We
> have a design where there is a low priority thread toggling a GPIO to
> service an external watchdog.  We=E2=80=99ve found that this thread is
> getting delayed significantly during the ARP flood.
>=20
> The Ethernet driver and TCP stack is just the plain Linux ones.
> We=E2=80=99ve had PCs running Windows and Linux that were on the networ=
k at
> the same time malfunction as well.  However with Xenomai I would
> think you would be somewhat guarded against any issues with Linux
> handling the networking.
>=20
> We haven=E2=80=99t found any sure fire fix to get around this yet.  We =
can
> change some of the priorities around and it seems to alleviate the
> issue.  If we increase the priority of the watchdog thread it doesn=E2=80=
=99t
> happen.  We link against the POSIX skin so we have real time threads
> from all our pthread_create calls.  Anything relying on network
> communication I would expect to be running mostly in the Linux
> domain.  These mostly just receive data and pass it on to other real
> time threads through shared memory and memory queues.
>=20
> We are trying to get any ideas on what may cause this behavior.  We
> would think a pure Linux Ethernet driver would not be able to hold
> off the real time threads.  We=E2=80=99ve speculated it may be purely d=
ue to
> CPU loading due to the high number of interrupts being processed, but
> we haven=E2=80=99t been able to prove this.
>=20
> We=E2=80=99re going to try the I-Pipe tracer and our JTAG profiler next=
=2E  I
> was wondering if there are any ideas though on where to start
> looking.  Is there any way to rate limit an incoming interrupt
> source?
>=20
> We are running a PowerPC platform with 2.6.33.5 Linux kernel and

> 2.5.4 Xenomai.

I am not sure I understand, if the watchdog is a plain linux task, then
naturally, it will be delayed by the ARP flood, with or without Xenomai.
So, I have to asssume that it is in fact a Xenomai task.

I can think of two ways of creating such a priority inversion:
- If you have root domain priority coupling enabled
(CONFIG_XENO_OPT_PRIOCPL), and a Xenomai thread running in secondary
mode has a higher priority than the watchdog thread;
- If a Xenomai thread running in secondary mode shares a mutex with the
watchdog, but the mutex does not have priority inheritance enabled.


--=20
                                                                Gilles.


