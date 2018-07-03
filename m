References: <5224b3e2-d316-d61b-347f-6a6cac8d6360@siemens.com>
 <2d4ebdd2-a1bd-1cc6-69d3-7d33570cd551@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a5045a0d-6d09-8aaa-55d9-97908df4b050@xenomai.org>
Date: Tue, 3 Jul 2018 19:13:33 +0200
MIME-Version: 1.0
In-Reply-To: <2d4ebdd2-a1bd-1cc6-69d3-7d33570cd551@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Cobalt __SIGPOOL_SIZE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 07/02/2018 03:41 PM, Jan Kiszka wrote:
> On 2018-07-02 15:18, Jan Kiszka wrote:
>> Hi Philippe,
>>
>> The comment for __SIGPOOL_SIZE in kernel/cobalt/posix/signal.c suggests
>> that there can't be many signals in pending state at the same time, but
>> I think it is wrong: Signal are collected per thread, and each of it can
>> pile up multiple of them. Even if we assume that typical threads will
>> not queue those for long and will not wait for many of them, the fact
>> that the system-wide(!) number of threads is a scaling factor and the
>> pool is system-wide as well makes me wonder if __SIGPOOL_SIZE shouldn't
>> become a tunable.
>>
>> BTW, I think we are leaking pending signals on thread destruction.
>> Currently writing a test case, and I already have a fix candidate at hand.
> 
> Confirmed, fix is on the way.
> 
> We also need to remove or replace printk_ratelimit because it is not
> Xenomai-compatible (takes a Linux spinlock internally). But we solved
> that problem already, for RTDM: Should I move rtdm_printk_ratelimit to
> the core?
> 

Ok.


-- 
Philippe.

