Message-ID: <4D3E5666.8040809@domain.hid>
Date: Tue, 25 Jan 2011 05:49:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=wo34Zr40GZ+HKegcFKYYcDqj8uzgEqyDCqDj=@mail.gmail.com>	<4D3E385A.5010209@domain.hid>	<AANLkTikk=xBwB2JzxgyC08=nZY8gAHeXht+_cfZBMGK7@domain.hid>	<4D3E42BA.4000601@domain.hid>	<AANLkTi=E=4mSZ_QwD5wNXQMZ2dQJO6kG8vMLGnD52cy0@domain.hid>	<4D3E4EBA.6050806@domain.hid>	<AANLkTike9rXOKAuGy3Pi+ot8-753pzNAEK=xjhsgzU3O@mail.gmail.com>	<4D3E5169.8050103@domain.hid>
	<AANLkTimxTLpGR6KvVBuermWiaqwkuod7QQxNVBXrmtyd@domain.hid>
In-Reply-To: <AANLkTimxTLpGR6KvVBuermWiaqwkuod7QQxNVBXrmtyd@domain.hid>
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
> On Mon, Jan 24, 2011 at 10:28 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> at91_enthus wrote:
>>> On Mon, Jan 24, 2011 at 10:16 PM, Gilles Chanteperdrix <
>>> gilles.chanteperdrix@xenomai.org> wrote:
>>>
>>>> at91_enthus wrote:
>>>>> On Mon, Jan 24, 2011 at 9:25 PM, Gilles Chanteperdrix <
>>>>> gilles.chanteperdrix@xenomai.org> wrote:
>>>>>
>>>>>> at91_enthus wrote:
>>>>>>> On Mon, Jan 24, 2011 at 8:41 PM, Gilles Chanteperdrix <
>>>>>>> gilles.chanteperdrix@xenomai.org> wrote:
>>>>>>>
>>>>>>>> at91_enthus wrote:
>>>>>>>>> Hi.
>>>>>>>>>
>>>>>>>>> I  was testing Xenomai on my AT91SAM9G20-based board and tried to
>>>> adapt
>>>>>>>> the
>>>>>>>>> code found here:
>>>>>>>>> http://www.armadeus.com/wiki/index.php?title=Xenomai:Blinking_LEDs.
>>>>>>>> By the way, this code is ridiculous. It creates a real-time task to
>>>>>>>> write to some non real-time device, which makes the real-time task
>>>>>> useless.
>>>>>>> I know.
>>>>>> Yes, but this example is bad in many ways:
>>>>>> - first it uses xenomai api to create a real-time task, and uses write
>>>>>> which causes the real-time task to switch to secondary domain;
>>>>>> - the Makefile does not use xeno-config, which have been the
>> recommended
>>>>>> way of getting the compiler flags since day 1;
>>>>>> - it nullifies SIGTERM and SIGINT, which is a dubious decision, and
>>>>>> could lead people to believe that they should do the same when using
>>>>>> Xenomai, whereas there is no such requirement.
>>>>>> - the pointers point to outdated version of the documentation.
>>>>>> - it uses runinfo/xeno-load, which are kind of outdated too, make
>> things
>>>>>> uselessly complicated, and in any case, tell you to type Ctrl-C to
>>>>>> interrupt the program, which is bound to fail if anything goes wrong,
>>>>>> since SIGINT is neutralized in the program.
>>>>>>
>>>>>>> That's why I went to mmap().
>>>>>> That is not really the right solution either. I admit that for driving
>>>>>> leds, it may be a bit overkill, but anyway, what you should do is
>> write
>>>>>> an RTDM driver for driving the leds. Keeping the driver separated from
>>>>>> the application will allow the same program to run on other platforms
>>>>>> where driving the LEDS is done differently without changing much of
>> the
>>>>>> application code. In other word, the application/driver separation is
>> a
>>>>>> sane one.
>>>>>>
>>>>>> Anyway, mmap should work.
>>>>>>
>>>>>>  (I chose that sample code because, for
>>>>>>> now, I am only learning to use basic functions)
>>>>>>>> Wrong test here. Should be "if (aic_base == MAP_FAILED)"
>>>>>>> Indeed, my program fails miserably when I check the mapping of AIC,
>> not
>>>>>>> PIOB's. And yet, I just can't figure why in the non-Xenomai code, AIC
>>>>>>> mmap-ing works  fine.
>>>>>> Well errno might give you a clue. Do you have FCSE enabled?
>>>>>>
>>>>>> Regards.
>>>>>>
>>>>>> --
>>>>>>
>> Gilles.
>>>>> FCSE is enabled. errno returns  22 (invalid argument).
>>>> best effort or guaranteed?
>>>
>>> Best effort
>>>
>>>
>>>> Please activate FCSE messages.
>>>
>>> ... compiling new kernel
>>>
>>>
>>>> How big is
>>>> MAP_SIZE?
>>>>
>>>>
>>> 4096
>> Ok. Could you post your full kernel configuration, as well as the full
>> program?
>>
> 
> I put the .config and the code in the attachments.
> 
> 
>> Are you running this program as root?
>>
>>
> I run it with sudo.

Ok. Please make sure that you are not running with some funky ulimit
settings then, I will try and compile it on at91sam9263.


-- 
                                                                Gilles.

