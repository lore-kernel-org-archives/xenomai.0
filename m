Message-ID: <47177F8C.6080206@domain.hid>
Date: Thu, 18 Oct 2007 17:45:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E016387F8@domain.hid>
	<47175C6C.9060805@domain.hid>
	<E5E9C6CC7DC8844A8DA7A9EFE7B5350E016389E6@domain.hid>
In-Reply-To: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E016389E6@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xnpod_announce_tick when migrating from 2.3 to
 2.4
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas Necker <thomas.necker@domain.hid>
Cc: xenomai@xenomai.org

Thomas Necker wrote:
>>> I'm trying to migrate our software from 2.3 to 2.4 and I'm 
>> struggling 
>>> with the new timebase concept.
>>> Here is how it works in 2.3:
>>> - I have a small kernel module that calls xnpod_stop_timer and then 
>>> xnpod_start_timer with a handling function of my own.
>>> - This handling function does some housekeeping and then calls 
>>> xnpod_announce_tick to trigger the nucleus (and eventually the pSOS 
>>> skin).
>>> This is basically what Philippe suggested about a year ago.
>>> Now, all these functions are gone in 2.4, how's the best way to do 
>>> something similar now?
>>> I couldn't figure out how the new timebase concept can be 
>> used for that.
>>> Thanks in advance.
>> Why do you need to hook into the internals of the timekeeping system?
>> Why not simply register some xntimer with the unmodified 
>> core? Sorry in case that the original thread explains this, 
>> but I don't have it at hand.
> 
> We ported a pretty large pSOS legacy application that just relied on
> that behaviour. And I wanted to make as few changes as possible when
> changing to Xenomai. Not only that I was new to Xenomai, I also didn't
> oversee all the possible side effects in our application.

Thanks, follow-up postings by Philippe pointed me to the requirement of
some skin APIs to have a hook into the tick handler. That's cheaper and
simpler to handle compared to a separate (master-base) timer.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

