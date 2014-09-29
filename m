Message-ID: <542949C1.80507@xenomai.org>
Date: Mon, 29 Sep 2014 14:00:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CALe7ZU3shAd1y2yWjEgnSJjHkVOmJ5o5bfd3P+Xpm04+oNMhdg@mail.gmail.com>
 <54284361.3080403@xenomai.org> <54284A7B.90803@xenomai.org>
 <CALe7ZU0PyJAu4dhC4_EQ0UMQQdCXvPSth4sWnxKSXz_ZdiDV6g@mail.gmail.com>
In-Reply-To: <CALe7ZU0PyJAu4dhC4_EQ0UMQQdCXvPSth4sWnxKSXz_ZdiDV6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] passing SMI parameter in kernel command line
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JAY KOTHARI <jaikothari10@gmail.com>, xenomai <xenomai@xenomai.org>

On 09/29/2014 05:55 AM, JAY KOTHARI wrote:
> On 9/28/14, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>> On 09/28/2014 07:20 PM, Gilles Chanteperdrix wrote:
>>> On 09/28/2014 05:23 AM, JAY KOTHARI wrote:
>>>> Sir,
>>>>      In troubleshooting guide I have read to pass xenomai.smi=1
>>>> in parameter to kernel command line.
>>>>      I am not able to get kernel command line.
>>>>
>>>> What I tried
>>>> 1)to pass this parameter at boot time.
>>>
>>> Yes, that is what "passing a parameter to kernel command line means".
>>>
>>>> 2)I tried to change parameter in:
>>>>          sys/module/xeno_hal/parameters
>>>
>>> Xenomai 3 does not have a xeno_hal module, so I guess you are not using
>>> Xenomai 2.x, in which case you misread the troubleshooting guide.
>>>
>> Sorry, you are using Xenomai 2.x if you have a xeno_hal module.
>>
>> --
>>                                                                 Gilles.
>>
> Sorry it was my mistake.I am using 2.x and I set xeno_hal.smi=1 as I
> have latency issues. But after passing this parameter in kernel
> command line still I have latency issue.
> When I dmesg I found
>  [    0.479595] Xenomai: SMI workaround failed!
> I think this means my bios is not allowing me to disable SMI source.
> Then how to make my latency low as possible. 

Under what condition does this high latency happens (what else is
running on the system)? What version of Xenomai are you using?
Have you tried disabling individual SMI sources like the documentation says?

I have attached my screen
> shot.

The output of the latency test is plain text, you do not need a
screeshot to show it!

-- 
                                                                Gilles.

