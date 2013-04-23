Message-ID: <5176950F.3040702@siemens.com>
Date: Tue, 23 Apr 2013 16:05:03 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <51757858.6040604@bollue.de> <51767C09.3070502@siemens.com>
	<51769250.7050504@bollue.de>
In-Reply-To: <51769250.7050504@bollue.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Sporadic freeze using RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kai Bollue <mlist1@bollue.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-04-23 15:53, Kai Bollue wrote:
> Hello Jan,
> thank you for your reply.
> 
> On 23.04.2013 14:18, Jan Kiszka wrote:
>> Does sysrq still work then? sysrq-l would be interesting e.g.
> 
> No. It works before the freeze (so it's set up correctly), but not 
> afterwards.
> 
>>> - Either nothing at all, or
>>>
>>> -
>>> [  481.189349] INFO: rcu_bh detected stalls on CPUs/tasks: { 2}
>>> (detected by 0, t=60042 jiffies)
>>> [  481.291572] INFO: Stall ended before state dump start
>>> [  541.224383] INFO: rcu_preempt detected stalls on CPUs/tasks: { 2}
>>> (detected by 0, t=60002 jiffies)
>>> [  541.331818] INFO: Stall ended before state dump start
>>> (repeated), or
>>>
>>> -
>>> [ 2333.757994] Xenomai: Unbalanced lock/unlock
>> Ah, here's where the problem start.
>>
>> CONFIG_IPIPE_TRACE_PANIC may provide further information. Enable it via
>> the I-pipe tracer. Then, before triggering the lockup, increase the
>> backtrace points to, say, 2000:
>>
>> echo 2000 > /proc/ipipe/trace/back_trace_points
> 
> New console output attached.

Hmm, broken in several ways. First of all, backtraces aren't working
properly in your setup. Please enable CONFIG_FRAME_POINTER. You can
leave the ipipe tracer knob above at its default for the next run, and
no need for the sysrq-l to repeat.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

