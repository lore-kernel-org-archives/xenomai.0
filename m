Subject: Re: i-pipe tracer - how to view traced data
References: <CAPm8-H4hcfGuZBbnX9DO1X6ZeYa5g3JeOd7G+AARKa0LkO1+XQ@mail.gmail.com>
 <59b261b2-dffa-f089-b408-11a41d936aee@siemens.com>
 <CAPm8-H74dtq+ExRHiNqxSy4qW92=UaXQc11+L+Hx+-mBwwwbfQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8c93c13f-4f47-96bc-288d-bd71c5f13fa8@siemens.com>
Date: Fri, 30 Aug 2019 14:14:50 +0200
MIME-Version: 1.0
In-Reply-To: <CAPm8-H74dtq+ExRHiNqxSy4qW92=UaXQc11+L+Hx+-mBwwwbfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 30.08.19 14:01, Laurentiu-Cristian Duca wrote:
> Hello and thank you for the answer. It worked.
> 
> Here is a test of rtt-responder on qemu. I also attached it to this email.
> I use the ipipe-trace api to freeze tracing from C code.
> I see that rtdm_fd_recvmsg and rtdm_fd_sendmsg are called
> (and I wanted to see that).
> 
> I have some questions (I have some ideas but just want to be sure).
> Please answer to those that are important.
> 
> 1. On Hard IRQs column, I see only ':' and space; what do they mean?
> What does mean ('|': locked) from Hard IRQs?

Actually, you see ':' and eventually a '<' in the very first column. That marks 
the path of a trace, down to the 'freeze'. In the second column, IRQs-off are 
marked as '|'.

> 2. On Xenomai column I see only '|' and space; what do they mean?

See above: that was the hard-IRQs off column.

> 3. What does the following column mean:
> Linux ('*': domain stalled, '+': current, '#': current+stalled)

"Stalled" means "interrupts virtually off". "Current" means that this pipeline 
stage is currently active. When a more left stage is active, a more right one 
will not get events or interrupts. We only have two stages here, Linux and 
Xenomai. In the old times, there could be more.

> 4. Type 'func' I think it means a function is called; correct?

Correct.

> What do 'begin' and 'end' mean on the Type column? Are they important?

There is ipipe_trace_begin and ..._end which we added to hard-irq state changes 
(CONFIG_IPIPE_TRACE_IRQSOFF). The tracer automatically records the longer path 
between a begin and an end, providing that as trace via the "max" virtual file. 
The tracepoints are visible in frozen traces as well, though.

> 5. NMI noise 'N' ?

The ipipe tracer does not support recursion. So, if you are in a trace point 
recording call already and an NMI hits, that path will not be recorded in 
details, but the "NMI noise" flag will be set on the interrupted trace point. In 
practice, you will rarely see such a case, specifically as NMIs are very rare 
under normal conditions (not with perf, though).

HTH,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

