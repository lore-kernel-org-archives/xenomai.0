MIME-Version: 1.0
In-Reply-To: <1dd59300-7763-e9f3-cda8-2f2548e9e96c@xenomai.org>
References: <CAOuPNLiL2jQ3wcYsxMAO2kqOvCvyPVPnZNakiLX_nhQVtVJk7A@mail.gmail.com>
 <CALLqZ8R77Pv+TRCrXiGkfzrcOdMMY+WfWzpO-qVE6-oFAgpU0g@mail.gmail.com>
 <CAOuPNLhcNcOdveFRLJUvFTLDDfQY4YOYUPRjWiPjK1o0zdTjJg@mail.gmail.com>
 <CAOuPNLgJOsYcT51SHS56mG5KDsS9pOBYPdWY9aWDvv7rfvBTUg@mail.gmail.com>
 <854aec2d-861e-f17e-e57c-d86e9f5e7a90@xenomai.org>
 <CAOuPNLgMJ_cvEsXJd+oF+g0ftMudT4Ztkb_yy=AXBMRDWuGqBg@mail.gmail.com>
 <14040d9b-3b4b-9677-05d0-24773e309310@xenomai.org>
 <CAOuPNLjP+6CPOf-4uYHZCLEfAzGjQOXy32r+5TBwMrVFFH9fOw@mail.gmail.com>
 <20bffd5c-9f11-3bb2-236a-11764a129059@xenomai.org>
 <CAOuPNLi28DcSYvuk__P6_o=xZ=O=Wv-k8iXqiUez87PKCKeXfw@mail.gmail.com>
 <49cd0e96-fde0-4d7a-17bc-5ae18d10baac@xenomai.org>
 <CAOuPNLgpwc4+nk=5V_3E0k6V_oYVs1q_gfLpwiN_8jfbsYNq9g@mail.gmail.com>
 <1dd59300-7763-e9f3-cda8-2f2548e9e96c@xenomai.org>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 27 Mar 2018 17:39:58 +0530
Message-ID: <CAOuPNLiwFdBO1A34A8CU6iVTPQ0VRBq6g7NR=Z3hDvke0+nbdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Simple application for invoking rtdm driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Thank you so much for all your explanation.
But, before I dig deeper, I have some simple questions which is troubling me.

1) In Idle case, we see latency improvement (~2-3 micro-seconds on
average) using Xenomai native task application, compared to normal
posix thread application (with 100 us sleep).
    Then why not it is seen with RTDM driver and its application ?

2) In the idle case itself, we have seen read/write latency
improvement using RTNET (loopback) and simple UDP client/server
application using Xenomai posix skin
    Then why not same is visible with RTDM driver?

3) How to choose, when to develop a Xenomai native application, and
when to simply convert using posix skin ?


Anyways, give me sometime, I will share my samples on github for your review.
Here is the snapshot of my rtdm application.
----------------------------------------------------------------
int main(int argc, char *argv[])
{
        int ret, fd, len;
        char msg[] = "Hello!";
        char *buff = NULL;
        RTIME prev, now;
        float diff;

        fd = rt_dev_open(/dev/rtdm/rtsample, O_RDWR);

        len = strlen(msg);
        prev = rt_timer_read();
        ret = rt_dev_write(fd, msg, len);
        now = rt_timer_read();
        diff = (now - prev) / 1000.0;
        rt_printf("write latency: %5.3f us\n", diff);

        buff = malloc(4096);
        memset(buff, 0, len);
        prev = rt_timer_read();
        ret = rt_dev_read(fd, buff, len);
        now = rt_timer_read();
        diff = (now - prev) / 1000.0;
        rt_printf("Message from driver:\n");
        rt_printf("%s\n", buff);
        rt_printf("read latency: %5.3f us\n", diff);

        if (buff)
                free(buff);
err:
        rt_dev_close(fd);

        return 0;
}
--------------------------------------------------------------------------
I used exactly the same application for normal driver, using normal
open/read/write calls.
Do you see any problem in the way, we measure latency here?

