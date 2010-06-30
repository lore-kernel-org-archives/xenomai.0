From: "Sydir, Jerry" <jerry.sydir@domain.hid>
Date: Tue, 29 Jun 2010 17:13:19 -0700
Message-ID: <8EA2C2C4116BF44AB370468FBF85A77701658160C1@domain.hid>
References: <8EA2C2C4116BF44AB370468FBF85A777016574B413@domain.hid>
	<4C2A078E.80009@domain.hid>
	<8EA2C2C4116BF44AB370468FBF85A7770165815E06@domain.hid>
	<4C2A74C0.2000909@domain.hid> <4C2A7586.5070107@domain.hid>
In-Reply-To: <4C2A7586.5070107@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] machine hangs running oprofile on xenomai kernel
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



Gilles Chanteperdrix wrote:

>Jan Kiszka wrote:
>> [please do not top-post]
>>
>> Sydir, Jerry wrote:
>>> Hi Jan,
>>>
>>> Thanks for your reply. I tried loading the oprofile module with timer=
=3D1
>and oprofile seems to work (doesn't hang the system and spits out some
>results). So it appears that the use of NMIs are the problem. Do you have
>any suggestions on what to try next?
>>
>> Now someone would have to dig into the code path taken by oprofile
>> during NMI handling to find the reason for the lock-up. Did you have any
>> real-time jobs running when starting the profiling, or was Xenomai idle?
>>
>> On the other hand, oprofile is a legacy interface. It probably makes
>> more sense to try and, if required, fix perf instead.
>
>Could not there be some bad interaction with Xenomai NMI watchdog?
>
>--
>					    Gilles.

I think that the NMI watchdog is not enabled in my configuration (CONFIG_XE=
NO_HW_NMI_DEBUG_LATENCY is not set). I'm not that familiar with xenomai, so=
 I'm not sure if this is what you are talking about.

Jerry Sydir

