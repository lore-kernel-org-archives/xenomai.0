Message-ID: <5118E759.5060604@xenomai.org>
Date: Mon, 11 Feb 2013 13:43:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.0.1359630001.19052.xenomai@xenomai.org>
	<9EFD9D88-FCCB-489A-9DA9-06A8C8AFE8EA@kabelmail.de>
	<5118A3AF.60707@xenomai.org>
	<CFECC321-DA65-4754-8974-94B050F686A8@kabelmail.de>
In-Reply-To: <CFECC321-DA65-4754-8974-94B050F686A8@kabelmail.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Ipipe pre and post patch for AM335x
 beagleBone/	koenkooi branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stephan Kappertz <stephan.kappertz@kabelmail.de>
Cc: xenomai@xenomai.org

On 02/11/2013 09:24 AM, Stephan Kappertz wrote:

> 
> Am 11.02.2013 um 08:54 schrieb Gilles Chanteperdrix:
> 
>> On 01/31/2013 03:17 PM, Stephan Kappertz wrote:
>>
>>>
>>>>> Hi All,
>>>>>
>>>>> sorry for the long delay. As Gilles suggested I have prepared a pre and post patch for ipipe-core-3.2.21-arm-4 and the git repository supporting BeagleBone here: https://github.com/koenkooi/linux/tree/linux-ti33x-psp-3.2.21-r13g%2Bgitr720e07b4c1f687b61b147b31c698cb6816d72f01 . Should I send the patches to the list?
>>>>>
>>>>> - Stephan
>>>>
>>>> I think that you should.
>>>>
>>>> Goran
>>>>
>>>
>>> Here they are.
>>> Usage:
>>>
>>> * clone git repository https://github.com/koenkooi/linux/tree/linux-ti33x-psp-3.2.21-r13g%2Bgitr720e07b4c1f687b61b147b31c698cb6816d72f01
>>
>>
>> I get:
>> fatal:
>> https://github.com/koenkooi/linux/tree/linux-ti33x-psp-3.2.21-r13g%2Bgitr720e07b4c1f687b61b147b31c698cb6816d72f01/info/refs
>> not found: did you run git update-server-info on the server?
>>
>> At this point.
>>
>> -- 
>>                                                                Gilles.
>>
> 
> 
> The git repositore is not mine. It's the Koen Kooi repository I mentioned before.
>  
> To build the kernel with xenomai support I did:
> 
> * git clone git://github.com/koenkooi/linux.git
> 
> * git checkout origin/linux-ti33x-psp-3.2.21-r13g+gitr720e07b4c1f687b61b147b31c698cb6816d72f01 -b linux-3.2.21
> 
> * patch -p1 < ../pre.patch
> 
> * ./xenomai-2.6.2.1/scripts/prepare-kernel.sh --arch=arm --linux=.
> 

> * patch -p1 < ../post.patch

Ok, works for me, I updated the README. As a side note,
prepare-kernel.sh can be called after applying the pre, ipipe and post
patches (this may help if you are using a root filesystem build tool
which calls prepare-kernel.sh as a normal step to build the kernel).

-- 
                                                                Gilles.

