References: <AM0PR04MB4211273F120B170AAEBBA391800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f0344a17-e6ea-32a0-25d2-00781428ce21@xenomai.org>
Date: Mon, 27 Aug 2018 16:46:16 +0200
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4211273F120B170AAEBBA391800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: "A.s. Dong" <aisheng.dong@nxp.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/27/2018 02:40 PM, A.s. Dong wrote:
> Hi Xenomai Experts,
>=20
> =A0
>=20
> We met the following kernel warning on a MX6Q SDB board with Xenomai
> enabled 4.9 kernel.
>=20
> (CONFIG_DEBUG_MUTEXES is enabled).
>=20
> =A0
>=20
> After some debug, I found it seems to be caused by IPIPE calling
> sleepable function in interrupt context.
>=20
> arch/arm/kernel/ipipe_tsc.c:
>=20
> int cpufreq_transition_handler()
>=20
> {
>=20
> =A0=A0=A0=A0=A0=A0 =85
>=20
> =A0=A0=A0=A0=A0=A0 smp_call_function_single(freqs->cpu, update_timer_freq=
, &freq, 1);
>=20
> }
>=20
> =A0
>=20
> Where update_timer_freq is not allowed to be sleep. But it will finally
> call clk_get_rate
>=20
> In twd_refresh_freq which has a mutex and then trigger the following
> warning.
>=20
> =A0
>=20
> My questions is:
>=20
> Does Xenomai support CONFIG_DEBUG_MUTEXES?
>=20
> Should we disable it to avoid such issue?

No, the underlying bug reported by the might_sleep() assertion would
still be there anyway, right? Fixing it is the only sane way to go. This
could be done by first collecting the new per-cpu timer frequencies in
the cpufreq transition handler, then applying the change via
update_timer_freq, passing the per-cpu array of frequencies just
collected. That would spare us the need to retrieve them by a call to
clk_get_rate() in the leaf handler.

--=20
Philippe.

