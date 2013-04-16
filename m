Message-ID: <516D933F.8060502@xenomai.org>
Date: Tue, 16 Apr 2013 20:06:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <516BA4E9.3070201@xenomai.org>
	<90FBAEE5-D70C-4563-B9DB-776D6E4E7FA9@kabelmail.de>
In-Reply-To: <90FBAEE5-D70C-4563-B9DB-776D6E4E7FA9@kabelmail.de>
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

On 04/16/2013 12:26 PM, Stephan Kappertz wrote:

> Am 15.04.2013 um 08:57 schrieb Gilles Chanteperdrix:
> 
>>
>> Hi Stephan, Paul,
>>
>> we have a problem with the patches for Raspberry and BeagleBone: they
>> are based on the 3.2.21 patch, which we know is broken. So, we can not
>> really ship the next version of Xenomai with these patches.
>>
>> There are two ways we could keep patches for these machines:
>> - you could send patches for 3.4 or 3.5, or even 3.8
>> - we could backport the fixes to 3.2, but as already discussed on this
>> list, this would cost some time to re-validate the 3.2 patch on all
>> architectures. However, if you do the backport, validate it on your
>> side, I could validate the result on my test boards, and we would
>> release a new version of the patch for 3.2 only for the ARM architecture.
>>
>> Regards.
>>
>> -- 
>>                                                                Gilles.
>>
> 
> Hi Gilles,
> 
> there's a 3.8.7 branch available for beagleBone at https://github.com/beagleboard/kernel/tree/3.8.
> 
> I can look into updating the beagleBone patch for that repository. Where do I find the latest ipipe patch for 3.8 on ARM?


ipipe-gch repository, for-core-3.8 branch.

-- 
                                                                Gilles.

