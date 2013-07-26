Message-ID: <51F2C687.90303@xenomai.org>
Date: Fri, 26 Jul 2013 20:57:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <04a701ce864f$91047590$b30d60b0$@z9.com>
	<51F182E4.70907@xenomai.org>
	<00d101ce8a1b$32cfeac0$986fc040$@z9.com>
In-Reply-To: <00d101ce8a1b$32cfeac0$986fc040$@z9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] cannot open switchtest device ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Pontis <gpontis@z9.com>
Cc: xenomai@xenomai.org

On 07/26/2013 06:14 PM, George Pontis wrote:

>> -----Original Message-----
>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
>> Sent: Thursday, July 25, 2013 12:56 PM
>> To: George Pontis
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai] cannot open switchtest device ?
>>
>> On 07/21/2013 10:19 PM, George Pontis wrote:
>>
>>> I find a problem trying to run xeno-test when it goes to open the switchtest
>>> device. Before this post I searched the web and found a thread started by
>>> "raespi".
>>> We have a similar situation in which we are both using buildroot, but I'm
>>> not sure that the underlying cause is the same. I am building a kernel for
>>> 3.8.13 using
>>> the patches from git, and also the current git xenomai. ( Current as of a
>>> month ago ). The target is an custom board based on the iMX53.
>>>
>>> To narrow the source of the problem, I modified switchtest.c to report on
>>> any case where the open() returns a negative number. I also made a
>> temporary
>>> patch
>>> to not prepend the name with "/dev/". I might add that I'm using a new RTDM
>>> driver named fpga_rtdm that can be opened and access successfully.
>>> Here's what happens:
>>
>>
>> This may look like a stupid suggestion, but that is the only explanation
>> I see: you are probably using glibc's open instead of xenomai's open.
>> This may happen for instance if you are compiling xenomai libraries
>> statically and switchtest Makefile does not use the "wrap-link.sh" script.
>> --
>>                                                                   Gilles.
>
> Not stupid, that was a useful suggestion. Both are dynamically linked, and I'm actually using
> uClibc for this embedded system.
>
> I tried to open the switchtest device from my application and it was successful.
> One difference was that my application was opening these with a call to rt_dev_open(),
> while the switchtest.c file used open(). Also, when building switchtest the open() is
> resolved with open64() due to selecting large file support.
>
> A quick mod of the switchtest code to use rt_dev_open() instead of open() would not build
> without more effort.


Ah, thanks for digging. We simply need to implement __wrap_open64 and 
add open64 to the long list of services we wrap.

Regards.

-- 
                                                                 Gilles.

