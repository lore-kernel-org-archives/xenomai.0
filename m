References: <ff4b8c3a-c8ca-09b5-d3ac-f1d6e127a4e5@sferapro.com>
 <b0b1ed38-3770-5236-8e04-30d913096306@xenomai.org>
 <7057e9d7-dab4-8c00-d868-01511953b9cd@sferapro.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <de53c28e-468c-5c42-6985-22976fd2efa0@xenomai.org>
Date: Fri, 6 Jul 2018 11:12:57 +0200
MIME-Version: 1.0
In-Reply-To: <7057e9d7-dab4-8c00-d868-01511953b9cd@sferapro.com>
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

On 07/06/2018 11:09 AM, Federico Sbalchiero wrote:
> Il 05/07/2018 11:14, Philippe Gerum ha scritto:
>> On 07/04/2018 07:06 PM, Federico Sbalchiero wrote:
>>> Hi,
>>> first I want to say thanks to everyone involved in Xenomai for their
>>> job.
>>>
>>> I'm testing Xenomai 3.0.7 and ipipe-arm/4.14 on Freescale/NXP i.MX6q
>>> sabresd board using Yocto. System boots fine and is stable, but latency
>>> under load (xeno-test) is higher than in my reference system (Xenomai
>>> 2.6.5 on Freescale kernel 3.10.17 + ipipe 3.10.18).
>>> This is after disabling power management, frequency scaling, CMA,
>>> graphics, tracing, debug.
>>>
>>> I have found that a simple non-realtime user space process writing a
>>> buffer in memory (memwrite) is able to trigger such high latencies.
>>> Latency worsen a lot running a copy of the process on each core.
>>> There is a correlation between buffer size and cache size suggesting
>>> an L2 cache issue, like the L2 write allocate discussed in the mailing
>>> list, but I can confirm L2 WA is disabled (see log).
>>>
>>> I'm looking for comments or suggestions.
>>>
>> A basic dd if=/dev/zero of=/dev/null loop in the background is enough to
>> raise the latency actually. Could you try the Xenomai 3 + 3.18 combo on
>> your hw and let us know whether you see the same regression?
>>
>> TIA,
>>
> 
> in the same configuration (kernel 3.18.20-ipipe + xenomai 3.0.7)
> dd if=/dev/zero of=/dev/null has almost no effect on latency.
> I think all data write to a few small buffers, not stressing L2
> cache.
> 

You need to set a large block size for dd.


-- 
Philippe.

