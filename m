Message-ID: <4F4FD03D.8070502@domain.hid>
Date: Thu, 01 Mar 2012 20:38:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F4FCC10.4000501@domain.hid>
In-Reply-To: <4F4FCC10.4000501@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Need help with ipipe trace
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Makarand Pradhan <makarandpradhan@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/01/2012 08:20 PM, Makarand Pradhan wrote:
> Hi,
> 
> I am trying to get an ipipe trace and need help to get it working.
> 
> I am using Xenomai 2.6 with linux 3.0.0.
> 
> The kernel is compiled with following config parameters:
> 
> CONFIG_IPIPE_DEBUG=y
> CONFIG_IPIPE_DEBUG_CONTEXT=y
> CONFIG_IPIPE_DEBUG_INTERNAL=y
> CONFIG_IPIPE_TRACE=y
> CONFIG_IPIPE_TRACE_ENABLE=y
> CONFIG_IPIPE_TRACE_MCOUNT=y
> CONFIG_IPIPE_TRACE_IRQSOFF=y
> CONFIG_IPIPE_TRACE_SHIFT=14
> CONFIG_IPIPE_TRACE_VMALLOC=y
> CONFIG_IPIPE_TRACE_PANIC=y
> CONFIG_DEBUG_KERNEL=y
> 
> The /proc/ipipe direcotry is created.
> 
> In my application I am using:
> 
> xntrace_max_begin(0); -> To start tracing.
> xntrace_max_end(0);   -> To stop tracing.
> 
> The function trace that I get in the /proc/ipipe/trace/max file does not 
> have the xenomai calls that I am invoking e.g. rt_timer_read.

The I-pipe tracer is a kernel-space tracer, so, you will only get the
trace for the services which emit a system call. So, when calling
rt_timer_read, you should see __rt_timer_read in the trace.

You can find all the documentation we have about the I-pipe tracer here:
http://www.xenomai.org/index.php/I-pipe:Tracer

-- 
                                                                Gilles.

