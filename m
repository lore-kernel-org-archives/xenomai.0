References: <tencent_7EFF3BC22CBB53AA568408E6@qq.com>
 <0fe39a24-b767-dff2-230d-18fa0b3766dd@xenomai.org>
 <tencent_5E5F68F22D0540CF4309F8EE@qq.com>
 <2ded9de8-95c1-52ea-8e56-55398d454fbd@xenomai.org>
 <tencent_22D865866B28E107473867CD@qq.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <cc52c1d1-235e-e96a-47c7-dad9a1416f66@xenomai.org>
Date: Tue, 13 Sep 2016 15:00:01 +0200
MIME-Version: 1.0
In-Reply-To: <tencent_22D865866B28E107473867CD@qq.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] "Ctrl + C" makes system crashed when exitting
	from"cross-link"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jack Lee <jacklee11@foxmail.com>, xenomai <xenomai@xenomai.org>

On 09/13/2016 11:13 AM, Jack Lee wrote:
> Sometimes, the system just dies absolutely, and I could only press the power key to power off and restart the computer.
> Sometimes, "cross-link" can not exit even using the "kill" command, as described above. No crash assertion /warning reported.
>

The watchdog may help in situation #1 if a runaway thread is at work.

> I am not familiar with xenomai yet, the experiments may be done in the future.
> Also, real-time performance of the advantech MIO-5251 is quite bad. I want to use this

Meaning with Xenomai in? What are the figures if so, any output of the
latency program?

Did you consider this information?
http://xenomai.org/troubleshooting-a-dual-kernel-configuration/#the_latency_test_shows_high_latencies

> system as a robot controller (eg. 6 axises.) Heavy duty of calculations is required. Is x-window running possible?

X-windows is possible if neither of your graphic card nor X driver
causes pathological latencies. I worked on several projects coupling
real-time acquisition and graphics on the same x86 SBC over the years
with no issues; conversely, a few graphic hw support did introduce
roadblocks in other cases, YYMV. You may definitely want to benchmark
the hw before buying.

> Do you have any board to recommend? Performance is preferred. Thanks!
> 

A bad BIOS is often involved in bad real-time performances (including
SMI woes), affecting dual kernel and native preemption configurations
the same way. Likewise, CONFIG_PERF_EVENTS on x86 may kill real-time
performances when NMI-based events are involved.

People of this list running x86 systems in production may hopefully give
you some hints about decent hardware for this usage.

-- 
Philippe.

