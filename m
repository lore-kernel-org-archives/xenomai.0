Message-ID: <54DF54CF.9060506@web.de>
Date: Sat, 14 Feb 2015 14:59:43 +0100
From: Jochen Behnke <JK.Behnke@web.de>
MIME-Version: 1.0
References: <trinity-718930e5-2f32-4c34-98da-532709fb9429-1423747391055@3capp-webde-bs58>
 <20150212184337.GA10928@hermes.click-hack.org>
 <trinity-8d5f476b-ccb9-4fa2-93e5-eea8f12f5c68-1423813608538@3capp-webde-bs11>
 <20150213185705.GE10928@hermes.click-hack.org>
In-Reply-To: <20150213185705.GE10928@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] application start is slower with xenomai 2.6.4 than
 2.4.10
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> On Fri, Feb 13, 2015 at 08:46:48AM +0100, JK.Behnke@web.de wrote:
>> Hello Gilles,
>>
>> thanks for your quick response.
>>
>>>> Hello,
>>>>
>>>> I noticed that running the same xenomai application against xenomai 2.6.4
>>>> is significantly slower on start up, than it was with xenomai 2.4.10.
>>>> Calling my xenomai application 100 times by a bash script takes about
>>>> 1 sec on xenomai 2.4.10. On xenomai 2.6.4 however it takes about
>>>> 20 secs.
>>>
>>> On what hardware? What architecture?
>> It's a Kontron nano-ETX module with an Intel Atom Z510 1,1 GHz.
>> Mass storage is a 16 GB SSD attached via SATA.
>>
>>
>>>> Even if I strip down my application to the absolut minimum of xenomai
>>>> calls like this
>>>
>>> As you may know, everything is loaded on demand, so the application
>>> start time does not depend on the application size.
>>
>> I didn't mean the application size. I just wanted to rule out other
>> xenomai calls like rt_dev_open, rt_dev_read, etc. to be responsible for
>> the additional delay.
>>
>>>>
>>>> main()
>>>> {
>>>>    mlockall(...);
>>>>    rt_task_shadow(...);
>>>> }
>>>>
>>>> I get the same behaviour.
>>>>
>>>> I have tested this on the same hardware (x86, atom). The only difference
>>>> is the Linux kernel (2.6.30.8 vs 3.14.17) version and the xenomai version
>>>> (2.4.10 vs 2.6.4).
>>>>
>>>> I once mistakenly linked my xenomai 2.4.10 application against libxenomai
>>>> and also got the same behaviour (slower startup).
>>>> So I suspect this has something to do with libxenomai I need to link
>>>> against, when building xenomai applications using xenomai 2.6.4.
>>>>
>>>> Is there a kind of additional setup behind the scenes in xenomai 2.6.4?
>>>
>>> The code source is available, so you can check what happens at
>>> startup and even time it. I am afraid people who care about start
>>> time with Xenomai are not numerous.
>>> --
>>> Gilles.
>>
>> I have no experience with xenomai sources.
>> Can you please point me out at which source file(s) to look at.
>> How can I debug the startup timing?
>
> First note that by running application in a loop you test not only
> the startup time, but also the shutdown type, and this one contains
> at least a nanosleep to flush the per-thread stdio buffers.
>
> To find everything which is executed before main, you can grep the
> sources for __attribute__((constructor))
>

Thank you for the hints.
I' ll have a look at it.

Regards
Jochen

