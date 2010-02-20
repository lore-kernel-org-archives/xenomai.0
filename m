Message-ID: <4B8066B3.9070604@domain.hid>
Date: Sat, 20 Feb 2010 23:48:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460DD4DE8B@exchserver.basler.com>
	<181804936ABC2349BE503168465576460DDA2F4F@exchserver.basler.com>
	<181804936ABC2349BE503168465576460DE4CCFC@exchserver.basler.com>
	<4B7FBBB8.1010806@domain.hid>
	<181804936ABC2349BE503168465576460DE4CD0E@exchserver.basler.com>
	<4B803236.4040704@domain.hid>
	<181804936ABC2349BE503168465576460DE4CD12@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460DE4CD12@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Supported I-pipe versions?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

Steve Deiters wrote:
>> -----Original Message-----
>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
>> Sent: Saturday, February 20, 2010 1:04 PM
>> To: Steve Deiters
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai-help] Supported I-pipe versions?
>>
>> Steve Deiters wrote:
>>>> -----Original Message-----
>>>> From: Gilles Chanteperdrix 
>> [mailto:gilles.chanteperdrix@xenomai.org]
>>>> Sent: Saturday, February 20, 2010 4:39 AM
>>>> To: Steve Deiters
>>>> Cc: xenomai@xenomai.org
>>>> Subject: Re: [Xenomai-help] Supported I-pipe versions?
>>>>
>>>> Steve Deiters wrote:
>>>>> Sorry to keep bringing this up, but does anybody know if 
>> there are 
>>>>> compatibility issues with Xenomai 2.5.1, PowerPC Linux
>>>> 2.6.24.6, and
>>>>> the following adeos patch:
>>>>>
>> http://download.gna.org/adeos/patches/v2.6/powerpc/older/adeos-ipipe-
>>>> 2
>>>>> .6
>>>>> .24.6-powerpc-DENX-2.4-03.patch?
>>>> 2.6.24 has a bug which has only be fixed with recent patches. 
>>>> So, even if you use it with an older Xenomai version, and 
>> it seems to 
>>>> work, in fact it does not.
>>>>
>>>> -- 
>>>> 					    Gilles.
>>>>
>>> Could you elaborate on this a bit more?  Is there a bug in 
>> the kernel 
>>> or the I-pipe patch?
>> The I-pipe patch. For details, search the archives, the bug 
>> was announced publicly on this list.
> 
> I will check the list archives.

The commit I am referring to is:

http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=b1947dc2ed54e0f838965918dbb36cf8c8d97fb6

Which took place in the 2.6.29 development branch. In 2.5.1, you should
not see the bug if you are compiling with unlocked context switches.

I made a public announce for the same problem on ARM, but not for powerpc.


-- 
					    Gilles.

