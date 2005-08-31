Message-ID: <20050831150918.2pfrwuzd6o88o0kc@domain.hid>
Date: Wed, 31 Aug 2005 15:09:18 +0200
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [Adeos-main] PATCH: adeos handle_event losing events
References: <43159A7C.9020008@domain.hid>
	<20050831143501.8lgyxa05c4o0wgco@domain.hid>
In-Reply-To: <20050831143501.8lgyxa05c4o0wgco@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>, adeos-main@gna.org, rtai-dev@domain.hid

Quoting Philippe Gerum <rpm@xenomai.org>:

> Quoting Heikki Lindholm <holindho@domain.hid>:
>
>> Hello,
>>
>> While processing __adeos_handle_event enables interrupts for the 
>> ectual event handler periods. Interrupts might happen then and only 
>> logged for domains lower than the current domain in the 
>> __adeos_handle_event loop. The logged irqs would normally get 
>> replayed at the next real interrupt if the domain that caused the 
>> event was lower than the ones the interrupts were logged in or if it 
>> wasn't lower, at the next suspend_domain. On powersave-enabled ppc 
>> machines this might cause a chain where the cpu goes napping and 
>> wakes at the next timer tick which, having possibly been missed at 
>> *handle_event, happens after maximum decrementer period (~minutes).
>>
>> The following patch seems to help in the described case, but I've 
>> also observed another case where interrupt seems to get dropped 
>> altogether. Performance didn't seem to suffer much from the patch. 
>> If anything, the latency/cruncher results got better. This is for 
>> the non-threaded domains case.
>
> Good spot, thanks. I'd also suggest a different implementation to solve this,
> still in adeos_handle_event() though:
>
> - you only need to sync the next domain when it does not handle the current
> event; if it does, then it would suspend calling adeos_suspend_domain() when
> the event is processed, hence switching to the next domain down the pipeline
> that has IRQs to process anyway. Additionally, I don't see how notfirst goes
> non-zero in this patch, and why we'd need to make some exception case for the
> root domain (i.e. you may have domains below it down the pipeline).
>

Actually, what's above is true for the threaded case, but we do need to sync
both cases for the !threaded one.

> - in the !threaded case, calling __adeos_switch_to() instead of changing the
> domain descriptor by hand then syncing the stage would be better, since it
> would perform all the additional housekeeping chores, like calling the switch
> hook and resetting the current descriptor pointer.
>
>>
>> -- Heikki Lindholm
>>
>
>
>
>




