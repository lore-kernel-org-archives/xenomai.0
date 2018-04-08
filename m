References: <20180402162629.Horde.aGvVeyDe3lwwFExaCtLehqi@webmail.uam.es>
 <CALLqZ8TSMOAt0hVKf9UWBVwp4t2LWKkLYOjAWyhywLHAc5oFRg@mail.gmail.com>
 <d5181033-d020-34bb-8b1b-8a261c885f75@xenomai.org>
 <20180403122123.Horde.D2Qo7ce4c1LHdQcBYRZNBmd@webmail.uam.es>
 <53039d03-c118-3c20-e7cd-eefc264919d7@xenomai.org>
 <20180405152518.Horde.-CDL8q6su7PhMYoQTU0iWhp@webmail.uam.es>
 <CALLqZ8RvHzjMnZWbLhRzc1nRFA2t9XJWf8OghfU7ivXYGeDUfg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1c628d16-62c7-bcb5-fe41-2cc9c0a5ebf6@xenomai.org>
Date: Sun, 8 Apr 2018 18:18:48 +0200
MIME-Version: 1.0
In-Reply-To: <CALLqZ8RvHzjMnZWbLhRzc1nRFA2t9XJWf8OghfU7ivXYGeDUfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Context switching with POSIX skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, rodrigo.amaducci@uam.es
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/06/2018 04:00 PM, Greg Gallagher wrote:
> I'll look into it this weekend and see if I can get the demo running
> on Zynq or one of my boards.
> 
> On Thu, Apr 5, 2018 at 9:25 AM,  <rodrigo.amaducci@uam.es> wrote:
>> Quoting Philippe Gerum <rpm@xenomai.org>:
>>>
>>>
>>> You need to enable the ipc/xddp driver (CONFIG_XENO_DRIVERS_RTIPC_XDDP)
>>> in your kernel.
>>>
>>> --
>>> Philippe.
>>
>>
>> I have recompiled my kernel a couple of times activating all the RTIPC
>> drivers but I'm still getting the same error when running xddp-echo.
>>
>> Rodrigo
>>
>>
>>
>>
>>
> 

FWIW, I can confirm that all the RTIPC demos from the stable-3.0.x and
-next branches do work, provided the driver is enabled in the kernel
configuration - and modprobed if modular before the tests are started.

Tested on x86 and some ARM SoC, but since this is purely generic code,
the architecture is very unlikely to have any impact on this issue.

-- 
Philippe.

