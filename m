MIME-Version: 1.0
References: <CAM4LU5L4nnwPrDeM4PeAXzxhzZuoX8MSg3YYLvZycZHvCu-S=Q@mail.gmail.com>
In-Reply-To: <CAM4LU5L4nnwPrDeM4PeAXzxhzZuoX8MSg3YYLvZycZHvCu-S=Q@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 13 Sep 2021 13:11:07 -0400
Message-ID: <CALLqZ8QSY6HeKhQqocS+bBZ9ufF2u_OtySJuNcbF26511wp8YQ@mail.gmail.com>
Subject: Re: Execution time on Xenomai user thread is high
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Rajesh Venkataraman <rajesh_venkataraman@trimble.com>
Cc: xenomai@xenomai.org

On Mon, Sep 13, 2021 at 1:08 PM Rajesh Venkataraman via Xenomai <
xenomai@xenomai.org> wrote:

> Hi,
>    We recently ported our application to Linux(4.19.25)/Xenomai from RTOS.
> We have time critical routines in our application. This routine is run in
> Xenomai user threads with the highest priority. We run each routine on a
> core(Affinity to the CPU is set up for the threads). We have a RTDM driver
> which triggers these routines. We are seeing a maximum/mean latency of
> 100/25 microseconds respectively from the interrupt assertion to running
> the real time routine in Xenomai user thread. Our platform is i.MX6 (ARM
> Cortex-A9 Quad Core) running at 996 MHz. Is that latency reasonable for
> Xemonai? We are also seeing something strange. The execution time of the
> real time routines is twice as long as it took on the RTOS. We are not
> making any calls to the Linux inside these real time routines. The
> execution time of the routine is 500 microseconds in Xenomai thread. But on
> an RTOS running this routine in an interrupt context takes only 250
> microseconds. What is the reason for this higher execution time? Is the
> xenomai thread getting preempted by some timer irq? Is there a way to avoid
> this preemption?
>
> Rajesh


Did you run autotune binary and the latency tests? What were your results?
How long did you run the latency test for? Do you have any debug features
enabled?

Thanks

Greg

>
>
