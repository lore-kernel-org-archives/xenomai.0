Message-ID: <45EEA69C.3090508@domain.hid>
Date: Wed, 07 Mar 2007 12:48:44 +0100
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
References: <45E4646A.10205@domain.hid> <45E46D67.9030600@domain.hid>
	<45E48543.8030800@domain.hid> <45E48E50.1030502@domain.hid>
In-Reply-To: <45E48E50.1030502@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Re: high latency every 8 seconds
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Theo Veenker wrote:
> 
>>Jan Kiszka wrote:
>>
>>>Theo Veenker wrote:
>>>
>>>>Hi all,
>>>>
>>>>I'm installing xenomai 2.2.5 (kernel 2.6.17.14) on a number of
>>>
>>>When starting new, pick something new, i.e. 2.3 right now. Only if
> 
> you
> 
>>>have good reasons, staying at older versions is recommended.
>>
>>I would love to, but I couldn't get my software running with 2.3.
>>I had to convert (a month ago) my software from RTLinux to Xenomai
>>having only a few days for it. I have a kernel module and an app
>>that talks to it. I use the posix skin. But with 2.3 apparently
>>I had to load posixio and something (forgot) manually, but I just
>>couldn't get these loaded. Since time was running out I decided
>>to stay with 2.2.5 for the time being (unfortunately).
> 
> 
> I do understand. But once your time constraints relaxed a bit, please
> don't forget to post remaining issues here. Maybe they reveal some real
> bug.
> 
> 
>>>>systems (MSI 945P, Intel P4 3Ghz). My kernel runs fine on several
>>>>other/older systems, but on the new systems there is something going
>>>>on every 8 seconds. See output of latency test below. What could
>>>>this be? Is this an SMI effect?
>>>
>>>Is CONFIG_XENO_HW_SMI_WORKAROUND selected? What does the kernel
> 
> output
> 
>>>tell you about if it's working? Do you have an ICH7 chipset on your
>>>board? Would be another reason to update Xenomai (2.3 takes care of
> 
> it,
> 
>>>2.2.x doesn't)... :)
>>>
>>>If this all doesn't help, have a look at this tool:
>>>
>>>http://www.xenomai.org/index.php/I-pipe:Tracer
>>>
>>>In any case, please give a feedback on the outcome.
>>
>>Thanks. I will.


My problems have been solved. First I did Ulich's fix to enable SMI
detect/workaround for ICH7 on 2.2.5. That worked fine. All devices
continue to work and no more SMI induced latencies.

Then I tried Xenomai 2.3.0 again to find out why I couldn't get that
going some time ago. Gilles reported that if I user shared memory then
I should enable shared memory for the posix api. My first thought was,
"duh of course I have enabled that, I'm not stupid". Guess what? I AM
stupid! Now everything works on all systems.

Thanks everybody.

Theo




