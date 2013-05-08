Message-ID: <518A98F5.30000@xenomai.org>
Date: Wed, 08 May 2013 20:27:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <516BA4E9.3070201@xenomai.org>
	<90FBAEE5-D70C-4563-B9DB-776D6E4E7FA9@kabelmail.de>
	<516D933F.8060502@xenomai.org>
	<F484004F-9908-449C-A4DA-CB73E47EE764@kabelmail.de>
	<5182B1B5.1000107@xenomai.org>
	<12E434B4-4F26-44AC-8D50-2CF70B5089E1@kabelmail.de>
	<5183FFB3.1000006@xenomai.org>
	<8D9AB79C-4A66-4511-B08B-ACF825FED1BF@kabelmail.de>
In-Reply-To: <8D9AB79C-4A66-4511-B08B-ACF825FED1BF@kabelmail.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Raspberry and Beaglebone patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stephan Kappertz <stephan.kappertz@kabelmail.de>
Cc: Xenomai <xenomai@xenomai.org>

On 05/03/2013 10:41 PM, Stephan Kappertz wrote:

> 
> Am 03.05.2013 um 20:19 schrieb Gilles Chanteperdrix:
> 
>> On 05/03/2013 04:28 PM, Stephan Kappertz wrote:
>> 
>>> 
>>> Am 02.05.2013 um 20:34 schrieb Gilles Chanteperdrix:
>>> 
>>>> On 05/02/2013 02:19 PM, Stephan Kappertz wrote:
>>>> 
>>>>> 
>>>>> Am 16.04.2013 um 20:06 schrieb Gilles Chanteperdrix:
>>>>> 
>>>>>> On 04/16/2013 12:26 PM, Stephan Kappertz wrote:
>>>>>> 
>>>>>>> Am 15.04.2013 um 08:57 schrieb Gilles Chanteperdrix:
>>>>>>> 
>>>>>>>> 
>>>>>>>> Hi Stephan, Paul,
>>>>>>>> 
>>>>>>>> we have a problem with the patches for Raspberry and 
>>>>>>>> BeagleBone: they are based on the 3.2.21 patch, which
>>>>>>>> we know is broken. So, we can not really ship the next
>>>>>>>> version of Xenomai with these patches.
>>>>>>>> 
>>>>>>>> There are two ways we could keep patches for these 
>>>>>>>> machines: - you could send patches for 3.4 or 3.5, or
>>>>>>>> even 3.8 - we could backport the fixes to 3.2, but as
>>>>>>>> already discussed on this list, this would cost some
>>>>>>>> time to re-validate the 3.2 patch on all architectures.
>>>>>>>> However, if you do the backport, validate it on your
>>>>>>>> side, I could validate the result on my test boards,
>>>>>>>> and we would release a new version of the patch for 3.2
>>>>>>>> only for the ARM architecture.
>>>>>>>> 
>>>>>>>> Regards.
>>>>>>>> 
>>>>>>>> -- Gilles.
>>>>>>>> 
>>>>>>> 
>>>>>>> Hi Gilles,
>>>>>>> 
>>>>>>> there's a 3.8.7 branch available for beagleBone at 
>>>>>>> https://github.com/beagleboard/kernel/tree/3.8.
>>>>>>> 
>>>>>>> I can look into updating the beagleBone patch for that 
>>>>>>> repository. Where do I find the latest ipipe patch for
>>>>>>> 3.8 on ARM?
>>>>>> 
>>>>>> 
>>>>>> ipipe-gch repository, for-core-3.8 branch.
>>>>>> 
>>>>>> -- Gilles.
>>>>>> 
>>>>> 
>>>>> Hi Gilles, do you have a script to create the ipipe patch
>>>>> file? Can't find any in the pipe-gch repository.
>>>> 
>>>> 
>>>> It is not yet in the repository, if you want the definitive
>>>> patch, please wait a bit, the patch should be released soon.
>>>> 
>>>> 
>>>> -- Gilles.
>>>> 
>>> 
>>> Hi Gilles,
>>> 
>>> I have created a ipipe post patch for the beagleBone kernel
>>> v3.8.10 found here:
>>> 
>>> https://github.com/RobertCNelson/linux-dev/tree/am33x-v3.8,
>>> branch am33x-v3.8
>>> 
>>> Your pipe-gch repository is based on 3.8 while the upper
>>> repository is at 3.8.10. Thus I had to apply a few minor changes
>>> to the patch file created from your git. Are you going to rebase
>>> the ipipe patch to 3.8.10 or higher before releasing it?
>> 
>> 
>> I do not know, Philippe is going to make the patch, he will decide
>> on which version he rebases.
>> 
>>> If so, the beagleBone patch gets reduced to the post patch
>>> below:
>> 
>> 
>> Ok, several remarks: - can not we put that code in the mainline
>> kernel (meaning, does soc_is_am33xx() exist in the mainline kernel,
>> if it does not exist, can not we add it?) - the coding style for
>> the tsc declaration is bad, braces are not put on separate lines in
>> the Linux kernel coding style; - since the only difference between
>> am33xx and other omaps is OMAP_TIMER_CAPTURE_REG vs
>> OMAP_TIMER_COUNTER_REG, why not put this in a local variable and
>> use it twice?
>> 
>> 
>> -- Gilles.
>> 
> 
> Yes, soc_is_am33xx() is indeed defined in the mainline kernel
> starting from 3.6. So the beagleBone patch can safely be put into the
> mainline ipipe sources.
> 
> I'll fix the coding style and send a new patch. Actually using
> soc_is_am33xx() for the TSC register location decision was an
> unnecessary constraint. The OMAP timer struct has a revision field
> that is 2 for the v2 timer IP. In rev 2, all functional registers are
> offset by OMAP_TIMER_V2_FUNC_OFFSET.


Hi,

any news about this patch?

Regards.

-- 
                                                                Gilles.

