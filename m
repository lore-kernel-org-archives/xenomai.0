Subject: Re: [PATCH 0/2]GPIO Loopback Benchmark Tool
References: <1593758235-9182-1-git-send-email-chensong@tj.kylinos.cn>
 <7da53e5c-fc93-e3e5-3af0-b00939cf6524@siemens.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5F027FE2.6040408@tj.kylinos.cn>+860C87B6E51A2CCC
Date: Mon, 6 Jul 2020 09:35:30 +0800
MIME-Version: 1.0
In-Reply-To: <7da53e5c-fc93-e3e5-3af0-b00939cf6524@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org



On 2020年07月03日 17:21, Jan Kiszka wrote:
> On 03.07.20 08:37, chensong via Xenomai wrote:
>> In general, we use cyclictest and latency to evaluate the determinism
>> of our real
>> time system. As we know, cyclictest and latency use hrtimer to set up
>> a timer and
>> calculate jitter by comparing expected wakeup time and real wakeup time.
>>
>> Besides that, we can also use GPIO to evaluate more modules in
>> different scenarios.
>> In this case, i apply 2 GPIO ports, one is set as output, the other is
>> interrupt,
>> at the same time, connect them with a cable. Once an signal is sent
>> from output pin,
>> an interrupt will be raised in interrupt pin immediately.
>>
>> Timestamps are recorded before gpio_set_value and interrupt handler
>> respectively, the
>> diff between them is jitter.
>>
>> There is also an RT task running in the user space, which collects the
>> information and
>> output the summary at the end of the test. What's more, it also
>> records the timestamps
>> in user space, syscall overhead is included.
>>
>> Further, Making a little change will enable the tool working with
>> latency box,once a
>> signal from latency box is received in interrupt pin, the tool can
>> send a signal at
>> output pin as response. (I haven't got the latency box, so this
>> function is not in
>> place yet)
>>
>> chensong (2):
>>    demo/posix/cobalt: App of gpio loopback benchmark
>>    kernel/driver/testing: Driver of gpio loopback benchmark
>>
>>   demo/posix/cobalt/Makefile.am      |   6 +
>>   demo/posix/cobalt/gpioloop.c       | 516
>> +++++++++++++++++++++++++++++++++++++
>>   kernel/drivers/testing/Kconfig     |   7 +
>>   kernel/drivers/testing/Makefile    |   3 +
>>   kernel/drivers/testing/gpiobench.c | 288 +++++++++++++++++++++
>>   5 files changed, 820 insertions(+)
>>   create mode 100644 demo/posix/cobalt/gpioloop.c
>>   create mode 100644 kernel/drivers/testing/gpiobench.c
>>
>
> That is a valuable addition! We used to have such an interrupt benchmark
> in Xenomai 2 times or so, using a null modem connection (UART signals).
> GPIOs are more generic, though.
>
> Two things I would recommend doing differently:
>   - use RTDM GPIO device (maybe adding missing RTDM GPIO driver for
>     your targets)
gpiobench.c in patch2/2 is referring to gpio-core.c in 
kernel/driver/gpio, they use similar RTDM strcuts or APIs such as 
rtdm_driver, rtdm_dev_register.

Could you please give me a sample of RTDM GPIO device? or what kind of 
RTDM GPIO driver did i miss?

I've been very familiar with RTDM driver yet, so, a little more help is 
nedded, thanks.

>   - build benchmark not via loopback but via cross-link
>      - device-under-test receives truly asynchronous event on GPIO input
          from a latency-box likely device ?
>      - reacts with flipping some GPIO output
>      - can run reaction either in interrupt handler or RT application
>        task, to cover more real scenarios
>      - latency box can also be a second device that triggers event and
>        measures reaction while having interrupts off (that's how things
>        worked in Xenomai 2)

if i understand you correctly, via cross-link, you mean a latecy-box 
likely device is a must, it sends signal to device-under-test and 
device-under-test reacts with flipping GPIO output. is it asynchronous 
event?

In the patch1/2, i think switching read and write can make it work, like:

while(){
      read_gpio()
      //once receiving event
      write_gpio()  //as the reaction

}

>
> The lookback scenario is too synchronous to catch realistic latencies.
> It rather measures the performance of the event path.
>
> Jan
>



