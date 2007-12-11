Message-ID: <475E8DAE.9070405@domain.hid>
Date: Tue, 11 Dec 2007 14:16:30 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
References: <475E76A0.4010007@domain.hid> <475E7CBA.7060300@domain.hid>
	<475E7F84.1040600@domain.hid>
In-Reply-To: <475E7F84.1040600@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: Quoted-Printable
Subject: Re: [Xenomai-help] Application broken 2.3.4 ---> 2.4.0
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

Jan Kiszka escribi=F3:
> That's due to the reworked timer subsystem: Starting timers (like the
> periodic task timer) in the past is reported as error - up to the
> application in this case. One may discuss if this case can be considere=
d
> as an undocumented API change (I haven't re-read the docs in this regar=
d
> yet).
>  =20
I correct myself. The API actually states that the -ETIMEDOUT error code=20
will be return if passed idate is in the past. But that is true for the=20
2.3.x series and for the new 2.4.0 version.

Which means that the true difference between 2.3.x and 2.4.0 is that:

2.3.x: returns -ETIMEDOUT but schedules the task for immediate execution.

2.4.0: returns -ETIMEDOUT and *does not* schedule the task for immediate=20
execution.

The more I think about it the mode I think this is a bug.

I just can't think of a situation in which idate is in the past and it=20
makes sense *not scheduling* the task for immediate execution...





