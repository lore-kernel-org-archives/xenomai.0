Message-ID: <43E70816.4030803@domain.hid>
Date: Mon, 06 Feb 2006 09:25:58 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] ... the rt-preempt patch once been in fusion
References: <43E668EF.4090306@domain.hid> <43E6861E.3000400@domain.hid>
	<43E68D74.4000903@domain.hid>
In-Reply-To: <43E68D74.4000903@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

Hannes Mayer wrote:
> Ciao Philippe!
> 
> Philippe Gerum wrote:
> [...]
> 
>> Clearly not, it is still on the project's agenda, but PREEMPT_RT has 
>> been too much of a moving target recently, not to speak of the vanilla 
>> 2.6 kernel itself. 
> 
> 
> Recently ? As for Kernel 2.6 there has always been too much
> development for a stable release IMO, so I still prefer 2.4,
> but that's a solely personal opinion. On the other hand, 2.6
> has been quite stable for me (desktop and devel-stress-testing).
> 

I've not talked about instability for 2.6, but rather significant changes in some 
low-level layers. Incidentally, some of them were triggered by portion of the 
PREEMPT_RT infrastructure leaking to the vanilla kernel. Unfortunately, this 
sometimes causes issues you have to deal with when adapting Adeos to each new release.

>> This combo cannot be done overnight, 
> 
> 
> I was not complaining - just curious :-)
> 
>> This work is likely going to start by a test campaign evaluating 
>> PREEMPT_RT's and Xeno's nucleus performances in a series of simple and 
>> relevant test cases over different ranges of platforms, so that we could 
> 
> 
> Testing ?
> FWIW, I've just completed another page about the vanilla vs.
> preempt_rt thing:
> http://www.captain.at/howto-linux-real-time-patch.php
> If you have the one or another additional stress test, I'd be more
> than happy to add it to the page.
> 

Ack. Thanks.

> Thanks and best regards,
> Hannes.
> 


-- 

Philippe.

