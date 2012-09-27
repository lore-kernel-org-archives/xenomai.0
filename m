Message-ID: <5064C1CB.5070209@xenomai.org>
Date: Thu, 27 Sep 2012 23:14:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOiXNkCgA42HcOWaLuzmkaLPaSW2zCTEux3rdzKmUYeu1Egzyg@mail.gmail.com>	<506496C2.9030302@xenomai.org>	<CAOiXNkA3NLDDzt6PaYj670jGuAeES_r8pm0Q6qo9vAk=zgO9VA@mail.gmail.com>	<5064BFDB.1040906@xenomai.org>
	<CAOiXNkAxMRy5m+-2gwvNbx_YDCOFW-QHJRU-5hRTnBx=3HefAw@mail.gmail.com>
In-Reply-To: <CAOiXNkAxMRy5m+-2gwvNbx_YDCOFW-QHJRU-5hRTnBx=3HefAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Error requesting IRQ on DM3730 (BeagleBoard xM)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andrey Nechypurenko <andreynech@googlemail.com>
Cc: xenomai@xenomai.org

On 09/27/2012 11:08 PM, Andrey Nechypurenko wrote:

> On 27 September 2012 23:06, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 09/27/2012 11:05 PM, Andrey Nechypurenko wrote:
>>
>>>   retval = InitGPIO(channels, sizeof(channels) / sizeof(channels[0]));
>>
>>
>> The code for this funtion is missing.
>>
>> --
>>                                                                 Gilles.
> static void __iomem *confmem = NULL;
> 
> 
> int
> InitGPIO(ChannelConfig *channels, size_t ch_count)
> {
>   const u16 mode_value = (EN | PTD | M4);
>   const u32 conf_val = ((1<<5)|(1<<2)|(1<<4)|(1<<3)|(1<<8)|(1<<6)|(1<<7));
>   size_t i;
>   u32 cur_val;
> 
>   rtdm_printk("TB6612FNG: configuring I/O pins mode\n");
>   confmem = ioremap(0x48000000, 0x05cc);
> 
>   // STBY GPIO 133 - Bank 5, base addr 0x4905 6000
>   iowrite16(mode_value, confmem + 0x215C + 2);
>   // PWMA GPIO 130
>   iowrite16(mode_value, confmem + 0x2158);
>   // AIN1 GPIO 132
>   iowrite16(mode_value, confmem + 0x215C);
>   // AIN2 GPIO 131
>   iowrite16(mode_value, confmem + 0x2158 + 2);
>   // PWMB GPIO 136
>   iowrite16(mode_value, confmem + 0x2164);
>   // BIN1 GPIO 134
>   iowrite16(mode_value, confmem + 0x2160);
>   // BIN2 GPIO 135
>   iowrite16(mode_value, confmem + 0x2160 + 2);
> 
>   // ENC1 GPIO 143
>   iowrite16(IEN | mode_value, confmem + 0x2170 + 2);
> 
> 
>   iounmap(confmem);
>   confmem = NULL;
>   confmem = ioremap(0x49050000, 0x05cc);
>   if(!confmem)
>     {
>       rtdm_printk("TB6612FNG: GPIO bank mapping failed\n");
>       return 2;
>     }
>   else
>     rtdm_printk("TB6612FNG: GPIO bank mapped to address %p\n", confmem);
> 
>   // GPIO_OE - config pins as output
>   cur_val = ioread32(confmem + 0x6034);
>   iowrite32(cur_val & (~conf_val), confmem + 0x6034);
>   // Disable the wakeupenable and irqenable intertupts
>   cur_val = ioread32(confmem + 0x6080);
>   iowrite32(cur_val | conf_val, confmem + 0x6080);
>   // GPIO clear_irqenable1
>   cur_val = ioread32(confmem + 0x6060);
>   iowrite32(cur_val | conf_val, confmem + 0x6060);
>   // GPIO clear_irqenable2 is offset
>   cur_val = ioread32(confmem + 0x6070);
>   iowrite32(cur_val | conf_val, confmem + 0x6070);
> 
>   // Enable interrupts for rotary encoders
>   // 15 = (gpio)143 - 128
>   // GPIO_OE - config pins as input
>   cur_val = ioread32(confmem + 0x6034);
>   iowrite32(cur_val | (1 << 15), confmem + 0x6034);
>   // GPIO_RISINGDETECT
>   iowrite32(1 << 15, confmem + 0x6048);
>   //GPIO_FALLINGDETECT
>   iowrite32(1 << 15, confmem + 0x604C);
>   // GPIO_SETIRQENABLE1
>   iowrite32(1 << 15, confmem + 0x6064);
>   // GPIO_IRQENABLE1
>   cur_val = ioread32(confmem + 0x601C);
>   iowrite32(cur_val | (1 << 15), confmem + 0x601C);
>   // GPIO_IRQSTATUS1
>   iowrite32(1 << 15, confmem + 0x6018);
>   return 0;
> }
> 

You are really supposed to use the kernel API for these things, and not
touch the registers directly. But I agree that it is not the issue. No
sign of interrupt disabling. I think Jan already talked about the issue
you have:

http://www.xenomai.org/pipermail/xenomai/2012-September/026267.html

It is a false positive, you can safely ignore the warning or remove the
check from the code.

-- 
                                                                Gilles.

