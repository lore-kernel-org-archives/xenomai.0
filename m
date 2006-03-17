Message-ID: <441AE047.6020505@domain.hid>
Date: Fri, 17 Mar 2006 17:13:59 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: FW: [Xenomai-help] Xenomai thread runtime statistics
References: <067C9A1F6AFEB643895EA4513E116884178FC4@domain.hid>
	<441ADC6B.5010909@domain.hid> <441ADFAA.9040602@domain.hid>
In-Reply-To: <441ADFAA.9040602@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: xenomai@xenomai.org, "Moser, Dan" <DMoser@domain.hid>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Moser, Dan wrote:
>>
>>>Hi,
>>>
>>>I am still searching for ways (hopefully via some API(s)) to get Xenomai
>>>run-time thread execution info (my original post is below).
>>>
>>>Being a newbie, I apologize if the answer "should be obvious".  I am
>>>still getting up to speed with both Linux and Xenomai.
>>>
>>>Is there a better list on which I should post this question?
>>>
>>
>>This question is perfectly relevant to this list, the thing is that
>>there's no simple, built-in way of getting execution stats for real-time
>>threads yet. The best way to find out the execution time of your work
>>cycle would be to measure it using the high precision clock information.
> 
> 
> Hmm, wouldn't it be feasible to add such statistics to I-pipe level? I'm
> thinking of something like time spent in domain X, Y, Z vs. the overall
> runtime, preferably converted to percentage usage.
> 

This would be nice, but only part of the issue, since you might have several 
real-time context switches occurring in a single Xenomai domain activation.

> Jan
> 


-- 

Philippe.

