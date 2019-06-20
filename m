Subject: Re: linux not getting gpio interrupts on xenomai 3.0.8 on raspberrypi
 raspbian/stretch kernel 4.9
References: <4707bb12-658a-f74c-84b6-332424be2bb9@cs.ru.nl>
 <844c96f4-191f-dd82-8a02-d3a99ac74fef@cs.ru.nl>
 <CALLqZ8RM0_yLbM+K=Wo4SVa46a7Dp8SYBLdAMxGWfAbrtR5hQg@mail.gmail.com>
 <9dd68ccb-054a-5ccb-91d9-55267145a34f@cs.ru.nl>
 <CALLqZ8R9o356vp0pcbkfbqFJt09ENDLwnd62ziUTW86SSbKw8g@mail.gmail.com>
 <41dedf13-0136-b905-d70d-fef1ade4dbe7@cs.ru.nl>
 <bac8728d-459b-ad23-3bd4-362494ccc615@web.de>
 <c677c9b5-67ed-ee87-1e95-3ee3185c73c4@cs.ru.nl>
 <CALLqZ8T9B2Wxeu=w-Or_iYqY-spCZCN5xv+81cUbjaPS+c-vLw@mail.gmail.com>
 <c7402819-9b82-cb02-4edb-d2c5e75dd30f@cs.ru.nl>
From: Harco Kuppens <h.kuppens@cs.ru.nl>
Message-ID: <b730963a-1976-69a3-33cc-b1bcc73fcc63@cs.ru.nl>
Date: Thu, 20 Jun 2019 17:00:08 +0200
MIME-Version: 1.0
In-Reply-To: <c7402819-9b82-cb02-4edb-d2c5e75dd30f@cs.ru.nl>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: nl
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


I used 'make multi_v7_defconfig '

See my build instructions at:

https://github.com/harcokuppens/xenomai3_rpi_gpio/blob/master/install/installation_of_xenomai_3.0.8_on_mainline_kernel_branch_v4.9.51_from_kernel.org__problem_linux_gpio.md


Best regards,
Harco Kuppens


Op 20/06/2019 om 16:57 schreef Harco Kuppens via Xenomai:
>
>
> Op 20/06/2019 om 16:45 schreef Greg Gallagher:
>>
>> Do you have sysfs interface turned on when building the mainline
>> kernels?  Dumb question but it was turned off by default when I was
>> doing my builds.
>> Should be under Device Drivers => GPIO Support -> /sys/class/gpio
>> (sysfs interface) when you do a menuconfig.
>>
>>
> yes, I just checked.
>
> It is the config option CONFIG_GPIO_SYSFS
> and this option is set if you use
>
>     make multi_v7_defconfig
>
> to start with an initial config.
>
> cheers
> Harco
>
> ||