Yes, it is true that I am just measuring read/write system call timing
across both kernel.
We expect that Xenomai (or any RTOS) should give better latency both
in idle case as well as over-loaded system.
Of-course in over-loaded system, we can trust that real time
application (with strict timing requirement) will never cross the
deadline.


Thanks,
Pintu

On Mon, Mar 26, 2018 at 8:39 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 03/26/2018 03:12 PM, Pintu Kumar wrote:
>> Dear Philippe,
>>
>> Thank you so much for your reply.
>> Please find my comments below.
>>
>>
>> On Sun, Mar 25, 2018 at 5:39 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>>> On 03/23/2018 01:40 PM, Pintu Kumar wrote:
>>>> Dear Philippe,
>>>>
>>>> Thank you so much for your detailed explanation.
>>>>
>>>> First to cross-check, I also tried on ARM BeagleBone (White) with
>>>> 256MB RAM, Single core
>>>> These are the values I got.
>>>
>>> After how many samples?
>>
>> Just after 3 samples only for each cases. Just an initial run to
>> understand the difference.
>>
>>>
>>>> ===========================
>>>> NORMAL KERNEL Driver Build (with xenomai present)
>>>> ---------------------------------------------------------------------------
>>>> write latency: 8235.083 us
>>>
>>> Are you sure that any driver (plain Linux or Xenomai) would take up 8.2
>>> MILLIseconds for performing a single write with your test module? Either
>>> you meant 8235 nanoseconds, or something is really wrong with your
>>> system.
>>
>> Yes these values are calculated in micro-seconds.
>> I have used the same to measure latency for native application, and it
>> reports fine.
>> These large values are seen only on Beagle bone (white) with just 256MB RAM,
>> and model name: ARMv7 Processor rev 2 (v7l)
>> I think this is very old board and its very slow in normal usage itself.
>> So, these figures could be high.
>>
>
> No, these figures do not make sense in dual kernel context even on this
> board and clearly denote a problem with the application, given the
> figures you got on the same machine with a proper latency test as
> illustrated below.
>
>> This is the latency test output from same machine:
>> # /usr/xenomai/bin/latency
>> == Sampling period: 1000 us
>> == Test mode: periodic user-mode task
>> == All results in microseconds
>> warming up...
>> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
>> RTD|     25.249|     29.711|     63.749|       0|     0|     25.249|     63.749
>> RTD|     25.207|     29.589|     60.749|       0|     0|     25.207|     63.749
>> RTD|     25.207|     29.701|     61.041|       0|     0|     25.207|     63.749
>> RTD|     22.874|     29.263|     54.749|       0|     0|     22.874|     63.749
>> RTD|     25.248|     29.542|     78.373|       0|     0|     22.874|     78.373
>> RTD|     15.081|     29.050|     55.082|       0|     0|     15.081|     78.373
>> RTD|     22.873|     28.940|     57.415|       0|     0|     15.081|     78.373
>> RTD|     25.331|     28.972|     55.498|       0|     0|     15.081|     78.373
>> RTD|     24.164|     28.071|     56.498|       0|     0|     15.081|     78.373
>> ^C---|-----------|-----------|-----------|--------|------|-------------------------
>> RTS|     15.081|     29.204|     78.373|       0|     0|    00:00:10/00:00:10
>>
>>
>>
>
> [...]
>
>>
>> I even tried running the whole operation inside a RT task with priority 99.
>
> Regular Linux threads cannot compete with Cobalt threads by priority in
> rt mode, those threads are managed by separate schedulers, and Cobalt's
> scheduler always runs first. There is no point in raising the priority
> of a Cobalt thread if no other Cobalt thread actually competes with it.
>
>> Then in this case, latency values are reduced by almost half, but
>> still 2-3 us higher than normal driver.
>>
>
> Again, please read my previous answers, I'm going to rehash them:
> your test does NOT measure latency as in "response time", simply because
> it does not wait for any event. To respond to an event, you have to wait
> for it first. Your test measures the execution time of a dummy write()
> system call. The test I provided does the measure execution time for
> write() AND the latency of read(), just like the "latency" test bundled
> with Xenomai.
>
> The values you got so far with any test are not trustworthy because:
>
> - you don't add any stress load in parallel, so your are not measuring
> anything close to a worst case time,
>
> - the test needs to run for much longer than a couple of seconds or even
> worse, iterations. It needs to run for hours under load to be
> meaningful. The longer it runs with well-chosen stress loads in
> parallel, the more trustworthy it can be.
>
> In absence of formal analysis, all we have is a probabilistic approach
> for getting close to the real worst-case latency figures: the only way
> we can get there is to hammer the target system hard, diversely and long
> enough while measuring.
>
>>> Once the two modules, and two test executables are built, just push the
>>> modules (they can live together in the kernel, no conflict), then run
>>> either of the executables for measuring 1) the execution time on the
>>> write() side, and 2) the response time on the read side.
>>>
>>
>> Anyways, I have build your test application and modules (using my
>> Makefile) and verified it
>> on my x86_64 skylake machine.
>>
>> Here are the results that I obtained:
>>
>> # ./posix_test ; ./cobalt_test
>> DEVICE: /dev/bar, all microseconds
>>
>> [ 0' 0"] RD_MIN | RD_MAX |  R_AVG  | WR_MIN | WR_MAX |  WR_AVG
>> --------------------------------------------------------------
>>               0 |     16 |   0.518 |      0 |      7 |  0.338
>>               0 |     16 |   0.501 |      0 |     16 |  0.337
>>               0 |     16 |   0.501 |      0 |     16 |  0.337
>>               0 |     16 |   0.501 |      0 |     16 |  0.337
>>               0 |     16 |   0.501 |      0 |     16 |  0.337
>>               0 |     16 |   0.501 |      0 |     16 |  0.337
>>               0 |     16 |   0.501 |      0 |     16 |  0.337
>>               0 |     16 |   0.501 |      0 |     16 |  0.337
>>               0 |     16 |   0.501 |      0 |     16 |  0.337
>> ^C
>> DEVICE: /dev/rtdm/foo, all microseconds
>>
>> [ 0' 0"] RD_MIN | RD_MAX |  R_AVG  | WR_MIN | WR_MAX |  WR_AVG
>> --------------------------------------------------------------
>>               0 |      1 |   0.573 |      0 |      1 |  0.241
>>               0 |     17 |   0.570 |      0 |     17 |  0.240
>>               0 |     17 |   0.570 |      0 |     17 |  0.240
>>               0 |     17 |   0.570 |      0 |     17 |  0.240
>>               0 |     17 |   0.570 |      0 |     17 |  0.240
>>               0 |     17 |   0.570 |      0 |     17 |  0.240
>>               0 |     17 |   0.570 |      0 |     17 |  0.240
>>               0 |     17 |   0.570 |      0 |     17 |  0.240
>> ^C
>>
>> Here, I did not run any dd or hackbench loops.
>> This is just a plan run on x86 PC.
>
> Which is wrong and totally defeats the purpose of your test, see above.
> Really, you do want to run significant stress load in parallel to any of
> your test, which must last long enough to be meaningful.
>
>>
>> Here also it looks like read_max is higher for rtdm case.
>
> The information you have from RD_MAX after only a few seconds is
> meaningless, the average might be slightly more useful. It says that on
> average, it takes 69 nanoseconds more to run the RTDM  write() syscall
> compared to a native one, while no other activity is eagerly trying to
> grab the CPU, or causing cacheline eviction. Which may definitely be the
> case, since Xenomai may be running more code in the syscall path in some
> situations.
>
> Taking the argument to the extremes, this basically tells you that you
> might want to use a native kernel for running empty write() system calls
> on an idle machine. For any other usage, you might want to consider
> other factors that may well happen in real world systems.
>
> Metaphorically speaking, this real-time game is not about shooting the
> ball through the hoop most of the time, but doing so every time a shot
> is taken instead, including when the shooter is facing both the
> non-cooperative 250 lbs power forward and 7 ft pivot from the other side.
>
> --
> Philippe.

