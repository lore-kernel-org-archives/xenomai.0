Message-ID: <542BB31F.8070803@xenomai.org>
Date: Wed, 01 Oct 2014 09:54:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACreCVKF=VQuWhaxkAPTOAaDui0aze+Vc4MOq+vby+2eBRx1iA@mail.gmail.com>	<542A945E.9000904@xenomai.org>	<CACreCVK_Xd79uaHpzODKMQHMVrH58KvsKuBQ5kRsOhM++BXT4w@mail.gmail.com>	<542A9F17.7090802@xenomai.org>
 <CACreCV+sFAWEzADAD+q6ZitVLcwuKGq1WguvfaXtoX_P9KkkUQ@mail.gmail.com>
In-Reply-To: <CACreCV+sFAWEzADAD+q6ZitVLcwuKGq1WguvfaXtoX_P9KkkUQ@mail.gmail.com>
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
Cc: xenomai@xenomai.org

On 10/01/2014 01:32 AM, GP Orcullo wrote:
> On Sep 30, 2014 8:16 PM, "Gilles Chanteperdrix" <
> gilles.chanteperdrix@xenomai.org> wrote:
>>
>> On 09/30/2014 02:04 PM, GP Orcullo wrote:
>>> On Sep 30, 2014 7:30 PM, "Gilles Chanteperdrix" <
>>> gilles.chanteperdrix@xenomai.org> wrote:
>>>>
>>>> On 09/30/2014 07:31 AM, GP Orcullo wrote:
>>>>> Hi,
>>>>>
>>>>> Running the switchtest for extended periods (>10 mins) causes the
>>>>> machine to lockup.
>>>>>
>>>>> I'm running a modified xeno-regression-test which contains only the
>>>>> following tests:
>>>>>
>>>>> check_alive /usr/lib/xenomai/testsuite/switchtest
>>>>> check_alive /usr/lib/xenomai/testsuite/switchtest -s 1000
>>>>> check_alive /usr/lib/xenomai/testsuite/latency ${1+"$@"}
>>>>>
>>>>> The script is invoked with the following arguments:
>>>>>
>>>>> nohup sudo ./xeno-regression-test -l
>>>>> "/usr/lib/xenomai/testsuite/dohell -m /media/work 36000" -t 2 >
>>>>> /dev/null & top -d0.5
>>>>>
>>>>> The kernel dumps the OOPS information intermittently so it's difficult
>>>>> to diagnose the issue.
>>>>>
>>>>> Attached is the kernel config and the logfile.
>>>>
>>>> Ok, this is an exynos. Sorry, but I have never seen the patch for
>>>> exynos, so I do not know what is inside. You should direct your
>>>> questions to whoever provided you with this support.
>>>
>>> I'm in the process of porting xenomai to run on exynos.
>>>
>>> The ipipe-core-3.8.13-arm-3.patch applies cleanly to the 3.8.13.11
> kernel
>>> used by the odroid U3 board.
>>>
>>> Attached is the ipipe patch that I've made.
>>>
>>> I was just wondering what would cause switchtest to fail. The error
> that I
>>> can see is that the system is running out of memory and I don't know
>>> exactly what is causing this.
>>
>> Certainly not switchtest as it does not do any memory allocation.
>> However, the dohell script has a loop creating a large file and removing
>> it. So, could you try and run the dohell script with an unpatched kernel
>> and see if you have the error?
>>
> 
> Running dohell on a patched and unpatched kernel doesn't trigger the lockup.
> 
> Running switchtest without dohell works OK.

Is the problem a lockup, or an OOM?


-- 
                                                                Gilles.

