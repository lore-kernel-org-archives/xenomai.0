Message-ID: <4FD62635.7040501@xenomai.org>
Date: Mon, 11 Jun 2012 19:09:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FCD0BD8.70103@laposte.net> <4FCD0C4D.6000004@xenomai.org>
	<4FD4EB23.7080203@laposte.net> <4FD4FF04.2030804@xenomai.org>
	<4FD61BF8.9090901@laposte.net>
In-Reply-To: <4FD61BF8.9090901@laposte.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] "illegal instruction",
 then "rt_task_start()" error -38 (on a 486/no fpu)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marc Le Douarain <marc.le-douarain@laposte.net>
Cc: Xenomai <xenomai@xenomai.org>

On 06/11/2012 06:25 PM, Marc Le Douarain wrote:
> Le 10/06/2012 22:09, Gilles Chanteperdrix a écrit :
>> On 06/10/2012 08:44 PM, Marc Le Douarain wrote:
>>> Le 04/06/2012 21:28, Gilles Chanteperdrix a écrit :
>>>> On 06/04/2012 09:26 PM, Marc Le Douarain wrote:
>>>>> Hello,
>>>>>
>>>>> I've some difficulties to run Xenomai with a little 'hello' example
>>>>> (that create/start a task)
>>>>> on a target 486 processor (without fpu).
>>>>>
>>>>> I successfully compiled the Linux kernel 2.6.38.8 with
>>>>> adeos-ipipe-2.6.38.8-x86-2.11-02.patch (Xenomai version is 2.5.6)
>>>>> (modify file xenomai-2.5.6/include/asm-x86/calibration.h
>>>>> "current_cpu_data"->"cpu_info" were required)
>>>>>
>>>>> dmesg extract:
>>>>> [    0.000000] I-pipe 2.11-02: pipeline enabled.
>>>>> ...
>>>>> [    0.140008] CPU: Cyrix Cx486SLC
>>>>> ...
>>>>> [    1.440804] Xenomai: hal/i386 started.
>>>>> [    1.448804] Xenomai: scheduling class idle registered.
>>>>> [    1.452804] Xenomai: scheduling class rt registered.
>>>>> [    1.488806] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
>>>>> [    1.496807] Xenomai: starting native API services.
>>>>> [    1.500807] Xenomai: starting POSIX services.
>>>>> [    1.504807] Xenomai: starting RTDM services.
>>>> It may be due to the omit-frame-pointer option, please try adding
>>>> -fno-omit-frame-pointer to the CFLAGS
>>> Thanks for the tip,
>>> now it seems to work correctly !
>>> I've used the following command line to configure Xenomai user-part :
>>> "./configure CFLAGS="-march=i486 -fno-omit-frame-pointer"
>>> LDFLAGS="-march=i486" --disable-x86-sep --disable-x86-tsc"
>>>
>>> I've savagely modified latency.c, to avoid libm and double variables in
>>> the code,
>> You probably can use double variable, but you have to compile with
>> -msoft-float.
>>
>>> and now when launching a 10millisecs period,
>>> without load I've at worst about 170 microsecs, and best 90 microsecs.
>>> and with load (dd if=/dev/zero of=/dev/null&  telnet session while ls;do
>>> ls;done&  ping -f) :
>>> worst 200 microsecs, and best 110 microsecs.
>>> For you, seems to be correct for an embedded equivalent 486 at 300 mhz ?
>>> (Linux bogomips gives : 96.51)
>>>
>>> Again, many thanks for the gcc optimize flag to avoid on it ! ;-)
>> When using the 8254 as clocksource, and PIT as timer, the atom I have
>> gets crappy latencies (the 8254 tsc can not be used in user-space, so,
>> for instance the call to rt_timer_tsc in latency leads to a syscall, and
>> the 8254 itself is read through the ISA bus, which is pretty slow). So,
>> I am not surprised that you get poor latencies on this processor. And
>> according to what I read, a cyrix 486SLC runs at frequencies under
>> 60MHz, not 300 MHz, which the 96.51 bogomips confirms.
>> And Xenophile:
>> "Yes, that sort of bogomips figure does not seem anything near what I
>> would expect at 300 MHz.
>> Maybe you should check your into on clock freq."
> In fact, it is a SoC by DM&P: a Vortex86SX at 300 mhz
> ( verified in the BIOS, if no "divide per" activated per error ;-) )
> I think the latency is just enough precise for 2 tasks about 5>30 
> milli-secs, that would read/filter some inputs, and drive outputs to do 
> a basic programmable logic controller... we are not about 0,1 milli-secs...
> About BogoMips, here at http://en.wikipedia.org/wiki/BogoMips, it is 
> written "clock x 0.34" to obtain it for a Cyrix/IBM 486, so 300 mhz -> 
> 100 it is near...
> (it is "clock x 1.00" on 586/Pentium!!!)

I think vortex86sx has a tsc, so, you should try and modify the linux
kernel configuration to select  CONFIG_X86_TSC, or simply select a
processor which has a tsc. You will get better latencies.

-- 
					    Gilles.

