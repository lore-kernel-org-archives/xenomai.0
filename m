Message-ID: <4378BE29.7070008@domain.hid>
Date: Mon, 14 Nov 2005 17:41:13 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xn_pipe_create [minor]
References: <OFEDEE04A0.61E312DA-ONC12570B9.0044844D-C12570B9.004C5251@domain.hid>
	<4378BB28.8080804@domain.hid> <4378BB6E.2090703@domain.hid>
In-Reply-To: <4378BB6E.2090703@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


>> Using this scheme, user mode programs just need to open()
>> /proc/xenomai/registry/pipes/whatever to access a named pipe, without
>> having to know the minor number.
>>
>> Under these circumstances, it would be *very* useful to have
>> rt_pipe_create choose an unused minor automagically (for example passing
>> -1 as the minor).
>>
>
> Sounds reasonable.

On the heels of our abs/rel discussion, I suggest to use a #define
istead of -1

Will you implement it, or should I give a try?

Nacho.


