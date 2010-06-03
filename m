Message-ID: <4C07A9F4.7090709@domain.hid>
Date: Thu, 03 Jun 2010 15:11:16 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4C04E8D8.8030101@domain.hid>
	<4C04EDAF.1080800@domain.hid>	<4C051100.7000803@domain.hid>
	<4C051E26.8020102@domain.hid>	<4C053217.5010809@domain.hid>
	<4C053608.3030604@domain.hid> <4C06011A.7020507@domain.hid>
In-Reply-To: <4C06011A.7020507@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Linux kernel 2.6.32.14 and Xenomai 2.5.2 does
	not boot
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/06/10 08:58, Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Daniele Nicolodi wrote:
>>> On 01/06/10 16:50, Jan Kiszka wrote:
>>>> Daniele Nicolodi wrote:
>>>>> On 01/06/10 13:23, Jan Kiszka wrote:
>>>>>> Daniele Nicolodi wrote:
>>>>>>> Hello.
>>>>>>>
>>>>>>> In the process of upgrading my data acquisition system from Xenomai
>>>>>>> 2.5.0 to Xenomai 2.5.2, I also upgraded the kernel from the 2.6.30
>>>>>>> release to 2.6.32.14.
>>>>>> Latest Xenomai is 2.5.3, latest 2.6.32 patch is
>>>>>> adeos-ipipe-2.6.32.13-x86-2.6-04.patch [1]. Make sure you have both.
>>>>> This adeos patch does not apply cleanly to 2.6.32.14 kernel sources.
>>>>> Looks like a hunk in include/linux/modules.h has been applied upstream.
>>>>> However this was easy to merge.
>>>>>
>>>>> Using the latest xenomai and adeos patch however results again in a
>>>>> kernel that does not boot on my hardware. This problem is present since
>>>>> the first time I have been trying to use xenomai on this box, as I wrote
>>>>> in an email to the list on the 17th February early this year, it is thus
>>>>> not a recent regression.
>>>>>
>>>>> Further suggestions?
>>>> Please send an updated .config file.
>>> It is attached.
>>
>> OK, will try to build a test kernel from it later.
> 
> No problems on the target I have at hand.
> 
> Did you already enable a serial console, maybe even an early one, and
> tried to catch the last word of your system (if any)?

I haven't. I'll do as soon as I find more time to work on this.

>> Does you system boot up as soon as you disable CONFIG_IPIPE (and
>> Xenomai, of course)? CONFIG_IPIPE_DEBUG* has no influence either?

I build a kernel with all che CONFIG_IPIPE_DEBUG* options turned on, but
here hasn't been any change in behavior. I think that the issue
manifests itself before the kernel is able to initialize the local console.

A you suggest, an early serial console would kelp my be the only way to
get some informations on this problem.

Thanks. Cheers,
-- 
Daniele

