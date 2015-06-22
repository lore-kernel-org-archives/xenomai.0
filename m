MIME-Version: 1.0
From: Antoine Durand <wanipof@gmail.com>
Date: Mon, 22 Jun 2015 18:06:26 +0200
Message-ID: <CAOL1OyMgNHaY4tgbUXM0Ytm9YnR3VGaJN-c60_5fuMayjz4aSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] I-Pipe Tracer and linux ftrace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I would like to check my RT threads scheduling, so I started here :
http://xenomai.org/2014/06/using-the-i-pipe-tracer/

I put 100000 in /proc/ipipe/trace/back_trace_points
I ran my tasks, i write 1 in frozen, and then I read the frozen file.

I'm not sure what kind of datas can be found in I-Pipe Tracer
(/proc/ipipe/trace/frozen) and what is in linux ftrace
(/sys/kernel/debug/tracing). For instance, I "think" I'm interested in the
__xnsched_run trace points, but there isn't informations about the CPU on
which the task is running on in I-Pipe tracer output.

So I checked in linux ftrace.

But when i activate linux ftrace by writing 1 to
/sys/kernel/debug/tracing/tracing_on, the RT tasks behaviors became weird
(the task with the higher priority just toggle an output that I check on an
oscilloscope, this task is unable to make a clean 10ms periodic square
signal with tracing_on activated !).

so I did not find any source to be able to observe my tasks without
crippling side effect.

So here are my questions !



Are linux ftrace datas relevant for xenomai tasks (there is a lot of
cobalt_core entries so I guess yes) ?

Is there any tool to plot I-Pipe tracer datas from /proc/ipipe/trace/frozen
?
(I tried to use trace-cmd and kernelshark to plot linux ftrace but if what
is ploted is true, the side effect with xenomai is awful !)

What datas must be checked from I-Pipe Tracer and what must be checked from
linux ftrace ?



That's a lot of questions in one, I'm sorry, it's more that I'am a bit lost.

Thank you for your help.

Bob

x86_64
linux-3.16.7
xenomai-3.0-rc4 with I-Pipe tracer Options On
