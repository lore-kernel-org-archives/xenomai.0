Message-ID: <46B47181.1070901@domain.hid>
Date: Sat, 04 Aug 2007 14:30:57 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46B1A842.1090708@domain.hid>	<1186049556.6611.319.camel@domain.hid>
	<46B1B7DE.3080404@domain.hid>
In-Reply-To: <46B1B7DE.3080404@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Unexpected switch to secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

Johan Borkhuis wrote:
> Philippe Gerum wrote:
>> On Thu, 2007-08-02 at 11:47 +0200, Johan Borkhuis wrote:
>>   
>>> I am experiencing an unexpected switch to secondary mode in a 
>>> rt_timer_tsc2ns call from userspace.
>>>
>>> The following code give a switch:
>>>     SRTIME timeStamp;
>>>     timeStamp = rt_timer_tsc2ns(rt_timer_tsc());
>>>     while((rt_timer_tsc2ns(rt_timer_tsc()) - timeStamp) < (usecs*1000)) {}
>>>
>>> while the following code does not:
>>>     RTIME timeStamp;
>>>     timeStamp = rt_timer_tsc();
>>>     while((rt_timer_tsc() - timeStamp) < (usecs*1000)) {}
>>>
>>> (I know that the second example causes a longer timeout, but this was to 
>>> show the testcase).
>>>
>>> When splitting up the 2nd line in the first example I see that the 
>>> rt_timer_tsc() call does not cause a switch, but the rt_timer_tsc2ns 
>>> does. What am I doing wrong here?
>>>
>>> I am using Xenomai-2.3.2.
>>>
>>>     
>> - Which CPU architecture, and which Adeos patch release are you using?
>>   
> Processor: ppc 85xx, patch 1.5-03, Xenomai 2.3.2
> 
>> - How do you notice the switches, SIGXCPU or /proc/xenomai/stat?
>>   
> SIGXCPU

And what does /proc/xenomai/faults show right before and after the SIGXCPU?

Wolfgang.


