Subject: Re: RT thread seems blocked
References: <bb4f7cd9487f411daa1f5d948761aa65@boschrexroth.nl>
 <b2a97400-db79-c156-2775-d2b67ea7ccf7@siemens.com>
 <e5b86e2706e6490fa1ceb591c9f8a9a1@boschrexroth.nl>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e5d0bf30-640b-2bc8-a257-00c2a5ef8637@siemens.com>
Date: Tue, 24 Mar 2020 12:53:15 +0100
MIME-Version: 1.0
In-Reply-To: <e5b86e2706e6490fa1ceb591c9f8a9a1@boschrexroth.nl>
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
To: "Bradley Valdenebro Peter (DC-AE/ESW52)" <Peter.BradleyValdenebro@boschrexroth.nl>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 24.03.20 12:43, Bradley Valdenebro Peter (DC-AE/ESW52) wrote:
> Hello,
> 
> We run some tests during the weekend and although we have less occurrences we still indeed see them.
> 
> One interesting thing we see besides the 1ms stalling is that sometimes we see over 100us between IRQ and ISR start.
> At this point we do not know how to proceed further. Any help or suggestion is greatly appreciated.
> 

That is usually where you should start to look into tracing. Option A is 
event-level tracing via standard ftrace. Use

trace-cmd record -e "cobalt*" -e sched -e signal

to record such a trace. Ideally instrument the point where the latency 
is off in your application via xnftrace_printf() (will leave a mark in 
that recorded trace). Check via "trace-cmd report" if the schedule 
around that peak is what you would expect.

For digging even deeper, down to function level: 
https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Using_The_I_Pipe_Tracer, 
specifically look into xntrace_user_freeze(), calling that from your 
application when you spot an excessive latency to stop the trace.

If the result is not clear to you, share it to get a community inspection.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

