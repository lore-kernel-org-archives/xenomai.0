Subject: Re: Testing of 4.4/Ipipe + Xenomai 3.0.X on ARM32
References: <20181123122716.tgg3utytwyrkzyid@jholzmayr.localdomain>
 <d1808069-d213-7e9f-010f-abd2c88b0480@siemens.com>
 <20181126143029.6jts36bo267l776s@jholzmayr.localdomain>
 <47252724-7145-7e15-2df8-a5d625b1f95d@siemens.com>
 <20181128124039.ppsitvbbqbtge3im@jholzmayr.localdomain>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4f94437b-acf9-c6ed-9401-f3344ba2468c@xenomai.org>
Date: Thu, 29 Nov 2018 15:29:52 +0100
MIME-Version: 1.0
In-Reply-To: <20181128124039.ppsitvbbqbtge3im@jholzmayr.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On 11/28/18 1:40 PM, Josef Holzmayr via Xenomai wrote:
> Hi Jan,
> 
> On Mon, Nov 26, 2018 at 03:40:38PM +0100, Jan Kiszka wrote:
>> On 26.11.18 15:30, Josef Holzmayr wrote:
>>> On Fri, Nov 23, 2018 at 01:48:27PM +0100, Jan Kiszka wrote:
>>>> On 23.11.18 13:27, Josef Holzmayr via Xenomai wrote:
>>>>> - only one BSP layer so far, namely the Beaglebone. This was chosen for
>>>>>     two major reasons: a) it is supported well enough in 4.4. to not need
>>>>>     additional patches which might introduce new issues, and b) it is
>>>>>     hardware that I have here ready for testing.
>>>>
>>>> I was thinking about which ARMv7 board to add to xenomai-images (enabling
>>>> qemu will be first, though), and that is a good candidate there as well.
>>>>
>>>> Another half-done topic here: CI builds. For that, the BB defconfig could be
>>>> useful too.
>>>
>>> My local tinkering of xenoami-images to create a qemu-armhf build is
>>> still in progress. But yes, we should have a build there too. But I
>>
>> Oh, we might have worked in parallel, sorry: I've qemu-armhf for
>> xenomai-images locally already (just started today). Will post later.
> 
> Saw that, thanks. Given my limited time investment, I'm happy to see it
> happening, and thats it.
> 
>>
>>> don't think the BB defconfig I'm using at the moment is really suited
>>> for xenomai testing. I'll certainly need to tinker with it some more.
>>
>> Yes, configs is a good topic. I was playing with them a lot today, to get
>> some output first, then to find some reasonable debug setup. Considering to
>> have a "release" (measurement) and "debug" profile for configs.
>>
>>>
>>>>
>>>>> - no higher automation like a kas cofiguration so far. Yet this probably
>>>>>     will be the first limitation to be gotten rid of.
> 
> kas files are now in place, equivalent to the ones in xenomai-images
> 
>>>>> Preliminary results to kick off things:
>>>>> - xeno-test completes successfully
>>>>> - latency -t0 under load maxes at ~58µs
>>>>> - latency -t2 under load maxes at ~18µs
>>>>>
>>>>
>>>> Great! According to [1], we could then tag 63637800 also for ARM? Or do you
>>>> want to run more of the tests you have in mind first?
>>>
>>> Given my current testing experience, I would like to not say yes or no,
>>> as I'm not knowledgeable enough to judge. So please decide yourself upon
>>> the given information, with those additional "hints":
>>> - xeno-test "only" runs for 15minutes by default.
>>> - the latency tests I did were not really more long-lived, I don't think
>>>    any one exceeded 30minutes.
>>> - it will be at least two more weeks until I have the long-run results.
>>>    Could also be three. So if you want to tag rather soon, I can't rally
>>>    help more.
>>
>> OK, then I will not hurry.
> 
> Digging deeper, I now have a couple of questions. xeno-test gives me
> 
> net_packet_dgram skipped (no kernel support)
> net_packet_raw skipped (no kernel support)
> net_udp skipped (no kernel support)
> ...
> mutex_trylock not supported
> ...
> sched_quota skipped (no kernel support)
> sched_tp skipped (no kernel support)
> ...
> sigdebug "SIGDEBUG_MIGRATE_PRIOINV" skipped (no kernel support)
> 
> So what do I need to increase test coverage here?

