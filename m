Subject: Re: [PATCH 0/2]GPIO Loopback Benchmark Tool
References: <1593758235-9182-1-git-send-email-chensong@tj.kylinos.cn>
 <7da53e5c-fc93-e3e5-3af0-b00939cf6524@siemens.com>
 <5f028011.1c69fb81.26862.50daSMTPIN_ADDED_BROKEN@mx.google.com>
 <CALLqZ8RadVXGZf3YsXwANCXvyyZep-0u+quQ5B77mJKQ_Zj0pQ@mail.gmail.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5F02EEF7.1020800@tj.kylinos.cn>+24AFE17151BD6824
Date: Mon, 6 Jul 2020 17:29:27 +0800
MIME-Version: 1.0
In-Reply-To: <CALLqZ8RadVXGZf3YsXwANCXvyyZep-0u+quQ5B77mJKQ_Zj0pQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>



On 2020年07月06日 13:59, Greg Gallagher wrote:
> Hi
>
> On Sun, Jul 5, 2020 at 9:36 PM chensong via Xenomai <xenomai@xenomai.org> wrote:
>>
>>
>>
>> On 2020年07月03日 17:21, Jan Kiszka wrote:
>>> On 03.07.20 08:37, chensong via Xenomai wrote:
>>>> In general, we use cyclictest and latency to evaluate the determinism
>>>> of our real
>>>> time system. As we know, cyclictest and latency use hrtimer to set up
>>>> a timer and
>>>> calculate jitter by comparing expected wakeup time and real wakeup time.
>>>>
>>>> Besides that, we can also use GPIO to evaluate more modules in
>>>> different scenarios.
>>>> In this case, i apply 2 GPIO ports, one is set as output, the other is
>>>> interrupt,
>>>> at the same time, connect them with a cable. Once an signal is sent
>>>> from output pin,
>>>> an interrupt will be raised in interrupt pin immediately.
>>>>
>>>> Timestamps are recorded before gpio_set_value and interrupt handler
>>>> respectively, the
>>>> diff between them is jitter.
>>>>
>>>> There is also an RT task running in the user space, which collects the
>>>> information and
>>>> output the summary at the end of the test. What's more, it also
>>>> records the timestamps
>>>> in user space, syscall overhead is included.
>>>>
>>>> Further, Making a little change will enable the tool working with
>>>> latency box,once a
>>>> signal from latency box is received in interrupt pin, the tool can
>>>> send a signal at
>>>> output pin as response. (I haven't got the latency box, so this
>>>> function is not in
>>>> place yet)
>>>>
>>>> chensong (2):
>>>>     demo/posix/cobalt: App of gpio loopback benchmark
>>>>     kernel/driver/testing: Driver of gpio loopback benchmark
>>>>
>>>>    demo/posix/cobalt/Makefile.am      |   6 +
>>>>    demo/posix/cobalt/gpioloop.c       | 516
>>>> +++++++++++++++++++++++++++++++++++++
>>>>    kernel/drivers/testing/Kconfig     |   7 +
>>>>    kernel/drivers/testing/Makefile    |   3 +
>>>>    kernel/drivers/testing/gpiobench.c | 288 +++++++++++++++++++++
>>>>    5 files changed, 820 insertions(+)
>>>>    create mode 100644 demo/posix/cobalt/gpioloop.c
>>>>    create mode 100644 kernel/drivers/testing/gpiobench.c
>>>>
>>>
>>> That is a valuable addition! We used to have such an interrupt benchmark
>>> in Xenomai 2 times or so, using a null modem connection (UART signals).
>>> GPIOs are more generic, though.
>>>
>>> Two things I would recommend doing differently:
>>>    - use RTDM GPIO device (maybe adding missing RTDM GPIO driver for
>>>      your targets)
>> gpiobench.c in patch2/2 is referring to gpio-core.c in
>> kernel/driver/gpio, they use similar RTDM strcuts or APIs such as
>> rtdm_driver, rtdm_dev_register.
>>
>> Could you please give me a sample of RTDM GPIO device? or what kind of
>> RTDM GPIO driver did i miss?
>>
> You could add a proper RTDM gpio driver similar to
> kernel/drivers/gpio/gpio-omap.c
>
> They are pretty easy to add since there's a gpio framework in Xenomai
> that uses some functions from gpiolib.  This commit
> d4416d68082f538cdbf08579f99738adbe80d39c may help as an example on how
> to add a new gpio driver. Let me know if I can help.
i think i understand gpio framework in gpio-omap.c and gpio-core.c, 
therefore, gpiobench.c in my patch can be replaced. what's more, a new 
file like gpio-bcm2711.c is needed.

I also looked into /testsuite/gpiotest/gpiotest.c, it's working with 
gpio-core.c and read the timestamp of gpio interrupt, however, there is 
no histogram, nor reacting to latency-box. i'm considering to add such 
functionalities in either gpiotest.c or still in gpioloop.c of my patch? 
which one would you prefer?

by the way, could you please let me know how gpiotest is triggered in 
smokey test,i read the code of smokey test and didn't manage to figure 
it out.

>
> -Greg
>



