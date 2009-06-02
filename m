Date: Tue, 2 Jun 2009 15:40:27 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <1243933749.27443.557.camel@domain.hid>
Message-ID: <Pine.LNX.4.64.0906021420300.21660@domain.hid>
References: <4A157FD9.40106@domain.hid> <1243933749.27443.557.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] About HARD real time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


On Tue, 2 Jun 2009, Philippe Gerum wrote:
> For that reason, x3 will allow users to base their RT system over -rt or
> the I-pipe, as they see fit, as the requirements mandate. When running
> over -rt, Xenomai will only be in charge of providing real-time APIs;
> when running over the I-pipe, it will also provide the real-time bedrock
> that keeps latencies low, like it already does with earlier versions.

Is the following a feasible development approach at the current time?

1. Start by developing one's realtime drivers and applications using
    RTDM-native for device drivers, and standard POSIX realtime threads
    and timers for one's applications, all running under a PREEMPT_RT
    patched kernel. This presents a comfortable and familiar
    development environment, with lots of tools, and the ability to
    reduce realtime priorities while investigating a bug that
    would otherwise lock up the computer.

2. After doing most of the hard work of debugging, testing and
    commissioning in the above environment, set up a Xenomai patched
    kernel, and recompile one's RTDM drivers and applications under
    Xenomai-duo. Even on systems which performed well under PREEMPT_RT,
    doing this would eliminate the worry that some un-excersized
    latency-generating path in PREEMPT_RT wouldn't cause mysterious
    occasional missed deadlines.

3. If later one wants to add significant features, or debug any
    residual problems, go back to step 1 to do further development
    and/or debugging.

Provided that one didn't mix realtime and non-realtime threads in a
single application, am I correct that the only thing that one would
have to do, to go back and forth between steps 1 to 2, would be to use
different makefiles and appropriately patched kernels?

Is RTDM-native sufficiently mature to use under a PREEMPT_RT kernel?

In the future, when Xenomai 3 comes out, will there be any practical
difference between the environment described above in step-1, and
using the POSIX skin of Xenomai-solo?

Martin

