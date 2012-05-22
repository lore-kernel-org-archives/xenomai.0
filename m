Message-ID: <4FBBECA0.4020502@xenomai.org>
Date: Tue, 22 May 2012 21:44:32 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4FBBBA25.5010308@mind.be>
In-Reply-To: <4FBBBA25.5010308@mind.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] CPU occupation without context switches?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Arnout Vandecappelle <arnout@mind.be>
Cc: xenomai@xenomai.org

On 05/22/2012 06:09 PM, Arnout Vandecappelle wrote:
> Hoi,
>
> After a few minutes of running my application, I see this:
>
> # cat /proc/xenomai/stat
> CPU PID MSW CSW PF STAT %CPU NAME
> 1 828 22 65 0 00300182 9.8 bench_RTnet_scope_thread_loop
> 1 839 2 46627538 0 00300186 53.8 bench_RTnet
> ...
>
> i.e. the bench_RTnet_scope_thread_loop takes 10% CPU but no
> context switches. How is this possible? I've looked at the
> source code and can't find an explanation: when the exectime
> accounting is updated, the csw is incremented as well (in
> __xnpod_schedule()).
>

Unless your thread which seems to repeatedly attempt to pend on some 
sync object has its wait condition satisfied on entry to the syscall 
most of the time, which may cause __xnpod_schedule() to leave it running 
without incrementing the switch count.

> I'm asking because I can't find a reason why this thread should
> occupy 10% of the CPU, so I'm wondering if there's something wrong
> with the accounting instead.
>
> BTW this is on Xenomai 2.5.6, on an SMP x86 with affinity=0x01.
>
> Regards,
> Arnout
>


-- 
Philippe.

