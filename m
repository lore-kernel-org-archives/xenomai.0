Message-ID: <4D3E72F3.6040400@domain.hid>
Date: Tue, 25 Jan 2011 07:51:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=wo34Zr40GZ+HKegcFKYYcDqj8uzgEqyDCqDj=@mail.gmail.com>	<4D3E385A.5010209@domain.hid>	<AANLkTikk=xBwB2JzxgyC08=nZY8gAHeXht+_cfZBMGK7@domain.hid>	<4D3E42BA.4000601@domain.hid>	<AANLkTi=E=4mSZ_QwD5wNXQMZ2dQJO6kG8vMLGnD52cy0@domain.hid>	<4D3E4EBA.6050806@domain.hid>	<AANLkTike9rXOKAuGy3Pi+ot8-753pzNAEK=xjhsgzU3O@mail.gmail.com>	<4D3E5169.8050103@domain.hid>	<AANLkTimxTLpGR6KvVBuermWiaqwkuod7QQxNVBXrmtyd@domain.hid>	<4D3E576B.7060208@domain.hid>	<AANLkTinAKRXB8jYJ-dMN0miqM37bT1O=oHa-uYaQQ-yo@domain.hid>	<4D3E5959.9090205@domain.hid>	<AANLkTimPA6yhFEYjQ-jpJtjQOx-2179HKNs3HTTwjY0T@mail.gmail.com>	<4D3E5BC2.6070700@domain.hid>	<AANLkTikzrOHi8caNdYg_FOY4NdhjWsh5qZZGYvD1URJ2@domain.hid>	<4D3E6B94.5060302@domain.hid>
	<AANLkTimcpzTWvYyEfdVVqEqO_-hb-jb1p7kLLDaVrzrV@mail.gmail.com>
In-Reply-To: <AANLkTimcpzTWvYyEfdVVqEqO_-hb-jb1p7kLLDaVrzrV@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Segmentation Fault when writing in registers
 (AT91SAM - ARM9)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: at91_enthus <nwromania@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

at91_enthus wrote:
> On Tue, Jan 25, 2011 at 12:20 AM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> at91_enthus wrote:
>>>>> Oh. I assumed without mlockall (it wasn't part of my original code).
>>>>> Now, I placed mlockall in my original code (right before
>>>> open_controller())
>>>>> and the pin gets toggled according to my scope.
>>>> Ok. Show me the Makefile then.
>>> And the code which works.
>>>
>>>
>>>  see attachment
>>>
>>>
>>>> Including the
>>>> value of the defines please (not all of them, only those the program
>>>> uses for open_controller).
>>>>
>>>>
>>>>
>>> #define AT91C_BASE_AIC          0xFFFFF000 // (AIC) Base Address
>>> #define AT91C_BASE_PIOB        0xFFFFF600 // (PIOB) Base Address
>>> #define PIO_PER             0x00000000 // (PIO_PER) PIO Enable Register
>>> #define PIO_PDR             0x00000004 // (PIO_PDR) PIO Disable Register
>>> #define PIO_PSR             0x00000008 // (PIO_PSR) PIO Status Register
>>> #define PIO_OER             0x00000010 // (PIO_OER) Output Enable
>> Register
>>> #define PIO_SODR           0x00000030 // (PIO_SODR) Set Output Data
>> Register
>>> #define PIO_CODR           0x00000034 // (PIO_CODR) Clear Output Data
>>> Register
>>> #define PIO_PPUDR         0x00000060 // (PIO_PPUDR) Pull-up Disable
>> Register
>>> #define PIO_MDDR           0x00000054 // (PIO_MDDR) Multi-driver Disable
>>> Register
>>>
>>>
>> I am unable to reproduce your issue. That said, I am using standard
>> Makefiles, that is:
>>
>> XENO_CONFIG = DESTDIR="$(staging)" $(staging)/bin/xeno-config
>>
>> XENO_NATIVE_CPPFLAGS = $(shell $(XENO_CONFIG) --skin=native --cflags)
>> XENO_NATIVE_LIBS = $(shell $(XENO_CONFIG) --skin=native --ldflags)
>>
>> Where staging would be "/" in your case.
>>
>> If I want static libraries, I prepend -static to XENO_NATIVE_LIBS, I do
>> not try to link both with static and dynamic libraries. I suspect this
>> is the cause of your problem, either that or the fact that you have some
>> ulimit.
>>
>> Note that my toolchain does not even allow mixing static and dynamic
>> libraries. I get this warning when linking:
>>
>> /usr/local/arm-2010q1/bin/../lib/gcc/arm-none-linux-gnueabi/4.4.1/../../../../arm-none-linux-gnueabi/bin/ld:
>>
>> /usr/local/arm-2010q1/bin/../arm-none-linux-gnueabi/libc/armv4t/usr/lib/libc.a(dl-tsd.o)(.text+0x18):
>> R_ARM_TLS_LE32 relocation not permitted in shared object
>>
>> And a segmentation fault when running (though I do not even access the
>> mmapped area).
>>
>> --
>>                                                                 Gilles.
>>
> 
> 
> I'll try to fix this issue later today. Thanks a lot for taking the time to
> help me.

Yes, note that I wasted a lot of time: I knew from the beginning that
the Makefile was broken, and this should have been the first thing I
verified.

Anyway, the "first-hand" examples we provide are those documented here:
http://www.xenomai.org/index.php/Examples

They come with working Makefiles, which you are encouraged to re-use.

Also, xeno-config lacks support for getting the RTDM skin flags, but I
am going to add it to 2.5.6.

-- 
                                                                Gilles.

