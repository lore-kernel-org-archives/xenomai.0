References: <ff4b8c3a-c8ca-09b5-d3ac-f1d6e127a4e5@sferapro.com>
From: Tom Evans <tom_usenet@optusnet.com.au>
Message-ID: <d4df25fe-a1da-a326-2889-5944b784e800@optusnet.com.au>
Date: Thu, 5 Jul 2018 09:14:16 +1000
MIME-Version: 1.0
In-Reply-To: <ff4b8c3a-c8ca-09b5-d3ac-f1d6e127a4e5@sferapro.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] i.MX6q memory write causes high latency
Reply-To: tom_usenet@optusnet.com.au
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, f.sbalchiero@sferapro.com

On 05/07/18 03:06, Federico Sbalchiero wrote:
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

Could I suggest compiling and running this. It gives good measurements of the 
multiple levels of cache in a computer and measures their latencies:

https://homepages.cwi.nl/~manegold/Calibrator/

It might also be a tool to run after changing the CPU setup to see if it can 
find any differences.


