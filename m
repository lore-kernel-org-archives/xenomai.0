Message-ID: <4BB5D1A0.8030007@domain.hid>
Date: Fri, 02 Apr 2010 13:14:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B97BA0C.9000702@domain.hid> <4B9AD0DE.4020103@domain.hid>	
	<1268472523.27899.135.camel@domain.hid>	
	<4B9BB9B1.5050003@domain.hid>	
	<1268498034.27899.167.camel@domain.hid>	
	<4B9C2100.6090806@domain.hid>	
	<1268584465.27899.197.camel@domain.hid>	
	<4BB4F857.5020906@domain.hid> <4BB50C8B.2000405@domain.hid>	
	<1270156940.2418.403.camel@domain.hid>
	<4BB50F7C.1020102@domain.hid>	
	<1270157507.2418.409.camel@domain.hid>
	<4BB511C7.1050507@domain.hid>	
	<1270158532.2418.420.camel@domain.hid>
	<4BB51631.5030609@domain.hid>
	<1270159246.2418.432.camel@domain.hid>
	<4BB51931.3080307@domain.hid> <4BB523E8.705@domain.hid>
	<4BB5250F.1040409@domain.hid> <4BB52769.4080702@domain.hid>
	<4BB5348B.2070805@domain.hid> <4BB5C95E.9060502@domain.hid>
	<4BB5D0D4.40908@domain.hid>
In-Reply-To: <4BB5D0D4.40908@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-help] Analogy cmd_write example
	explanation
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Redirecting to xenomai core.
>>
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Because of __xn_exec_current, people have broken drivers, and user-space
>>>> applications using T_PRIMARY as a broken way to workaround these broken
>>>> drivers, and by maintaining compatibility, we let them keep their broken
>>>> drivers and applications, by changing to the more natural
>>>> __xn_exec_conforming and removing T_PRIMARY, we ask them to fix their
>>>> drivers and applications.
>>> Right goal, wrong approach for the reason I pointed out to Philippe:
>>>
>>> We cannot map all kinds of driver requirements on a single
>>> __xn_exec_current in the RTDM middle layer.
>> What requirement can we not handle? It looks to me like with
>> __xn_exec_conforming, we can handle any requirement.
>>
>> The only problem being the "double context switch" issue. But as
>> Philippe said, a sane application is calling such ioctls from non
>> critical code, so this is in fact a non-issue.
> 
> And this is one of the restrictions I don't want to keep for upcoming
> versions. Think of a POSIX app that creates threads, even non-RT ones.
> Those are automatically shadowed. If those threads perform lots of
> non-RT service requests on RTDM drivers, they will suffer.

If those threads perform lots of non-RT service requests on RTDM drivers
at a non critical time, then no problem. If those threads perform lots
of non-RT service requests on RTDM drivers at a critical time and exoect
their execution time to be bounded, then you are wrong, because you can
not expect any non real-time service to have a bounded execution time
anyway.

-- 
					    Gilles.

