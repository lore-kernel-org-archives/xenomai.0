Message-ID: <53539207.2030803@xenomai.org>
Date: Sun, 20 Apr 2014 11:23:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7dad12a6.21b0a.14574613527.Coremail.ericvic@163.com>
 <535110C3.40500@xenomai.org>
 <59ece04.26b88.1457d86db18.Coremail.ericvic@163.com>
 <53538D60.8040107@xenomai.org>
In-Reply-To: <53538D60.8040107@xenomai.org>
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

Le 20/04/2014 11:03, Gilles Chanteperdrix a écrit :
> Le 20/04/2014 07:06, eric a écrit :
>> So if my program use lots of memory operations  for a long time it maybe
>> gives non real-time activities opportunity to thrash the cache?
> 
> It is unrelated, but on a multi-core processor even when one core is
> running a real-time task, other cores can thrash the cache at will, or
> slow down the real-time task by using a shared ressource (for instance
> DDR) and starving the core where the real-time task runs. By default the
> L2 cache is shared between all cores, you can try and reserve parts of
> the cache for each core (check the l2x0 registers documentation to see
> how), I tried this on omap4, but it results on worse latencies,
> situation may be different on imx6 though. Another problem is that since
> the L1 cache is per-core, I believe, and we disable L2 write allocate,
> reading on one core memory written on another core results in accesses
> at the DDR speed, and not at the cache speed.
> 
> All this to say that Xenomai focuses on trying to schedule your driver
> interrupts and application threads in a deterministic fashion but it is
> your job to make sure that these interrupts and threads do not take too
> long a time to execute, because if they do, yes, your application will
> not meet its deadlines, but it is not Xenomai's fault.

I do not mean to say that you do not have a problem with Xenomai on
imx6q, but so far, I have not understood what this problem was.


-- 
Gilles.

