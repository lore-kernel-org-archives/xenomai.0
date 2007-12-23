Message-ID: <1062582.2135.BwBdWwtJFgI=.1198446943.squirrel@domain.hid>
In-Reply-To: <476D615A.7000308@domain.hid>
References: <1078761341.20071030094041@domain.hid>
	<476D615A.7000308@domain.hid>
Date: Sun, 23 Dec 2007 22:55:43 +0100 (CET)
From: Carsten =?iso-8859-1?Q?Spie=DF?= <mail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] how to stop a runaway task
Reply-To: mail@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org, Carsten =?iso-8859-1?Q?Spie=DF?= <mail@domain.hid>

Thanks, i will try it when i=B4m back from holliday.
regrads Carsten
Philippe Gerum wrote:
> Carsten Spie=DF wrote:
>> Hello,
>>
>> i'm running Xenomai 2.3.2 on a PPC target with Linux 2.4.25 kernel.
>> I trying to programm a supervising task, that detects a runaway task
>> and suspend it.
>>
>> My aproach was to make a high priority periodic task to look if
>> the low prio task is running correctly and suspend it when it detects
>> failure.
>> But this approach didn't work, the higer prio task isn't called unless
>> the lower prio task gives up cpu (by calling e.g. rt_task_yield or
>> nanosleep) (see attached demo source)
>>
>> When not being cooperative (removing the rt_task_yield in the demo)
>> my system is reset after some seconds.
>>
>> Why isn't my supervising task scheduled?
>>
>
> This new I-pipe patch for 2.4.25 may fix the issue:
> http://download.gna.org/adeos/patches/v2.4/ppc/adeos-ipipe-2.4.25-ppc-DEN=
X-1.2-02.patch
>
> --
> Philippe.
>
>


--=20
Carsten Spie=DF

