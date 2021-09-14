MIME-Version: 1.0
References: <CAM4LU5L4nnwPrDeM4PeAXzxhzZuoX8MSg3YYLvZycZHvCu-S=Q@mail.gmail.com>
 <CALLqZ8QSY6HeKhQqocS+bBZ9ufF2u_OtySJuNcbF26511wp8YQ@mail.gmail.com>
 <CAM4LU5LPFJyo78KWZxrgJL4FShUw0AH1kM2kkNFFiow8QqGfTQ@mail.gmail.com>
 <CAM4LU5KSZuDzSO0c1S60_29A77Av94yD-mG6t9D+bM-G7tE+8g@mail.gmail.com>
 <CALLqZ8RM04B-upsfTPhDd++e_zBQOjjr=Sjj1FzXG4+0XYLevA@mail.gmail.com>
In-Reply-To: <CALLqZ8RM04B-upsfTPhDd++e_zBQOjjr=Sjj1FzXG4+0XYLevA@mail.gmail.com>
From: Rajesh Venkataraman <rajesh_venkataraman@trimble.com>
Date: Mon, 13 Sep 2021 22:03:35 -0700
Message-ID: <CAM4LU5Lzgm78vBZiwgByeogKASFL0gZpK8hUGxQxC8ZP5hqfhw@mail.gmail.com>
Subject: Re: Execution time on Xenomai user thread is high
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: xenomai@xenomai.org

Hi Greg,
   I added the pthread_setmode_np(0, PTHREAD_WARNSW, NULL); calls to the
real time threads to catch mode switches. I have not found any mode
switches yet. I will enable the debug options to find the latency. But the
bigger problem is the higher execution time. It is taking longer to execute
the same routine on Xenomai user thread (Highest priority) than on a
traditional RTOS ISR.  Is this expected behaviour? Do xenomai threads get
preempted by other system interrupts like timer interrupts? Is there a way
to debug this or prevent this issue?

Rajesh


On Mon, Sep 13, 2021 at 8:43 PM Greg Gallagher <greg@embeddedgreg.com>
wrote:

