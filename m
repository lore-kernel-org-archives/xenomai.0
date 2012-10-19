Message-ID: <508197A5.9060609@nta-inc.net>
Date: Fri, 19 Oct 2012 13:10:45 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <507C93B6.30304@nta-inc.net> <507D0712.9070305@xenomai.org>
	<507F2D28.4090600@nta-inc.net> <507F8477.2070005@xenomai.org>
	<50803AC8.6080604@nta-inc.net> <50803E54.3080602@xenomai.org>
	<50807391.1020602@nta-inc.net> <5080D7B5.1020909@xenomai.org>
In-Reply-To: <5080D7B5.1020909@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Still having problems running Xenomai on an Intel
 X5650 x86_64 machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 10/18/2012 11:31 PM, Gilles Chanteperdrix wrote:
> On 10/18/2012 11:24 PM, Jeff Webb wrote:
>
>> On 10/18/2012 12:37 PM, Gilles Chanteperdrix wrote:
>>> On 10/18/2012 07:22 PM, Jeff Webb wrote:
>>>> On 10/17/2012 11:24 PM, Gilles Chanteperdrix wrote:
>>>>> On 10/18/2012 12:11 AM, Jeff Webb wrote:
>>>>>
>>>>>> On 10/16/2012 02:04 AM, Gilles Chanteperdrix wrote:
>>>>>>> On 10/16/2012 12:52 AM, Jeff Webb wrote:
>>>>>>>
>>>>>>>> I'm back to trying to get Xenomai running on a dual 6-core Intel
>>>>>>>> X5650 desktop machine.  I reported my previous attempts a few
>>>>>>>> months ago:
>>>>>>>>
>>>>>>>> On ubuntu 10.04 with 2.6.38.8:
>>>>>>>> http://www.xenomai.org/pipermail/xenomai/2012-July/000546.html
>>>>>>>>
>>>>>>>> On ubuntu 10.04 with 3.2.21:
>>>>>>>> http://www.xenomai.org/pipermail/xenomai/2012-July/000577.html
>>>>>>>>
>>>>>>>> I am now using ubuntu 12.04 instead of 10.04, and I'm using the
>>>>>>>> xenomai-2.6.git branch.  I am still not having any success.  The
>>>>>>>> kernel boots, but hangs as the GUI login box is coming up.  This
>>>>>>>> is similar to what happened under ubuntu 10.04/3.2.21, but the
>>>>>>>> call trace seems a little different.  I have attached my kernel
>>>>>>>> config and the console output, which was captured via a serial
>>>>>>>> connection.  This exact kernel package seems to run fine (with
>>>>>>>> very limited testing) on a 4-core Intel X9650 desktop machine
>>>>>>>> running the same OS, for what it's worth.  Any help in debugging
>>>>>>>> this would be appreciated.  What's my next step?
>>>>>>>
>>>>>>>
>>>>>>> I am afraid that is another known issue fixed in the 3.4 branch.
>>>>>>> Please try the I-pipe git; git://git.denx.de, branch core-3.4.
>>>>>>>
>>>>>>
>>>>>> Thanks again, Gilles.
>>>>>>
>>>>>> I just rebuilt the kernel using the core-3.4 branch of ipipe.git with
>>>>>> xenomai-2.6.git.  I started with the same kernel config as before and
>>>>>> then disabled a few drivers to get everything to compile without
>>>>>> errors.
>>>>>
>>>>>
>>>>> If you do not need to disable these drivers to compile the kernel
>>>>> without Xenomai, then it is not normal, please be more specific.
>>>>
>>>> I started with a 3.2-series kernel config (posted earlier) that compiled with Xenomai.  I then copied that config over into the ipipe-core-3.4 build directory before running menuconfig.  When I tried to compile the kernel, I encountered some section mismatch errors.  To get those to go away, I ended up disabling the following options:
>>>>
>>>> #  Device Drivers
>>>> #    GPIO Support
>>>> #      Intel EG20T PCH/LAPIS Semiconductor IOH(ML7223/ML7831)...
>>>> #    USB Support
>>>> #      USB Gadget Support
>>>> #    Staging drivers
>>>> #      Data acquisition support (comedi)
>>>>
>>>> It wasn't quite clear to me which comedi module was giving me trouble, so I disabled all of it, although it probably wasn't necessary.  I'm pretty sure that these problems were a result of migrating my kernel config from 3.2 to 3.4, and don't have anything to do with Xenomai.  I did not try to compile a vanilla 3.4 kernel, so I can't be certain.  I apologize for the confusion.  I only mentioned that so you would know that the config was very slightly different from what I posted last time.
>>>>
>>>>>>     The system still crashes, but now it seems to happen several
>>>>>> seconds after the login box has appeared.  The console output is
>>>>>> shown below.
>>>>>
>>>>>
>>>>> This does not look like the same issue, right? As usual, could you
>>>>> disassemble __ipipe_dispatch_irq, or run addr2line for the error address
>>>>> (0xffffffff810ac055)?
>>>>
>>>> It appears to be a different issue.  Since I have a bzImage in my boot directory, I ran:
>>>>
>>>>     addr2line -i -e vmlinux ffffffff810ac055
>>>>
>>>> on the vmlinux file I found in my kernel build directory.  I'm assuming that is the right thing to do.  Here is the result:
>>>>
>>>>      linux-3.4.6-ipipe-core-3.4.git.2012.10.09/include/linux/ipipe.h:342
>>>>      linux-3.4.6-ipipe-core-3.4.git.2012.10.09/kernel/ipipe/core.c:1211
>>>>
>>>> The code looks like this:
>>>>
>>>> ipipe.h:
>>>>
>>>> static inline int ipipe_chained_irq_p(struct irq_desc *desc)
>>>> {
>>>> 	void __ipipe_chained_irq(unsigned irq, struct irq_desc *desc);
>>>>
>>>> -->	return desc->handle_irq == __ipipe_chained_irq;
>>>> }
>>>>
>>>> core.c:
>>>> 	if (unlikely(irq >= NR_IRQS)) {
>>>> 		desc = NULL;
>>>> 		chained_irq = 0;
>>>> 	} else {
>>>> 		desc = irq_to_desc(irq);
>>>> -->		chained_irq = ipipe_chained_irq_p(desc);
>>>> 	}
>>>
>>> Ok, desc can be NULL, so, we should have
>>> chained_irq = desc ? ipipe_chained_irq_p(desc) : 0;
>>>
>>
>> Hooray!  With this change, the system boots and seems to run fine.  I ran a few of the tests in the test suite (latency, etc.), and the results look good at first glance.  We'll see how it all comes out in the end, but things looks rosy at the moment...
>>
>> Thank you very much for your help in fixing this issue.
>>
>> -Jeff
>>
>> index 9898b92..569eafa 100644
>> --- a/kernel/ipipe/core.c
>> +++ b/kernel/ipipe/core.c
>> @@ -1208,7 +1208,7 @@ void __ipipe_dispatch_irq(unsigned int irq, int flags) /* hw interrupts off */
>>                   chained_irq = 0;
>>           } else {
>>                   desc = irq_to_desc(irq);
>> -               chained_irq = ipipe_chained_irq_p(desc);
>> +               chained_irq = desc ? ipipe_chained_irq_p(desc) : 0;
>>           }
>>
>>    #ifdef CONFIG_IPIPE_DEBUG
>
>
> Ok. If you enable CONFIG_IPIPE_DEBUG, you should see a message about a
> spurious interrupt, though.
>

Yes, with CONFIG_IPIPE_DEBUG enabled, I get one instance of this:

kernel: [   35.271218] I-pipe: spurious interrupt 32

What are the implications of this, and how can I figure out what's causing it?

Thanks,

-Jeff



