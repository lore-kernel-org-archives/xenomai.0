From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1282319702.5255.405.camel@domain.hid>
References: <1282319702.5255.405.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 Aug 2010 18:06:52 +0200
Message-ID: <1282320412.1730.637.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] rt timer jitter
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Krzysztof =?UTF-8?Q?B=C5=82aszkowski?= <kb@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2010-08-20 at 17:55 +0200, Krzysztof B=C5=82aszkowski wrote:
> Do you have any idea about reducing rt timer jitter ?
> I experience annoyingly big jitter in a thread which is supposed to run
> at 400us (i reckon this is nothing extra demanding from atom @1.6G)
>=20
>=20
> the thread's loop looks like:
>=20
> {
> function1()
> ..2()
> ..3()
> ..4()
>=20
> rt_task_wait_period()
> }
>=20
> (^yet another simplified model^)

This is the typical pattern of the latency test. What figures do you get
with:

# /usr/xenomai/bin/latency -t0
...
# /usr/xenomai/bin/latency -t1

--=20
Philippe.