>
>
> On Mon, Sep 13, 2021 at 1:49 PM Rajesh Venkataraman via Xenomai <
> xenomai@xenomai.org> wrote:
>
>> ---------- Forwarded message ---------
>> From: Rajesh Venkataraman <rajesh_venkataraman@trimble.com>
>> Date: Mon, Sep 13, 2021 at 10:41 AM
>> Subject: Re: Execution time on Xenomai user thread is high
>> To: Greg Gallagher <greg@embeddedgreg.com>
>>
>>
>> Hi Greg,
>> Below are the results of the autotune and latency tests. I do not have a=
ny
>> debug features enabled.
>>
>> Rajesh
>>
>>
>> =3D=3D auto-tuning started, period=3D10[Xenomai] autotune(irqhand) start=
ed
>>
>>
>> 00000 ns (may take a while)
>>
>>
>> irq gravity... 1333 ns[Xenomai] autotune(kthread) started
>>
>>
>>
>>
>>
>> kernel gravity... 4666 ns
>>
>>
>> [Xenomai] autotune(uthread) started
>>
>>
>> user gravity... 6666 ns[Xenomai] autotune finished [1333i/4666k/6666u]
>>
>>
>>
>>
>>
>> =3D=3D auto-tuning completed after 43s
>>
>> =3D=3D Sampling period: 1000 us
>>
>>
>> =3D=3D Test mode: periodic user-mode task
>>
>>
>> =3D=3D All results in microseconds
>>
>>
>> warming up...
>>
>>
>> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
>>
>>
>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--la=
t
>> worst
>>
>> RTD|      2.333|      2.938|      7.000|       0|     0|      2.333|
>>  7.000
>>
>> RTD|      2.333|      3.048|      6.666|       0|     0|      2.333|
>>  7.000
>>
>> RTD|      2.333|      3.022|      7.000|       0|     0|      2.333|
>>  7.000
>>
>> RTD|      2.333|      3.007|      7.333|       0|     0|      2.333|
>>  7.333
>>
>> RTD|      2.332|      3.037|      8.999|       0|     0|      2.332|
>>  8.999
>>
>> RTD|      2.332|      2.967|      6.666|       0|     0|      2.332|
>>  8.999
>>
>> RTD|      2.332|      2.943|      6.665|       0|     0|      2.332|
>>  8.999
>>
>> RTD|      2.332|      2.964|      6.665|       0|     0|      2.332|
>>  8.999
>>
>> RTD|      2.331|      2.930|      6.665|       0|     0|      2.331|
>>  8.999
>>
>> RTD|      2.331|      2.981|     11.665|       0|     0|      2.331|
>> 11.665
>>
>> RTD|      2.331|      3.039|      6.998|       0|     0|      2.331|
>> 11.665
>>
>> RTD|      2.331|      3.012|      7.664|       0|     0|      2.331|
>> 11.665
>>
>> RTD|      2.330|      2.941|      6.997|       0|     0|      2.330|
>> 11.665
>>
>> RTD|      2.330|      2.974|      6.664|       0|     0|      2.330|
>> 11.665
>>
>> RTD|      2.330|      2.952|      6.330|       0|     0|      2.330|
>> 11.665
>>
>> RTD|      2.330|      2.961|      6.330|       0|     0|      2.330|
>> 11.665
>>
>> RTD|      2.330|      2.925|      5.996|       0|     0|      2.330|
>> 11.665
>>
>> RTD|      2.329|      3.022|      7.996|       0|     0|      2.329|
>> 11.665
>>
>> RTD|      2.329|      2.959|      6.996|       0|     0|      2.329|
>> 11.665
>>
>> RTD|      2.329|      3.038|      7.662|       0|     0|      2.329|
>> 11.665
>>
>> RTD|      2.329|      3.031|      8.662|       0|     0|      2.329|
>> 11.665
>>
>> RTT|  00:00:22  (periodic user-mode task, 1000 us period, priority 99)
>>
>>
>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--la=
t
>> worst
>>
>> RTD|      2.328|      2.982|      7.662|       0|     0|      2.328|
>> 11.665
>>
>> RTD|      2.328|      3.030|      6.662|       0|     0|      2.328|
>> 11.665
>>
>> RTD|      2.328|      2.928|      6.328|       0|     0|      2.328|
>> 11.665
>>
>> RTD|      2.328|      2.911|      5.994|       0|     0|      2.328|
>> 11.665
>>
>> RTD|      2.327|      2.975|      7.661|       0|     0|      2.327|
>> 11.665
>>
>> RTD|      2.327|      3.002|      7.327|       0|     0|      2.327|
>> 11.665
>>
>> RTD|      2.327|      2.977|      7.327|       0|     0|      2.327|
>> 11.665
>>
>> RTD|      2.327|      2.939|      6.993|       0|     0|      2.327|
>> 11.665
>>
>> RTD|      2.326|      2.951|      6.660|       0|     0|      2.326|
>> 11.665
>>
>> RTD|      2.326|      2.938|      7.326|       0|     0|      2.326|
>> 11.665
>>
>> RTD|      1.993|      2.890|      6.659|       0|     0|      1.993|
>> 11.665
>>
>> RTD|      0.659|      2.927|      7.659|       0|     0|      0.659|
>> 11.665
>>
>> RTD|      2.325|      2.947|      6.992|       0|     0|      0.659|
>> 11.665
>>
>> RTD|      2.325|      3.008|      7.992|       0|     0|      0.659|
>> 11.665
>>
>> RTD|      2.325|      2.968|      8.325|       0|     0|      0.659|
>> 11.665
>>
>> RTD|      2.325|      2.971|      6.325|       0|     0|      0.659|
>> 11.665
>>
>> RTD|      2.324|      2.926|      5.991|       0|     0|      0.659|
>> 11.665
>>
>> RTD|      2.324|      2.934|      6.991|       0|     0|      0.659|
>> 11.665
>>
>> RTD|      2.324|      2.947|      6.324|       0|     0|      0.659|
>> 11.665
>>
>> RTD|      2.324|      2.897|      6.657|       0|     0|      0.659|
>> 11.665
>>
>> RTD|      2.324|      2.924|      7.657|       0|     0|      0.659|
>> 11.665
>>
>> RTT|  00:00:43  (periodic user-mode task, 1000 us period, priority 99)
>>
>>
>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--la=
t
>> worst
>>
>> RTD|      2.323|      2.937|      6.990|       0|     0|      0.659|
>> 11.665
>>
>>
>> ^C---|-----------|-----------|-----------|--------|------|--------------=
-----------
>>
>>
>>
>>
>> On Mon, Sep 13, 2021 at 10:11 AM Greg Gallagher <greg@embeddedgreg.com>
>> wrote:
>>
>> >
>> >
>> > On Mon, Sep 13, 2021 at 1:08 PM Rajesh Venkataraman via Xenomai <
>> > xenomai@xenomai.org> wrote:
>> >
>> >> Hi,
>> >>    We recently ported our application to Linux(4.19.25)/Xenomai from
>> RTOS.
>> >> We have time critical routines in our application. This routine is ru=
n
>> in
>> >> Xenomai user threads with the highest priority. We run each routine o=
n
>> a
>> >> core(Affinity to the CPU is set up for the threads). We have a RTDM
>> driver
>> >> which triggers these routines. We are seeing a maximum/mean latency o=
f
>> >> 100/25 microseconds respectively from the interrupt assertion to
>> running
>> >> the real time routine in Xenomai user thread. Our platform is i.MX6
>> (ARM
>> >> Cortex-A9 Quad Core) running at 996 MHz. Is that latency reasonable f=
or
>> >> Xemonai? We are also seeing something strange. The execution time of
>> the
>> >> real time routines is twice as long as it took on the RTOS. We are no=
t
>> >> making any calls to the Linux inside these real time routines. The
>> >> execution time of the routine is 500 microseconds in Xenomai thread.
>> But
>> >> on
>> >> an RTOS running this routine in an interrupt context takes only 250
>> >> microseconds. What is the reason for this higher execution time? Is t=
he
>> >> xenomai thread getting preempted by some timer irq? Is there a way to
>> >> avoid
>> >> this preemption?
>> >>
>> >> Rajesh
>> >
>> >
>> > Did you run autotune binary and the latency tests? What were your
>> results?
>> > How long did you run the latency test for? Do you have any debug
>> features
>> > enabled?
>> >
>> > Thanks
>> >
>> > Greg
>> >
>> >>
>> >>
>
>
> Usually what I=E2=80=99ll do to get latency numbers is to run the latency=
 test
> while the system is loaded (simulate a busy system) and let it run for a
> long period of time. If you don=E2=80=99t see the latency that you see in=
 your
> program (IMHO) you should look for any mode switches in your program. Bot=
h
> ipipe and xenomai have debug options to help find latency.
>   I=E2=80=99m not too familiar with the i.mx6 so I can=E2=80=99t say weat=
her the latency
> you are seeing could possibly be caused by hardware.
>
> Thanks
>
> -Greg
>
>>
>>
