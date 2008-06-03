Message-ID: <48457584.3040705@domain.hid>
Date: Tue, 03 Jun 2008 18:47:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18504269.1212502025901.JavaMail.ngmail@domain.hid>
	<20080603142947.115490@domain.hid>
In-Reply-To: <20080603142947.115490@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] TSCs synchron on multi-core CPUs?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Reichert <Karl-Trampe@domain.hid>, "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

Karl Reichert wrote:
>> Hi everybody,
>>
>> I have a question concerning the time stamp counters of the Intel
>> core2duo/quad CPUs.
>> They will be used e.g. with the Xenomai native skin call rt_time_tsc which
>> ends up in
>> an assembler statement "rdtsc".
>> My question is now:
>> Are the values of TSC synchron with dual/quad core CPUs? Or is there a
>> possible drift between
>> the CPUs?
>> Background of the question is:
>> I want to measure the time of a event that occurs within one task.
>> A second event is checked in another task on a different core. The time
>> difference between the
>> events has to be checked.
>> Can this be done precisely with rdtsc() or is a mechanism required that
>> uses the TSC of exactly one 
>> core?
>>
>> Thanks for all hints on that question!
>>
>> Regards
>>
>> Mathias
> 
> Hi Mathias,
> 
> TSC of the cores may differ: http://en.wikipedia.org/wiki/Time_Stamp_Counter

And if they do on your box, clocktest from the testsuite can tell you.

Note that Xenomai currently relies on TSC being synchronized, or that
you switch to a TSC-less CPU type in your kernel config. Once this
becomes and actual problem for a use case, one may consider adding HPET
as clocksource for Xenomai. So far this wasn't the case.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