You need to enable a set of Xenomai kernel options, something like:

CONFIG_XENO_OPT_SCHED_CLASSES=y
CONFIG_XENO_OPT_SCHED_WEAK=y
CONFIG_XENO_OPT_SCHED_TP=y
CONFIG_XENO_OPT_SCHED_TP_NRPART=4
CONFIG_XENO_OPT_SCHED_SPORADIC=y
CONFIG_XENO_OPT_SCHED_SPORADIC_MAXREPL=8
CONFIG_XENO_OPT_SCHED_QUOTA=y
CONFIG_XENO_OPT_SCHED_QUOTA_PERIOD=10000
CONFIG_XENO_OPT_SCHED_QUOTA_NR_GROUPS=32
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_MAP=y
CONFIG_XENO_OPT_EXTCLOCK=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_DRIVERS_TIMERBENCH=y
CONFIG_XENO_DRIVERS_SWITCHTEST=y
CONFIG_XENO_DRIVERS_HEAPCHECK=y
CONFIG_XENO_DRIVERS_RTDMTEST=m
CONFIG_XENO_DRIVERS_NET=m
CONFIG_XENO_DRIVERS_NET_RX_FIFO_SIZE=32
CONFIG_XENO_DRIVERS_NET_ETH_P_ALL=y
CONFIG_XENO_DRIVERS_NET_RTIPV4=m
CONFIG_XENO_DRIVERS_NET_RTIPV4_ICMP=y
CONFIG_XENO_DRIVERS_NET_RTIPV4_HOST_ROUTES=32
CONFIG_XENO_DRIVERS_NET_RTIPV4_UDP=m
CONFIG_XENO_DRIVERS_NET_RTPACKET=m
CONFIG_XENO_DRIVERS_NET_RTMAC=m
CONFIG_XENO_DRIVERS_NET_TDMA=m
CONFIG_XENO_DRIVERS_NET_TDMA_MASTER=y
CONFIG_XENO_DRIVERS_NET_RTCFG=m
CONFIG_XENO_DRIVERS_NET_DRV_LOOPBACK=m
CONFIG_XENO_DRIVERS_NET_ADDON_RTCAP=m
CONFIG_XENO_DRIVERS_NET_ADDON_PROXY=m
CONFIG_XENO_DRIVERS_NET_ADDON_PROXY_ARP=y
CONFIG_XENO_DRIVERS_RTIPC=y
CONFIG_XENO_DRIVERS_RTIPC_XDDP=y
CONFIG_XENO_DRIVERS_RTIPC_IDDP=y
CONFIG_XENO_OPT_IDDP_NRPORT=32
CONFIG_XENO_DRIVERS_RTIPC_BUFP=y
CONFIG_XENO_OPT_BUFP_NRPORT=32
CONFIG_XENO_OPT_DEBUG_USER=y
CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED=y
CONFIG_XENO_OPT_WATCHDOG=y

> 
> And, during the run I get 
> 
> [   75.650644] [Xenomai] watchdog triggered on CPU #0 -- runaway thread 'test' signaled
> [   75.658601] sched: RT throttling activated
> 
> Is that good, bad, upgly, or expected?
> 

If that happens with the 'sigdebug' test, then this is good and
expected: this means that Cobalt did pull the break when detecting a
runaway thread, which is what this test verifies.

If you get -EPROTO (out of quota) with the sched_quota smoke test, this
may not be a real issue if the error margin is within 1%. The test
currently complains about a deviation above 0.5%, which might be a bit
too strict on some (SMP) platforms - triggers on 0.7% have been observed
here.

-- 
Philippe.

