From: Andreas Glatz <AndreasGlatz@domain.hid>
Date: Wed, 10 Feb 2010 13:23:59 -0500
Message-ID: <245373446233674495BCA5CA2FC1EB173713B4D0CF@RCexchangeSVR1.ruggedcom.local>
References: <245373446233674495BCA5CA2FC1EB173713B4D0CD@RCexchangeSVR1.ruggedcom.local>,
	<4B72F95E.3080402@domain.hid>
In-Reply-To: <4B72F95E.3080402@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Kernel oops when reading /proc/xenomai/stats
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,


>>
>> That's the kernel oops with additional debugging info (starts with 'HUHU=
' - see code below the oops):
>>
>> HUHU count=3D1 xnintr_count=3D-12
>
>That's not good. What is your Xenomai version?

Hardware=3DMPC8360, Linux=3D2.6.32, Xenomai=3D2.4.10, ipipe=3D2.8-00

>
>Does everything work fine if you application terminates normally and
>deletes the rt_intr objects explicitly?

Checking...


Tnx,
Andreas=

