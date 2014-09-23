Message-ID: <ed538941c12a055ad7c08a1a45488e88.squirrel@wandercraft.eu>
In-Reply-To: <083fe1b44c93cedd866b85dcaa7bc4ae.squirrel@wandercraft.eu>
References: <083fe1b44c93cedd866b85dcaa7bc4ae.squirrel@wandercraft.eu>
Date: Tue, 23 Sep 2014 10:09:35 +0200
From: huy-cong.vu@wandercraft.eu
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] clock_gettime cause runaway thread
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

>> On 09/22/2014 12:25 PM, huy-cong.vu@wandercraft.eu wrote:
>>>> On 09/19/2014 06:53 PM, Philippe Gerum wrote:
>>>>> On 09/19/2014 06:11 PM, huy-cong.vu@wandercraft.eu wrote:
>>>>>> Hello everyone,
>>>>>> I'm currently working with Xenomai in my company's project using
>>>>>> RTNet
>>>>>> as
>>>>>> realtime ethernet driver to communicate with Elmo card via EtherCAT
>>>>>> protocol and SOEM as master library.
>>>>>>
>>>>>> I'm using Linux 3.8.13 patched with Xenomai 2.6.3.
>>>>>>
>>>>>> I'm debugging a simple test which is a cycle of send & receive data
>>>>>> with a
>>>>>> frequency of 1 kHz. The test runs fine for a quite long time (30
>>>>>> mins
>>>>>> in
>>>>>> average), but still throws runaway thread after a certain time.
>>>>>>
>>>>>> My loop is a periodic thread:
>>>>>>
>>>>>> rt_task_set_periodic(rt_task_self(), TM_NOW, 1000000);
>>>>>> while(1){
>>>>>> rt_task_wait_period();
>>>>>> ec_send_processdata();     //SOEM function
>>>>>> ec_receive_processdata();  //SOEM function
>>>>>> }
>>>>>>
>>>>>> With SIGDEBUG & gdb, the error seems to start from clock_gettime
>>>>>> (when
>>>>>> ec_receive_processdata is called) with CLOCK_MONOTONIC, change to
>>>>>> CLOCK_REALTIME reproduces the same issue. My processor is x86_64, I
>>>>>> heard
>>>>>> that the High Resolution Timer of Linux kernel is not supported for
>>>>>> processor 64 bits, this could be the reason for such behavior?
>>>>>>
>>>>>
>>>>> I never heard about the restriction you are referring to.
>>>>>
>>>>
>>>> If you are referring to the deadlock issue when calling the regular
>>>> glibc services such as gettimeofday/clock_gettime from rt mode, then
>>>> this is not a 64bit specific issue. You need to call the
>>>> clock_gettime()
>>>> service from the Xenomai POSIX API, asking for CLOCK_HOST_REALTIME.
>>>>
>>>> --
>>>> Philippe.
>>>>
>>>
>>> Hello,
>>> I tried to call clock_gettime() with CLOCK_HOST_REALTIME, but my
>>> hardware
>>> fall directly into error. If I understand correctly,
>>> CLOCK_HOST_REALTIME
>>> is called from the POSIX skin, a.k.a secondary mode,
>>
>> The POSIX skin does not imply secondary mode, quite the contrary: it
>> aims at running POSIX services in primary mode. Secondary mode means
>> regular linux mode, not controlled by the Xenomai co-kernel.
>>
>>  while my application
>>
>> No, it runs from primary mode. It has been designed with that intent in
>> mind, precisely because the way gettimeofday/clock_gettime are
>> implemented over the vsyscall mechanism makes them incompatible with any
>> usage from primary mode.
>>
>>> need to run at primary mode, that's why it stops running right away.
>>> Using
>>> CLOCK_MONOTONIC & CLOCK_REALTIME was fine. What is the main difference
>>> between these timers?
>>
>> CLOCK_REALTIME served by the POSIX skin uses the Xenomai idea of time
>> (epoch). This is not in sync with the epoch used by the regular kernel,
>> hence HOST_REALTIME. CLOCK_MONOTONIC served by the POSIX skin is the
>> same as rt_timer_tsc(), i.e. a raw tick count maintained by some high
>> precision timer we use on the hardware platform, monotonically
>> increasing.
>>
>> You should really make sure to use the right clock_gettime(), i.e. the
>> one from libpthread_rt.
>> http://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/
>>
>> --
>> Philippe.
>>
>
> Thanks Philippe,
> I'm following the porting guide that you suggest. One small question: Is
> this possible to mix between POSIX & native skin of Xenomai? Because most
> of my app's code is in native skin, but some services are only accessible
> via POSIX skins (like setschedparam). Is there a risk in mixing these 2?
> And which are the flags need to be passing to the compiler to get a good
> mixes?
>
> Huy Cong VU
>
> Ps: Same question but with a new thread, like Gilles advice
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>

Using the clock_gettime() with Xenomai POSIX skill solved the issue.
Thanks for your help.

Huy Cong VU


