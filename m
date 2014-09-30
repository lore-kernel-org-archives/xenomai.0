MIME-Version: 1.0
In-Reply-To: <54295B10.8020907@xenomai.org>
References: <CALe7ZU3shAd1y2yWjEgnSJjHkVOmJ5o5bfd3P+Xpm04+oNMhdg@mail.gmail.com>
 <54284361.3080403@xenomai.org> <54284A7B.90803@xenomai.org>
 <CALe7ZU0PyJAu4dhC4_EQ0UMQQdCXvPSth4sWnxKSXz_ZdiDV6g@mail.gmail.com>
 <542949C1.80507@xenomai.org> <54295B10.8020907@xenomai.org>
Date: Tue, 30 Sep 2014 10:58:55 +0530
Message-ID: <CALe7ZU095W7YKnZvCnRcDY+qhoaiiU2RcUda6ZYPcrLbo3o0jg@mail.gmail.com>
From: JAY KOTHARI <jaikothari10@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] passing SMI parameter in kernel command line
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

I am using 2.6.3 xenomai version. I-pipe version is 3.8.13. Yes I
written as same command as guided in boot section.

But I solved the problem by again configuring the kernel(disabling all
components that create problem in real time system).

Thank you

Jay


On 9/29/14, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On 09/29/2014 02:00 PM, Gilles Chanteperdrix wrote:
>> On 09/29/2014 05:55 AM, JAY KOTHARI wrote:
>>> On 9/28/14, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>> wrote:
>>>> On 09/28/2014 07:20 PM, Gilles Chanteperdrix wrote:
>>>>> On 09/28/2014 05:23 AM, JAY KOTHARI wrote:
>>>>>> Sir,
>>>>>>      In troubleshooting guide I have read to pass xenomai.smi=1
>>>>>> in parameter to kernel command line.
>>>>>>      I am not able to get kernel command line.
>>>>>>
>>>>>> What I tried
>>>>>> 1)to pass this parameter at boot time.
>>>>>
>>>>> Yes, that is what "passing a parameter to kernel command line means".
>>>>>
>>>>>> 2)I tried to change parameter in:
>>>>>>          sys/module/xeno_hal/parameters
>>>>>
>>>>> Xenomai 3 does not have a xeno_hal module, so I guess you are not
>>>>> using
>>>>> Xenomai 2.x, in which case you misread the troubleshooting guide.
>>>>>
>>>> Sorry, you are using Xenomai 2.x if you have a xeno_hal module.
>>>>
>>>> --
>>>>                                                                 Gilles.
>>>>
>>> Sorry it was my mistake.I am using 2.x and I set xeno_hal.smi=1 as I
>>> have latency issues. But after passing this parameter in kernel
>>> command line still I have latency issue.
>>> When I dmesg I found
>>>  [    0.479595] Xenomai: SMI workaround failed!
>>> I think this means my bios is not allowing me to disable SMI source.
>>> Then how to make my latency low as possible.
>>
>> Under what condition does this high latency happens (what else is
>> running on the system)? What version of Xenomai are you using?
>> Have you tried disabling individual SMI sources like the documentation
>> says?
>
> Also, what version of the I-pipe patch do you use?
>
>
> --
>                                                                 Gilles.
>

