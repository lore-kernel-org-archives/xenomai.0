Message-ID: <5357B0F1.8070909@xenomai.org>
Date: Wed, 23 Apr 2014 14:24:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7dad12a6.21b0a.14574613527.Coremail.ericvic@163.com>
 <535110C3.40500@xenomai.org>
 <59ece04.26b88.1457d86db18.Coremail.ericvic@163.com>
 <53538D60.8040107@xenomai.org> <53539207.2030803@xenomai.org>
 <410c61f.2e6bb.1457ebe7220.Coremail.ericvic@163.com>
 <13c7e4f5.789a.1458ce28c87.Coremail.ericvic@163.com>
In-Reply-To: <13c7e4f5.789a.1458ce28c87.Coremail.ericvic@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] imx6q xenomai ipipe-3.0-imx6q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: eric <ericvic@163.com>
Cc: huang.c.h@lynuc.cn, liu.h.f@lynuc.cn, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/23/2014 06:40 AM, eric wrote:
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 在 2014-04-20 18:46:21，eric <ericvic@163.com> 写道：
> 
>> 在 2014-04-20 17:23:19，"Gilles Chanteperdrix"
>> <gilles.chanteperdrix@xenomai.org> 写道： Le 20/04/2014 11:03, Gilles
>> Chanteperdrix a écrit :
>>> Le 20/04/2014 07:06, eric a écrit :
>>>> So if my program use lots of memory operations  for a long time
>>>> it maybe gives non real-time activities opportunity to thrash
>>>> the cache?
>>> 
>>> It is unrelated, but on a multi-core processor even when one core
>>> is running a real-time task, other cores can thrash the cache at
>>> will, or slow down the real-time task by using a shared ressource
>>> (for instance DDR) and starving the core where the real-time task
>>> runs. By default the L2 cache is shared between all cores, you
>>> can try and reserve parts of the cache for each core (check the
>>> l2x0 registers documentation to see how), I tried this on omap4,
>>> but it results on worse latencies, situation may be different on
>>> imx6 though. Another problem is that since the L1 cache is
>>> per-core, I believe, and we disable L2 write allocate, reading on
>>> one core memory written on another core results in accesses at
>>> the DDR speed, and not at the cache speed.
>>> 
>>> All this to say that Xenomai focuses on trying to schedule your
>>> driver interrupts and application threads in a deterministic
>>> fashion but it is your job to make sure that these interrupts and
>>> threads do not take too long a time to execute, because if they
>>> do, yes, your application will not meet its deadlines, but it is
>>> not Xenomai's fault.
>> 
>> I do not mean to say that you do not have a problem with Xenomai
>> on imx6q, but so far, I have not understood what this problem was.
>> 
>> 
>> -- Gilles.
> 
> 
> 
> 
> 
> Hello Gilles I found the same test on x86 double cores and enble smp
> with rtai will not have the max delay ,it is just 50us latencies
> ,this is my test with rtai , the multi-core processor with  shared
> cache can be thrashed just ﻿appears on imx6 and omap4 or all arm with
> multi-core has the same problems? thank you

Yes, the behaviour of cache is highly dependent on the processor you are
using. Besides, disabling L2 write allocate may be bad for you use case,
you may want to re-enable it to see if it leads to better throughput in
your case.

-- 
                                                                Gilles.

