Message-Id: <468CF57C-40DE-498B-9C2C-C73AE07CFE4F@comcast.net>
From: Steven Seeger <steven.seeger@domain.hid>
In-Reply-To: <49EF6591.7000802@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Wed, 22 Apr 2009 15:27:13 -0400
References: <49EF6591.7000802@domain.hid>
Subject: Re: [Xenomai-help] An answer to Steven's questions.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

The problem is that latency on Xenomai (even with kernel based  
threads) is terrible on our board compared to RTAI and it's causing us  
issues. I'm starting to think that Xenomai on Geode is not appropriate  
for our application, but we have to salvage the work that's already  
been done. At this point I'm simply looking to minimize the problem.

We are seeing jitters of upwards of 70us when we have a 125us and a  
500us task. That's a huge amount and we can't deal with it. Hopefully  
the problem will be something else. It would be nice to have my other  
questions answered, though.

Steven

On Apr 22, 2009, at 2:44 PM, Gilles Chanteperdrix wrote:

>
> Hi Steven,
>
> what matters in an RTOS, Xenomai being no exception, is the latency.
> Actually, there are three latencies, the interrupt latency, the
> kernel-space scheduling latency, and the user-space scheduling  
> latency.
>
> The true nature of these latencies for Xenomai is complex. It is
> probably a mix between the longest interrupt masking section in both
> Xenomai and Linux code and the indirect effect of cache, spin- 
> locking on
> SMP, TLB, BTB and of other hardware effects. Trying to compute this
> latency mathematically is hopeless.
>
> For this reason, Xenomai comes with a tool called "latency", which
> allows you to measure these latencies given a load applied on the
> system. For this tool to give meaningful results, you should apply a
> realistic load on the system, to be sure that most paths in Xenomai  
> and
> Linux code are taken so that their masking section time, or their  
> effect
> on cache, TLB, BTB, etc... if any, is taken into account.
>
> So, you should not focus on whether this or that part of Xenomai or
> Linux code is preemptible or not, you would miss the big picture. What
> you have to do, is run the latency test given a proper load applied on
> the system. Then you will get a number, and you can rely on this  
> number
> (maybe adding some safety margin) as being the latency of Xenomai on
> your system. Needless to say, Xenomai syscalls and process migrations
> are already done by the printing thread in the latency test, so, there
> is no need to try them in a separate load program.
>
> Regards.
>
> -- 
> 					    Gilles.


