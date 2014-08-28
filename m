Message-ID: <53FF8DF9.9080405@xenomai.org>
Date: Thu, 28 Aug 2014 22:15:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <B77BA3CE-F753-4865-A2AD-37EE4888E465@gatech.edu>
 <53FF8AC7.5090301@xenomai.org>
In-Reply-To: <53FF8AC7.5090301@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Low-latency desktop setting
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/28/2014 10:02 PM, Gilles Chanteperdrix wrote:
> On 08/28/2014 09:49 PM, Yogi A. Patel wrote:
>> In configuring the kernel (after patching with xenomai), there is an
>> option to change the preemption model to "low-latency desktop".
>>
>> Is this a setting that should be set? Or should it be left to the
>> default preemption mode??
>>
>> How does this setting affect the real-time performance of a xenomai
>> enabled kernel?
> 
> This option is about Linux preemption, it affects how often Linux is
> willing to preempt itself, in the throughput/latency fight, it gives
> advantage to (Linux) latency at the expense of througput. It does not
> affect Xenomai directly, but rather indirectly: it creates a code with a
> lower "density", by littering the Linux kernel execution with checks for
> the need of rescheduling, so that Linux has a larger pollution effect on
> caches. In my experience, you get slightly lower Linux latencies by
> turning CONFIG_PREEMPT off (selecting CONFIG_PREEMPT_NONE).
> 

I meant you get lower XENOMAI latencies by turning it off. Of course you
get higher Linux latencies.


-- 
                                                                Gilles.

