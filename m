Message-ID: <4DFDFF7C.7000805@domain.hid>
Date: Sun, 19 Jun 2011 15:54:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTikoPvhb1XmycYm=MROT7=BGA8cisg@domain.hid>	<4DFDF79F.1090502@domain.hid>	<BANLkTinVUd-R1cpD+40MGZZckzGhwrqRvw@domain.hid>
	<4DFDFD2F.1080506@domain.hid>
In-Reply-To: <4DFDFD2F.1080506@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem accesing I2C without using Linux kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andrey Nechypurenko <andreynech@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 06/19/2011 03:44 PM, Gilles Chanteperdrix wrote:
> On 06/19/2011 03:34 PM, Andrey Nechypurenko wrote:
>> Hi Gilles,
>>
>>>> fd = open("/dev/mem", O_RDWR | O_SYNC);
>>>> i2c_base = mmap(NULL, sizeof(i2c_base),
>>>>                PROT_READ | PROT_WRITE,
>>>>                MAP_SHARED, fd, I2C_DEFAULT_BASE);
>>>
>>> What is the value of i2c_base here? If it is MAP_FAILED, then mmap
>>> failed. And one reason for failing would be that sizeof(i2c_base) is not
>>> a multiple of the page size.
>>
>> In actual code I do check for the errors like below and it seams like
>> memory is mapped without errors:
>>
>>   if(i2c_base == NULL)
>>   {
>>     fd = open("/dev/mem", O_RDWR | O_SYNC);
>>     if(fd < 0)
>>     {
>>       fprintf(stderr, "Could not open memory\n");
>>       return;
>>     }
>>
>>     i2c_base =
>>       (volatile struct i2c *)mmap(NULL, sizeof(i2c_base),
>>                                   PROT_READ | PROT_WRITE,
>>                                   MAP_SHARED, fd, I2C_DEFAULT_BASE);
>>     if(i2c_base == MAP_FAILED)
>>     {
>>       fprintf(stderr, "Memory Mapping failed\n");
>>       close(fd);
>>       return;
>>     }
>>   }
>>
>> Regarding the size of the memory mapped block - i2c_base is a pointer
>> and that is why, the mmap invocation above is incorrect. It should be
>> mmap(NULL, sizeof(struct i2c). This is a typo resulted by multiple
>> experiments I was doing. sizeof(struct i2c) is 64 and event with this
>> value, the same "Bus error" message is printed and the application
>> quits.
> 
> Ok. I would pass the size of an entire page anyway, I do not think
> mapping anything not aligned on a page boundary makes sense.
> 
> If it still fails, enable CONFIG_DEBUG_USER in kernel configuration,
> pass user_debug=29 on kernel command line, and post the user debug log
> upon failure, then the disassembly of the function where the SIGBUS happens.
> 
> Note that this mailing list is probably not the best place to ask your
> question, since we mostly talk about Xenomai here, and your issue does
> not seem to have anything to do with Xenomai.
> 
> Please keep the discussion public.

Second stupid questions: are you sure all the clocks needed to get that
I2C module running are enabled?

-- 
                                                                Gilles.

