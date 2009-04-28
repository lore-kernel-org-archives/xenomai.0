Message-ID: <49F6F9D3.8060503@domain.hid>
Date: Tue, 28 Apr 2009 21:42:59 +0900
From: "Kim, Hee-young" <plugdboy@domain.hid>
MIME-Version: 1.0
References: <49F65852.6090401@domain.hid> <49F69377.7090005@domain.hid>
	<49F6AAAE.9090200@domain.hid>
In-Reply-To: <49F6AAAE.9090200@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Does not exist "xnpod_start_timer" on Xenomai
	2.4.7 ???
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
Cc: xenomai@xenomai.org, rtfirewire-devel@domain.hid

Thanks Gilles Chanteperdrix and Jan Kiszka for your help.

If I success to patch rt-firewire I'll post it on site. But, I can't 
guarantee when it finish.
I've just subscribed to rt-firewire mailing list. BTW, is it alive?

Kim, Hee-young.

Jan Kiszka ? ?:
> Gilles Chanteperdrix wrote:
>   
>> Kim, Hee-young wrote:
>>     
>>> Hi,
>>>
>>> I'm trying to patch "rt-firewire 0.1" for lastest xenomai patched
>>> kernel. I fixed some functions to altered one. But, xnpod_start_timer(),
>>> xnpod_stop_timer() and relates do not exist in pod.c.
>>> and try to find same function name in Xenomai but there are no exists.
>>> Where can I find these functions? or How to solve it?
>>>       
>> The replacement is xnpod_enable_timesource, but you should not need to
>> call it explicitely, especially not in a driver. So, you should rather
>> remove these calls.
>>
>> BTW, any plan to publish the modified code ?
>>
>>     
>
> In any case, always use latest SVN as basis (it doesn't include that
> service anymore, BTW) and put the rtfirewire mailing list on CC.
>
> Jan
>
>   

