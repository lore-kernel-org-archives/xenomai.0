Message-ID: <4F4FCC10.4000501@domain.hid>
Date: Thu, 1 Mar 2012 14:20:48 -0500
From: Makarand Pradhan <makarandpradhan@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Need help with ipipe trace
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I am trying to get an ipipe trace and need help to get it working.

I am using Xenomai 2.6 with linux 3.0.0.

The kernel is compiled with following config parameters:

CONFIG_IPIPE_DEBUG=y
CONFIG_IPIPE_DEBUG_CONTEXT=y
CONFIG_IPIPE_DEBUG_INTERNAL=y
CONFIG_IPIPE_TRACE=y
CONFIG_IPIPE_TRACE_ENABLE=y
CONFIG_IPIPE_TRACE_MCOUNT=y
CONFIG_IPIPE_TRACE_IRQSOFF=y
CONFIG_IPIPE_TRACE_SHIFT=14
CONFIG_IPIPE_TRACE_VMALLOC=y
CONFIG_IPIPE_TRACE_PANIC=y
CONFIG_DEBUG_KERNEL=y

The /proc/ipipe direcotry is created.

In my application I am using:

xntrace_max_begin(0); -> To start tracing.
xntrace_max_end(0);   -> To stop tracing.

The function trace that I get in the /proc/ipipe/trace/max file does not 
have the xenomai calls that I am invoking e.g. rt_timer_read.

Can you pl advice if this is the correct method of using the tracer?

Can you pl elaborate on the value being passed in? I see it is 
initializing to:

+                       tp->nmi_saved_v = v;

but could not understand it's use? Is it the no. of nested nmi's that 
will be traced?

Are there any examples of the use of xntrace_max_* functions?

I have also tried using xntrace_user_freeze by looking at latency.c. The 
contents of the frozen file does have a trace to the functions I am 
calling e.g. rt_timer_read, but I do not see any interrupt processing in 
the trace.

Will interrupts be traced by the ipipe tracer? Is there any other way to 
trace the interrupts with a timestamp that are handled by ipipe?

Thanks for your time.

Warm Rgds,
Mak.

-- 
___________________________________________________________________________
NOTICE OF CONFIDENTIALITY:
This e-mail and any attachments may contain confidential and privileged information.  If you are
not the intended recipient, please notify the sender immediately by return e-mail and delete this
e-mail and any copies.  Any dissemination or use of this information by a person other than the
intended recipient is unauthorized and may be illegal.
_____________________________________________________________________

  


