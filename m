References: <ff4b8c3a-c8ca-09b5-d3ac-f1d6e127a4e5@sferapro.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b0b1ed38-3770-5236-8e04-30d913096306@xenomai.org>
Date: Thu, 5 Jul 2018 11:14:11 +0200
MIME-Version: 1.0
In-Reply-To: <ff4b8c3a-c8ca-09b5-d3ac-f1d6e127a4e5@sferapro.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] i.MX6q memory write causes high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Federico Sbalchiero <f.sbalchiero@sferapro.com>, xenomai@xenomai.org

On 07/04/2018 07:06 PM, Federico Sbalchiero wrote:
> Hi,
> first I want to say thanks to everyone involved in Xenomai for their job.
> 
> I'm testing Xenomai 3.0.7 and ipipe-arm/4.14 on Freescale/NXP i.MX6q
> sabresd board using Yocto. System boots fine and is stable, but latency
> under load (xeno-test) is higher than in my reference system (Xenomai
> 2.6.5 on Freescale kernel 3.10.17 + ipipe 3.10.18).
> This is after disabling power management, frequency scaling, CMA,
> graphics, tracing, debug.
> 
> I have found that a simple non-realtime user space process writing a
> buffer in memory (memwrite) is able to trigger such high latencies.
> Latency worsen a lot running a copy of the process on each core.
> There is a correlation between buffer size and cache size suggesting
> an L2 cache issue, like the L2 write allocate discussed in the mailing
> list, but I can confirm L2 WA is disabled (see log).
> 
> I'm looking for comments or suggestions.
> 

A basic dd if=/dev/zero of=/dev/null loop in the background is enough to
raise the latency actually. Could you try the Xenomai 3 + 3.18 combo on
your hw and let us know whether you see the same regression?

TIA,

-- 
Philippe.

