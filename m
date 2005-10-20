Message-ID: <4357CC7D.2030907@domain.hid>
Date: Thu, 20 Oct 2005 18:57:33 +0200
From: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Replacement for rt_save_flags_and_cli
References: <40292.128.93.15.41.1129793705.squirrel@domain.hid>
	<435766D6.6090605@domain.hid> <43576FA9.6010202@domain.hid>
	<4357C11B.3080103@domain.hid> <4357C464.5050206@domain.hid>
In-Reply-To: <4357C464.5050206@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
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
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org


>>Thanks. I just found the following functions in
>>include/nucleus/asm-generic/system.h
>>
>>xnlock_get_irqsave
>>xnlock_put_irqrestore
>>xnlock_clear_irqoff
>>xnlock_clear_irqon
>>
>>They're just #defines to the rthal_ functions.
>>
>>Should I use rthal_* or xnlock_* ?
>>    
>>
>
>I would suggest xnlock_, because this is the higher abstraction layer
>(the nucleus on top of the hal).
>  
>
That's just what I thought.

>But: both primitives are rather low-level. Do you really need that
>"hard" locks? What are you synchronising this way, IRQ handlers with
>tasks, tasks with other tasks?
>  
>
An IRQ handler with a task.

Yeah, I know I could just use rt_intr_disable on that interrupt object,
but for reasons too long to explain, the it is encapsulated in a piece
of code and I'd rather not allow other code to see it. Probably not a
good design but at this stage of the port, I'd like to get it working
under xenomai with as little modifications as possible.

Another place I've used it sometimes is substituting a mutex for very
short pieces of code such as:

cli()
a = b + c;
sti()

It is usually more efficient that using a mutex, and this may be
important in low-end processors with little horsepower.

>>By the way, so far I'm uttery in love with the clean, consistent API of
>>the native skin.
>>    
>>
>
>Would you like to forward this statement to a specific mailing list of a
>formely related project? ;) (only kidding, just had to smile)
>  
>
Man, you just read my mind :-)

I just have to say it:

1- It is amazing that fusion has progressed from conception to its
actual usable, stable state in such a short time.

2- In general, I appreciate good design and robustness over efficiency
and other issues, but IMHO, for real-time systems it must be the number
one priority, which I'm not sure it was in the "formerly related
project". Too many large changes in too many time.

3- The patent issue may not be a priority in the academic world, but it
definitely is for industrial applications.

Nacho.


