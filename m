Mime-Version: 1.0 (Apple Message framework v1283)
From: Stephan Kappertz <stephan.kappertz@kabelmail.de>
In-Reply-To: <5182B1B5.1000107@xenomai.org>
Date: Fri, 3 May 2013 16:28:59 +0200
Message-Id: <12E434B4-4F26-44AC-8D50-2CF70B5089E1@kabelmail.de>
References: <516BA4E9.3070201@xenomai.org>
	<90FBAEE5-D70C-4563-B9DB-776D6E4E7FA9@kabelmail.de>
	<516D933F.8060502@xenomai.org>
	<F484004F-9908-449C-A4DA-CB73E47EE764@kabelmail.de>
	<5182B1B5.1000107@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>


Am 02.05.2013 um 20:34 schrieb Gilles Chanteperdrix:

> On 05/02/2013 02:19 PM, Stephan Kappertz wrote:
> 
>> 
>> Am 16.04.2013 um 20:06 schrieb Gilles Chanteperdrix:
>> 
>>> On 04/16/2013 12:26 PM, Stephan Kappertz wrote:
>>> 
>>>> Am 15.04.2013 um 08:57 schrieb Gilles Chanteperdrix:
>>>> 
>>>>> 
>>>>> Hi Stephan, Paul,
>>>>> 
>>>>> we have a problem with the patches for Raspberry and BeagleBone: they
>>>>> are based on the 3.2.21 patch, which we know is broken. So, we can not
>>>>> really ship the next version of Xenomai with these patches.
>>>>> 
>>>>> There are two ways we could keep patches for these machines:
>>>>> - you could send patches for 3.4 or 3.5, or even 3.8
>>>>> - we could backport the fixes to 3.2, but as already discussed on this
>>>>> list, this would cost some time to re-validate the 3.2 patch on all
>>>>> architectures. However, if you do the backport, validate it on your
>>>>> side, I could validate the result on my test boards, and we would
>>>>> release a new version of the patch for 3.2 only for the ARM architecture.
>>>>> 
>>>>> Regards.
>>>>> 
>>>>> -- 
>>>>>                                                              Gilles.
>>>>> 
>>>> 
>>>> Hi Gilles,
>>>> 
>>>> there's a 3.8.7 branch available for beagleBone at https://github.com/beagleboard/kernel/tree/3.8.
>>>> 
>>>> I can look into updating the beagleBone patch for that repository. Where do I find the latest ipipe patch for 3.8 on ARM?
>>> 
>>> 
>>> ipipe-gch repository, for-core-3.8 branch.
>>> 
>>> -- 
>>>                                                               Gilles.
>>> 
>> 
>> Hi Gilles, do you have a script to create the ipipe patch file? Can't find any in the pipe-gch repository.
> 
> 
> It is not yet in the repository, if you want the definitive patch,
> please wait a bit, the patch should be released soon.
> 
> 
> -- 
>                                                                Gilles.
> 

Hi Gilles,

I have created a ipipe post patch for the beagleBone kernel v3.8.10 found here:

https://github.com/RobertCNelson/linux-dev/tree/am33x-v3.8, branch am33x-v3.8

Your pipe-gch repository is based on 3.8 while the upper repository is at 3.8.10. Thus I had to apply a few minor changes to the patch file created from your git. Are you going to rebase the ipipe patch to 3.8.10 or higher before releasing it? If so, the beagleBone patch gets reduced to the post patch below:

- Stephan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: post.patch
Type: application/octet-stream
Size: 1483 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130503/47580d87/attachment.obj>
-------------- next part --------------



