Message-ID: <4EB6DA0E.9070802@domain.hid>
Date: Sun, 06 Nov 2011 20:03:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4EB6CA3B.1040608@domain.hid>	<4EB6CB8A.2020303@domain.hid>	<4EB6CDB0.6070306@domain.hid>	<4EB6D11A.6070008@domain.hid>
	<4EB6D2A4.2020102@domain.hid> <4EB6D941.7080206@domain.hid>
In-Reply-To: <4EB6D941.7080206@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.6.0 - kernel seg faults on AT91
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: at91_enthus <nwromania@domain.hid>
Cc: xenomai@xenomai.org

On 11/06/2011 08:00 PM, at91_enthus wrote:
> On 11/06/2011 12:32 PM, Gilles Chanteperdrix wrote:
>> On 11/06/2011 07:25 PM, at91_enthus wrote:
>>> On 11/06/2011 12:10 PM, at91_enthus wrote:
>>>> On 11/06/2011 12:01 PM, Gilles Chanteperdrix wrote:
>>>>> On 11/06/2011 06:56 PM, at91_enthus wrote:
>>>>>> Hi.
>>>>>>
>>>>>> I gave Xenomai 2.6.0 a try and installed a newly patched kernel on my
>>>>>> AT91SAM9G20 board.
>>>>>>
>>>>>> Here is my setup:
>>>>>>
>>>>>> proc:   AT91SAM9G20
>>>>>> kernel: 2.6.35.9
>>>>>> OS: embedded Debian Squeeze
>>>>>>
>>>>>> The board boots fine up to stage 2 (user terminal). Sometimes, I am able
>>>>>> to get a login terminal, despite seg fault messages.
>>>>>>
>>>>>> A similar behavior occurs in a Xenomai capable 2.6.37 kernel, only
>>>>>> without the fault messages. In this case the board simply freezes.
>>>>>>
>>>>>> I included the files (.config and fault messages) in the attachments.
>>>>>>
>>>>> You enabled CONFIG_FCSE_GUARANTEED, I do not think Debian squeeze can
>>>>> boot with that, you need a real embedded filesystem, or use
>>>>> CONFIG_FCSE_BEST_EFFORT.
>>>>>
>>>>>
>>>> Since I've started looking in to Xenomai, I have been using FCSE
>>>> "guaranteed" and "best efort"  along with both Debian Squeeze and Lenny
>>>> (Xenomai 2.5 series) without any issues.
>>>>
>>>> I'll change the FCSE setting to see if I get a different behavior.
>>>>
>>>> Regards.
>>> I put the results for CONFIG_FCSE_BEST_EFFORT in the attachment.
>> Unusable. To make it usable, the following options are lacking:
>> CONFIG_FCSE_MESSAGES
> 
>> CONFIG_FRAME_POINTER
> 
> I couldn't find this option.

You need to disable STACK_UNWIND. Without it, some stack traces are
unreadable such as the one you keep sending.

-- 
                                                                Gilles.

