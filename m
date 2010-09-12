Message-ID: <aab9b54738103bc69a5b95bab1eb1627.squirrel@domain.hid>
In-Reply-To: <4C8C9525.1060101@domain.hid>
References: <7301cc886b22b37fcbc8cda61c515d07.squirrel@domain.hid>
	<4C8C9525.1060101@domain.hid>
Date: Sun, 12 Sep 2010 08:42:55 -0500 (CDT)
From: "Travis Stratman" <tstratman@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Bottom half task scheduling
Reply-To: tstratman@domain.hid
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


> Simply create the RTDM task(s) in advance. Creating tasks on demand and
> in IRQ context would be crazy.

This is what I have confusion about. After creating a non-cyclic task with rtdm_task_init(), how
do I restart the task in the interrupt handler? Is there a way to do this using
rtdm_task_set_period() or some other task function or do I need to have the task wait on an event
and wake it back up by signaling the event from the ISR?

>
> At this chance, also start thinking about what priorities you want to
> assign to them (typically the harder part of the design).
>
>>
>> Can anyone point me to some documentation or example that covers this? Any
>> pointers would be appreciated.
>
> RTnet uses RTDM tasks quite heavily. But its code base is large, and not
> all usages are really good examples anymore.

Thanks, I will take a look at the RTnet source with that in mind.

>
> Jan
>
>

Thanks,

TAS



