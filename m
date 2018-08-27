From: "A.s. Dong" <aisheng.dong@nxp.com>
Date: Mon, 27 Aug 2018 15:17:32 +0000
Message-ID: <AM0PR04MB4211596E8B94D8BCDD15BF50800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <AM0PR04MB4211273F120B170AAEBBA391800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <f0344a17-e6ea-32a0-25d2-00781428ce21@xenomai.org>
In-Reply-To: <f0344a17-e6ea-32a0-25d2-00781428ce21@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] IPIPE issue causes kernel warning when
 CONFIG_DEBUG_MUTEXES enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: Monday, August 27, 2018 10:46 PM
> To: A.s. Dong <aisheng.dong@nxp.com>; xenomai@xenomai.org
> Subject: Re: IPIPE issue causes kernel warning when CONFIG_DEBUG_MUTEXES
> enabled
>=20
> On 08/27/2018 02:40 PM, A.s. Dong wrote:
> > Hi Xenomai Experts,
> >
> >
> >
> > We met the following kernel warning on a MX6Q SDB board with Xenomai
> > enabled 4.9 kernel.
> >
> > (CONFIG_DEBUG_MUTEXES is enabled).
> >
> >
> >
> > After some debug, I found it seems to be caused by IPIPE calling
> > sleepable function in interrupt context.
> >
> > arch/arm/kernel/ipipe_tsc.c:
> >
> > int cpufreq_transition_handler()
> >
> > {
> >
> > =A0=A0=A0=A0=A0=A0 .
> >
> > =A0=A0=A0=A0=A0=A0 smp_call_function_single(freqs->cpu, update_timer_fr=
eq, &freq,
> > 1);
> >
> > }
> >
> >
> >
> > Where update_timer_freq is not allowed to be sleep. But it will
> > finally call clk_get_rate
> >
> > In twd_refresh_freq which has a mutex and then trigger the following
> > warning.
> >
> >
> >
> > My questions is:
> >
> > Does Xenomai support CONFIG_DEBUG_MUTEXES?
> >
> > Should we disable it to avoid such issue?
>=20
> No, the underlying bug reported by the might_sleep() assertion would stil=
l be
> there anyway, right?

Yes, you're right.

> Fixing it is the only sane way to go. This could be done by
> first collecting the new per-cpu timer frequencies in the cpufreq transit=
ion
> handler, then applying the change via update_timer_freq, passing the per-=
cpu
> array of frequencies just collected. That would spare us the need to retr=
ieve
> them by a call to
> clk_get_rate() in the leaf handler.
>=20

Is there a quick fix?
I'm not quite familiar with Xenomai/IPIPE implementation. It seems there're=
 two
Timers, tsc and ipipe_timer. Not sure can do a proper fix according to your
above suggestions.

Regards
Dong Aisheng

> --
> Philippe.

