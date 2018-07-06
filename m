References: <ff4b8c3a-c8ca-09b5-d3ac-f1d6e127a4e5@sferapro.com>
 <b0b1ed38-3770-5236-8e04-30d913096306@xenomai.org>
From: Federico Sbalchiero <f.sbalchiero@sferapro.com>
Message-ID: <7057e9d7-dab4-8c00-d868-01511953b9cd@sferapro.com>
Date: Fri, 6 Jul 2018 11:09:25 +0200
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

in the same configuration (kernel 3.18.20-ipipe + xenomai 3.0.7)
dd if=3D/dev/zero of=3D/dev/null has almost no effect on latency.
I think all data write to a few small buffers, not stressing L2
cache.

latency under load (four dd if=3D/dev/zero of=3D/dev/null instances)

RTT|=A0 00:00:01=A0 (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat=20
best|--lat worst
RTD|=A0=A0=A0=A0=A0 1.093|=A0=A0=A0=A0=A0 2.078|=A0=A0=A0=A0=A0 7.757|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.093|=A0=A0=A0=A0=A0 7.757
RTD|=A0=A0=A0=A0=A0 1.161|=A0=A0=A0=A0=A0 2.090|=A0=A0=A0=A0=A0 5.391|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.093|=A0=A0=A0=A0=A0 7.757
RTD|=A0=A0=A0=A0=A0 1.128|=A0=A0=A0=A0=A0 2.079|=A0=A0=A0=A0=A0 6.537|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.093|=A0=A0=A0=A0=A0 7.757
RTD|=A0=A0=A0=A0=A0 1.155|=A0=A0=A0=A0=A0 2.140|=A0=A0=A0=A0=A0 9.926|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.093|=A0=A0=A0=A0=A0 9.926
RTD|=A0=A0=A0=A0=A0 1.117|=A0=A0=A0=A0=A0 2.086|=A0=A0=A0=A0=A0 9.483|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.093|=A0=A0=A0=A0=A0 9.926
RTD|=A0=A0=A0=A0=A0 1.130|=A0=A0=A0=A0=A0 2.079|=A0=A0=A0=A0=A0 6.362|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.093|=A0=A0=A0=A0=A0 9.926
RTD|=A0=A0=A0=A0=A0 1.165|=A0=A0=A0=A0=A0 2.069|=A0=A0=A0=A0=A0 5.506|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.093|=A0=A0=A0=A0=A0 9.926
RTD|=A0=A0=A0=A0=A0 1.119|=A0=A0=A0=A0=A0 2.066|=A0=A0=A0=A0=A0 5.304|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.093|=A0=A0=A0=A0=A0 9.926
RTD|=A0=A0=A0=A0=A0 1.202|=A0=A0=A0=A0=A0 2.092|=A0=A0=A0=A0 10.538|=A0=A0=
=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.093|=A0=A0=A0=A0 10.538
RTD|=A0=A0=A0=A0=A0 1.139|=A0=A0=A0=A0=A0 2.071|=A0=A0=A0=A0=A0 5.649|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.093|=A0=A0=A0=A0 10.538
RTD|=A0=A0=A0=A0=A0 1.169|=A0=A0=A0=A0=A0 2.080|=A0=A0=A0=A0=A0 5.604|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.093|=A0=A0=A0=A0 10.538
RTD|=A0=A0=A0=A0=A0 1.134|=A0=A0=A0=A0=A0 2.065|=A0=A0=A0=A0=A0 5.586|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.093|=A0=A0=A0=A0 10.538
RTD|=A0=A0=A0=A0=A0 1.027|=A0=A0=A0=A0=A0 2.073|=A0=A0=A0=A0=A0 5.452|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.027|=A0=A0=A0=A0 10.538
RTD|=A0=A0=A0=A0=A0 1.103|=A0=A0=A0=A0=A0 2.188|=A0=A0=A0=A0=A0 9.456|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.027|=A0=A0=A0=A0 10.538
RTD|=A0=A0=A0=A0=A0 1.070|=A0=A0=A0=A0=A0 2.075|=A0=A0=A0=A0=A0 5.694|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.027|=A0=A0=A0=A0 10.538
RTD|=A0=A0=A0=A0=A0 1.140|=A0=A0=A0=A0=A0 2.074|=A0=A0=A0=A0=A0 7.459|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.027|=A0=A0=A0=A0 10.538
RTD|=A0=A0=A0=A0=A0 1.135|=A0=A0=A0=A0=A0 2.225|=A0=A0=A0=A0=A0 9.373|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.027|=A0=A0=A0=A0 10.538
RTD|=A0=A0=A0=A0=A0 1.168|=A0=A0=A0=A0=A0 2.081|=A0=A0=A0=A0=A0 6.486|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.027|=A0=A0=A0=A0 10.538
RTD|=A0=A0=A0=A0=A0 1.062|=A0=A0=A0=A0=A0 2.106|=A0=A0=A0=A0=A0 9.617|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.027|=A0=A0=A0=A0 10.538
RTD|=A0=A0=A0=A0=A0 1.127|=A0=A0=A0=A0=A0 2.161|=A0=A0=A0=A0=A0 9.284|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.027|=A0=A0=A0=A0 10.538
RTD|=A0=A0=A0=A0=A0 1.079|=A0=A0=A0=A0=A0 2.092|=A0=A0=A0=A0=A0 5.480|=A0=
=A0=A0=A0=A0=A0 0| 0|=A0=A0=A0=A0=A0 1.027|=A0=A0=A0=A0 10.538

