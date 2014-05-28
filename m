Message-ID: <538622C8.6000906@xenomai.org>
Date: Wed, 28 May 2014 19:54:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAO0fa7ZiofUS3wsbx89uYsnt6icuv+DVcDbiEfVyG5DUeprj2w@mail.gmail.com>	<5382E8B1.8070402@xenomai.org>	<CAO0fa7YQ0TxiAhbmFmt+41o+rugoLXKjXxtHygpthNOiu8gd9w@mail.gmail.com>	<5383406C.4070902@xenomai.org>	<CAO0fa7YavfJxxLW6h3Wm8CRmS2+yb9Uhv5RDfsv04+pcpvorFg@mail.gmail.com>	<CAO0fa7byLgJQ2_sLDtJLmjsf=oh2NF7k37qnWWxmwhZW6N1ksw@mail.gmail.com>
 <CAO0fa7YGSCmPducStbh7sM=HJtPYq86iO1e2ZAaKyjUjzPMEUA@mail.gmail.com>
 <5385F190.7050303@xenomai.org>
 <C528C59E-AFE8-4810-AC6F-E58A2C1DA47D@mah.priv.at>
In-Reply-To: <C528C59E-AFE8-4810-AC6F-E58A2C1DA47D@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] gdb / threads on beaglebone black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>, xenomai@xenomai.org

On 05/28/2014 04:45 PM, Michael Haberler wrote:
> 
> Am 28.05.2014 um 16:24 schrieb Philippe Gerum <rpm@xenomai.org>:
> 
>> On 05/28/2014 04:08 PM, Drew wrote:
>>> Yes, my guess was correct.
>>> The do - while loop in trampoline is exiting with error -38 (-ENOSYS?)
>>> If I change line 110 of skins/native/task.c:
>>>
>>> - while(err == -EINTR)
>>> + while(err == -EINTR || err == -ENOSYS)
>>>
>>> then I'm able to single-step in gdb. :-)
>>>
>>> Is my change a hack, or is it the correct thing to do?
> 
> I reproduced the behavior on an slightlier earlier kernel version than Drew used:
> 
> config: http://static.mah.priv.at/public/config.txt
> dmesg: http://static.mah.priv.at/public/dmesg.txt
> 
> $ cat /proc/ipipe/version
> 3
> $ cat /proc/xenomai/version
> 2.6.3
> 
>>
>> No Xenomai call should ever return ENOSYS. Something is definitely wrong with the current setup.
>>
>>> It looks like rt_task_trampoline is only expecting EINTR to occur. Is
>>> some other bug causing ENOSYS?
>>
>> This means that the 'barrier' syscall did not get to Xenomai core, but was rejected as undefined.
>>
>> Could any of the hints mentioned here apply in your case?
>> http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#_any_xenomai_service_fails_with_code_38_enosys
> 
> as above, I'm not seeing a violation of any of those conditions?

Is there no message printed on the kernel console which would explain
why this syscall gets rejected?


-- 
                                                                Gilles.

