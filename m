References: <ff4b8c3a-c8ca-09b5-d3ac-f1d6e127a4e5@sferapro.com>
 <b0b1ed38-3770-5236-8e04-30d913096306@xenomai.org>
From: Federico Sbalchiero <f.sbalchiero@sferapro.com>
Message-ID: <2ec21a09-acad-c747-a865-80ac952f1220@sferapro.com>
Date: Fri, 6 Jul 2018 10:41:11 +0200
MIME-Version: 1.0
In-Reply-To: <b0b1ed38-3770-5236-8e04-30d913096306@xenomai.org>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: it
Subject: Re: [Xenomai] i.MX6q memory write causes high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Il 05/07/2018 11:14, Philippe Gerum ha scritto:
> On 07/04/2018 07:06 PM, Federico Sbalchiero wrote:
>> Hi,
>> first I want to say thanks to everyone involved in Xenomai for their job.
>>
>> I'm testing Xenomai 3.0.7 and ipipe-arm/4.14 on Freescale/NXP i.MX6q
>> sabresd board using Yocto. System boots fine and is stable, but latency
>> under load (xeno-test) is higher than in my reference system (Xenomai
>> 2.6.5 on Freescale kernel 3.10.17 + ipipe 3.10.18).
>> This is after disabling power management, frequency scaling, CMA,
>> graphics, tracing, debug.
>>
>> I have found that a simple non-realtime user space process writing a
>> buffer in memory (memwrite) is able to trigger such high latencies.
>> Latency worsen a lot running a copy of the process on each core.
>> There is a correlation between buffer size and cache size suggesting
>> an L2 cache issue, like the L2 write allocate discussed in the mailing
>> list, but I can confirm L2 WA is disabled (see log).
>>
>> I'm looking for comments or suggestions.
>>
> A basic dd if=3D/dev/zero of=3D/dev/null loop in the background is enough=
 to
> raise the latency actually. Could you try the Xenomai 3 + 3.18 combo on
> your hw and let us know whether you see the same regression?
>
> TIA,
>

kernel 3.18.20-ipipe + xenomai 3.0.7

latency under load (four memwrite instances)
RTT|=A0 00:00:01=A0 (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat=20
best|--lat worst
RTD|=A0=A0=A0=A0 24.985|=A0=A0=A0=A0 41.374|=A0=A0=A0=A0 76.351|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 24.985|=A0=A0=A0=A0 76.351
RTD|=A0=A0=A0=A0 26.889|=A0=A0=A0=A0 41.203|=A0=A0=A0=A0 68.070|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 24.985|=A0=A0=A0=A0 76.351
RTD|=A0=A0=A0=A0 22.828|=A0=A0=A0=A0 41.376|=A0=A0=A0=A0 67.681|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 22.828|=A0=A0=A0=A0 76.351
RTD|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 41.043|=A0=A0=A0=A0 74.143|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 76.351
RTD|=A0=A0=A0=A0 27.027|=A0=A0=A0=A0 41.441|=A0=A0=A0=A0 68.037|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 76.351
RTD|=A0=A0=A0=A0 24.413|=A0=A0=A0=A0 41.585|=A0=A0=A0=A0 81.062|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 81.062
RTD|=A0=A0=A0=A0 27.234|=A0=A0=A0=A0 41.168|=A0=A0=A0=A0 76.516|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 81.062
RTD|=A0=A0=A0=A0 23.779|=A0=A0=A0=A0 41.141|=A0=A0=A0=A0 70.466|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 81.062
RTD|=A0=A0=A0=A0 24.824|=A0=A0=A0=A0 41.273|=A0=A0=A0=A0 75.322|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 81.062
RTD|=A0=A0=A0=A0 25.627|=A0=A0=A0=A0 41.195|=A0=A0=A0=A0 71.157|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 81.062
RTD|=A0=A0=A0=A0 28.874|=A0=A0=A0=A0 41.089|=A0=A0=A0=A0 66.579|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 81.062
RTD|=A0=A0=A0=A0 26.672|=A0=A0=A0=A0 41.638|=A0=A0=A0=A0 75.995|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 81.062
RTD|=A0=A0=A0=A0 25.139|=A0=A0=A0=A0 41.040|=A0=A0=A0=A0 69.543|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 81.062
RTD|=A0=A0=A0=A0 26.215|=A0=A0=A0=A0 41.099|=A0=A0=A0=A0 66.336|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 81.062
RTD|=A0=A0=A0=A0 24.192|=A0=A0=A0=A0 41.117|=A0=A0=A0=A0 76.828|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 81.062
RTD|=A0=A0=A0=A0 27.310|=A0=A0=A0=A0 41.942|=A0=A0=A0=A0 79.888|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 81.062
RTD|=A0=A0=A0=A0 24.348|=A0=A0=A0=A0 40.955|=A0=A0=A0=A0 66.484|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 81.062
RTD|=A0=A0=A0=A0 26.679|=A0=A0=A0=A0 41.260|=A0=A0=A0=A0 80.242|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 81.062
RTD|=A0=A0=A0=A0 26.820|=A0=A0=A0=A0 41.251|=A0=A0=A0=A0 74.986|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 81.062
RTD|=A0=A0=A0=A0 27.635|=A0=A0=A0=A0 41.301|=A0=A0=A0=A0 73.961|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 81.062
RTD|=A0=A0=A0=A0 26.877|=A0=A0=A0=A0 41.305|=A0=A0=A0=A0 72.789|=A0=A0=A0=
=A0=A0=A0 0| 0|=A0=A0=A0=A0 20.969|=A0=A0=A0=A0 81.062


