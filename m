References: <4dde2217-0520-3b4d-7aa3-2393a0e2c88c@sigmatek.at>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b09e3a3a-8f90-5536-d226-c18f70d4cec4@xenomai.org>
Date: Fri, 5 May 2017 15:52:57 +0200
MIME-Version: 1.0
In-Reply-To: <4dde2217-0520-3b4d-7aa3-2393a0e2c88c@sigmatek.at>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] =?utf-8?q?Gatekeeper_taking_1ms_instead_of_13=C2=B5s?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>, Xenomai Mailing List <xenomai@xenomai.org>

On 05/05/2017 01:37 PM, Wolfgang Netbal wrote:
> Hi,
> 
> I use the following configuration imx6dl with Kernel 3.10.53 and Xenomai
> 2.6.4.
> 
> I have a periodic workflow with a timebase of 1ms.
> The timebase creates a Xenomai task (timer_task) with priority 99.
> In the normal case I have an idle time of 666µs before
> the timer_task starts the new period.
> 
> In the failed case the last Linux Task switching to Gatekeeper 24µs
> before the timer_task starts the new period.
> Now I see that the Gatekeeper runs 1004µs and then the normal
> workflow starts.
> 
> First of all is it possible that the timer_task (prio 99) interrupts the
> Gatekeeper (prio 99) ?

The gatekeeper is a regular linux task, whose exclusive duty is to help
in switching a relaxed task back to primary mode. With that in mind,
assuming that such transition should happen in a bounded time makes no
sense. Since this is a regular linux task, "as soon as possible" is the
only option for this.

For this reason, a real-time work loop must never depend on the
execution time of a mode switch, this is broken logic.

There are multiple reasons why a regular linux task - such as the
gatekeeper - would experience long delays due to preemption by another
regular linux activity. For instance, fsl-originated 3.10.x kernels tend
to change the power state of the SDHCI controller quite frequently on
imx6 SoCs, and that PM_RUNTIME code runs over a kernel worker context
which introduces ugly busy waits for synchronizing with the hardware,
while holding a spinlock, preventing preemption. Other linux tasks on
the same CPU would have to wait until this code finishes.

I'm certain that I already sent details about such issue to Sigmatek
back in 2015, you may want to ask around for them. That problem was
demonstrated using a plain non-rt program, on a stock fsl kernel,
without Xenomai/I-pipe support in. > 1ms latency peaks were observed
using ftrace's preemptoff tracer.

-- 
Philippe.

