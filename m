Message-ID: <4F562B53.7070400@domain.hid>
Date: Tue, 06 Mar 2012 16:20:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid> <4F55C306.8020307@domain.hid>
	<4F55D765.7040705@domain.hid> <4F55E390.8090706@domain.hid>
	<4F55FE81.6000904@domain.hid> <4F560A6C.2080306@domain.hid>
	<4F560B76.5080606@domain.hid> <4F5629D2.50304@domain.hid>
In-Reply-To: <4F5629D2.50304@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] preemptive doesn't work
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>, xenomai@xenomai.org

On 03/06/2012 04:14 PM, Roberto Bielli wrote:
>  Hi Gilles,
> 
> i changed the min value of the '__ipipe_mach_set_dec' but the situation
> is the same.
> I see with the scope that the task with less priority is not interrupted.

In the trace you sent, we clearly saw that it was interrupted by a timer
interrupt.

> 
> It's difficult to see with the ipipe trace the problem so i put the
> xenomai trace in the application with
> |xntrace_user_start|/|xntrace_user_stop|.
> Is the log of xenomai in the same place (/proc/ipipe/trace/max ) of ipipe ?

See the latency test for an example of usage of the I-pipe tracer in
user-space. When using latency -f the trace is available in
/proc/ipipe/trace/frozen.

What about T_WARNSW (it is the third time I ask).

Also, it would be nice if you could try a more recent version of Xenomai
and of the I-pipe patch, say 2.6.0 with the I-pipe patch for 2.6.38.

-- 
					    Gilles.

