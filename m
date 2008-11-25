Message-ID: <492C12C0.20600@domain.hid>
Date: Tue, 25 Nov 2008 15:59:12 +0100
From: =?ISO-8859-1?Q?C=E9dric_Schaffter?= <cedric.schaffter@domain.hid>
MIME-Version: 1.0
References: <492C108B.1090909@domain.hid> <492C112B.50403@domain.hid>
	<492C1206.2030009@domain.hid>
In-Reply-To: <492C1206.2030009@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: Quoted-Printable
Subject: Re: [Xenomai-help] SMP issues
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

C=E9dric Schaffter a =E9crit :
> Gilles Chanteperdrix a =E9crit :
>> C=E9dric Schaffter wrote:
>> =20
>>> But the problem is that I get same results in both case... I thought=20
>>> tasks were automatically dispatched between
>>> cores or cpu. Did I forget something?
>>>    =20
>>
>> Linux does that. With xenomai, tasks never migrate, choosing what task
>> runs on what processor is part of the design of your application.
>> Migrations kill determinism.
>>
>>  =20
> So I have to specify which task runs on which core, using the flag=20
> T_CPU(x) during the task creation?
>


