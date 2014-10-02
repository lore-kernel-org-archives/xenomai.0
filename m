Message-ID: <542D54C0.3070001@xenomai.org>
Date: Thu, 02 Oct 2014 15:36:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACreCVKF=VQuWhaxkAPTOAaDui0aze+Vc4MOq+vby+2eBRx1iA@mail.gmail.com>	<542A945E.9000904@xenomai.org>	<CACreCVK_Xd79uaHpzODKMQHMVrH58KvsKuBQ5kRsOhM++BXT4w@mail.gmail.com>	<542A9F17.7090802@xenomai.org>	<CACreCV+sFAWEzADAD+q6ZitVLcwuKGq1WguvfaXtoX_P9KkkUQ@mail.gmail.com>	<542BB31F.8070803@xenomai.org>	<CACreCVK8axcEwipeOTxXp7cwAXz8jGOPqEG9j2dp8zosCZFrjA@mail.gmail.com>	<542BC753.8000605@xenomai.org>
 <CACreCVJvfuMeRCVdE6NTPK=frJ3_-PL-TDrZy9U5fLAW7gWjcg@mail.gmail.com>
In-Reply-To: <CACreCVJvfuMeRCVdE6NTPK=frJ3_-PL-TDrZy9U5fLAW7gWjcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Switchtest failures on ODROIDU3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/02/2014 03:27 PM, GP Orcullo wrote:
> On Wed, Oct 1, 2014 at 5:20 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 10/01/2014 11:12 AM, GP Orcullo wrote:
>>> On Oct 1, 2014 3:54 PM, "Gilles Chanteperdrix" <
>>> gilles.chanteperdrix@xenomai.org> wrote:
>>>>
>>>> On 10/01/2014 01:32 AM, GP Orcullo wrote:
>>>>> On Sep 30, 2014 8:16 PM, "Gilles Chanteperdrix" <
>>>>> gilles.chanteperdrix@xenomai.org> wrote:
>>>>>>
>>>>>> On 09/30/2014 02:04 PM, GP Orcullo wrote:
>>>>>>> On Sep 30, 2014 7:30 PM, "Gilles Chanteperdrix" <
>>>>>>> gilles.chanteperdrix@xenomai.org> wrote:
>>>>>>>>
>>>>>>>> On 09/30/2014 07:31 AM, GP Orcullo wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> Running the switchtest for extended periods (>10 mins) causes the
>>>>>>>>> machine to lockup.
>>>>>>>>>
>>>>>>>>> I'm running a modified xeno-regression-test which contains only the
>>>>>>>>> following tests:
>>>>>>>>>
>>>>>>>>> check_alive /usr/lib/xenomai/testsuite/switchtest
>>>>>>>>> check_alive /usr/lib/xenomai/testsuite/switchtest -s 1000
>>>>>>>>> check_alive /usr/lib/xenomai/testsuite/latency ${1+"$@"}
>>>>>>>>>
>>>>>>>>> The script is invoked with the following arguments:
>>>>>>>>>
>>>>>>>>> nohup sudo ./xeno-regression-test -l
>>>>>>>>> "/usr/lib/xenomai/testsuite/dohell -m /media/work 36000" -t 2 >
>>>>>>>>> /dev/null & top -d0.5
>>>>>>>>>
>>>>>>>>> The kernel dumps the OOPS information intermittently so it's
>>> difficult
>>>>>>>>> to diagnose the issue.
>>>>>>>>>
>>>>>>>>> Attached is the kernel config and the logfile.
>>>>>>>>
>>>>>>>> Ok, this is an exynos. Sorry, but I have never seen the patch for
>>>>>>>> exynos, so I do not know what is inside. You should direct your
>>>>>>>> questions to whoever provided you with this support.
>>>>>>>
>>>>>>> I'm in the process of porting xenomai to run on exynos.
>>>>>>>
>>>>>>> The ipipe-core-3.8.13-arm-3.patch applies cleanly to the 3.8.13.11
>>>>> kernel
>>>>>>> used by the odroid U3 board.
>>>>>>>
>>>>>>> Attached is the ipipe patch that I've made.
>>>>>>>
>>>>>>> I was just wondering what would cause switchtest to fail. The error
>>>>> that I
>>>>>>> can see is that the system is running out of memory and I don't know
>>>>>>> exactly what is causing this.
>>>>>>
>>>>>> Certainly not switchtest as it does not do any memory allocation.
>>>>>> However, the dohell script has a loop creating a large file and
>>> removing
>>>>>> it. So, could you try and run the dohell script with an unpatched
>>> kernel
>>>>>> and see if you have the error?
>>>>>>
>>>>>
>>>>> Running dohell on a patched and unpatched kernel doesn't trigger the
>>> lockup.
>>>>>
>>>>> Running switchtest without dohell works OK.
>>>>
>>>> Is the problem a lockup, or an OOM?
>>>>
>>>
>>> It's a lockup.
>>>
>>> The OOM message is the only one that I've captured so far.  Most of the
>>> time the kernel doesn't spew any messages before the lockup.
>>>
>>> The lockups are repeatable but generating any error messages isn't.
>>
>> Are you running the tests on the serial console, or with ssh? Do you
>> have unlocked context switch enabled? Have you tried enabling some debug
>> options?
>>
> 
> I'm using the serial console to log the kernel messages and ssh to run
> the command. Using purely the serial console has the same results.

The main point was to avoid redirecting standard error to /dev/null to
see any application error message. Doing this on the serial console may
be a better idea that on ssh, because it means you are less likely to
miss a message that would be sent just prior to the system dying.

> 
> Is this the context switch?: "CONFIG_XENO_HW_UNLOCKED_SWITCH=y"

Yes, please try to disable it if you have it enabled.

> 
> I will try playing again with the debug options and see if I can get
> something useful.
> 
>> Also note that xeno-regression-test puts the system under a lot of
>> stress, so it may happen that there is no output for some time (several
>> minutes), normally the test should stop by itself if there is no output
>> for something like 30 minutes. So, I would recommend not redirecting
>> xeno-test output to see if there is any error before the lockup, and
>> when you see the lockup, leave the system for 30 minutes to see if it
>> does not restart or if xeno-regression-test can exit gracefully.
>>
> 
> This is a total lockup. There's a heartbeat led that dies when it occurs.

Well the heartbeat led does not prove anything: some Linux kernel
activity can very well prevent it from being toggled. Say if for
instance it is toggled by a thread and the activity that hogs the kernel
is a softirq that never ends.

> 
> Attached is one error log that I had captured previously and this one
> had the CONFIG_CPU_IDLE enabled. I've lost track on which kernel this
> trace came from but maybe the error looks familiar.

This trace misses an important information: the reason for the error.
So, please capture the serial console to a file, and post the complete
file, from boot up to the error.

Anyway, you did not answered my question: did you try to leave the
system on for say 30 minutes of 1 hour after the lockup to see if it
does not recover?


-- 
                                                                Gilles.

