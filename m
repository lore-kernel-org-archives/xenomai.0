Message-ID: <558843FB.3040704@siemens.com>
Date: Mon, 22 Jun 2015 19:20:59 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CAOL1OyMgNHaY4tgbUXM0Ytm9YnR3VGaJN-c60_5fuMayjz4aSw@mail.gmail.com>
In-Reply-To: <CAOL1OyMgNHaY4tgbUXM0Ytm9YnR3VGaJN-c60_5fuMayjz4aSw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-Pipe Tracer and linux ftrace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine Durand <wanipof@gmail.com>, xenomai@xenomai.org

On 2015-06-22 18:06, Antoine Durand wrote:
> Hi,
> 
> I would like to check my RT threads scheduling, so I started here :
> http://xenomai.org/2014/06/using-the-i-pipe-tracer/
> 
> I put 100000 in /proc/ipipe/trace/back_trace_points
> I ran my tasks, i write 1 in frozen, and then I read the frozen file.
> 
> I'm not sure what kind of datas can be found in I-Pipe Tracer
> (/proc/ipipe/trace/frozen) and what is in linux ftrace
> (/sys/kernel/debug/tracing). For instance, I "think" I'm interested in the
> __xnsched_run trace points, but there isn't informations about the CPU on
> which the task is running on in I-Pipe tracer output.
> 
> So I checked in linux ftrace.
> 
> But when i activate linux ftrace by writing 1 to
> /sys/kernel/debug/tracing/tracing_on, the RT tasks behaviors became weird
> (the task with the higher priority just toggle an output that I check on an
> oscilloscope, this task is unable to make a clean 10ms periodic square
> signal with tracing_on activated !).

Can you share more details of of your setup (patch version, kernel
config, detailed tracing setup, ...)?

> 
> so I did not find any source to be able to observe my tasks without
> crippling side effect.
> 
> So here are my questions !
> 
> 
> 
> Are linux ftrace datas relevant for xenomai tasks (there is a lot of
> cobalt_core entries so I guess yes) ?

Yes, they are. The Xenomai 3 cobalt core is pretty well instrumented for
event tracing.

> 
> Is there any tool to plot I-Pipe tracer datas from /proc/ipipe/trace/frozen
> ?

No, that data is so far for textual consumption only.

> (I tried to use trace-cmd and kernelshark to plot linux ftrace but if what
> is ploted is true, the side effect with xenomai is awful !)

We need to understand that side effects, they should not be that
massive, rather much less invasive than that of the I-pipe tracer.

> 
> What datas must be checked from I-Pipe Tracer and what must be checked from
> linux ftrace ?

The I-pipe tracer is for detailed analysis, specifically on kernel
function level. If you have a latency spot or a bug on which you can
trigger a trace freeze, then you can look into the details around this
event. The I-pipe tracer is actually quite similar to ftrace's function
tracer, but it has some additional data about the context (RT or Linux).
Maybe we can merge both one day.

Event tracing via ftrace with additional Xenomai tracepoints is for a
broader overview. For analyzing scheduling orders and domain migrations,
identifying application activities based on their syscalls and driver
interactions. It's the first stop when you want to understand your
system activities as a whole - probably what you are after here.

Jan

> 
> 
> 
> That's a lot of questions in one, I'm sorry, it's more that I'am a bit lost.
> 
> Thank you for your help.
> 
> Bob
> 
> x86_64
> linux-3.16.7
> xenomai-3.0-rc4 with I-Pipe tracer Options On
> 

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

