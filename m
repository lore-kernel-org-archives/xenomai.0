Message-ID: <497724DB.9030706@domain.hid>
Date: Wed, 21 Jan 2009 14:36:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A017769AB@ARVMAIL1.mra.roland-man.biz>
	<49771D9E.4080204@domain.hid>
In-Reply-To: <49771D9E.4080204@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] How to use Xenomai libraries with "normal" (non
 Xenomai) linux processes ?
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
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> roderik.wildenburg@domain.hid wrote:
>>>> 4.) Is there a way, to force back a process to secondary mode
>>>> (after the Xenomai-systemcall has been executed) ?
>>> Yes, but no, you do not want to do that. Xenomai automatically
>>> switches the process when needed.
>>>
>> But yes, I want, I want, I want  ;-)) Think about the following
>> scenario: 1)"linuxwithxenolib" calls my xenomai-library. 2)Due to a
>> xenomai systemcall in my library "linuxwithxenolib" switches to
>> primary mode 3)"linuxwithxenolib" leaves my library function=20
>> 4)"linuxwithxenolib" is still in primary mode and acts as a realtime
>> task till it calls a linux-systemcall. This isn=B4t the way
>> "linuxwithxenolib" should act. It should be scheduled by linux as
>> often and as long as possible. 5)So, if I could force secondary mode
>> at the end of my library function everything would be fine.
>>
>> So how can I force secondary mode ?
>=20
> The point is that if you force it to secondary mode, and the next syste=
m
> call is in fact a xenomai syscall, xenomai will switch the thread to
> primary mode again. So, you have two useless mode switches which you
> could have avoided if you had not forcibly switched to secondary mode.
> Note that even if a xenomai thread is running in secondary mode and has
> a priority higher than another xenomai thread running in primary mode,
> the one running in secondary mode will run. So, you should not use
> primary mode and secondary mode to decide which thread should run, you
> should use the priorities.

The only imaginable scenario for having to force some thread back to
secondary mode is when that thread is running significant CPU load
_without_ issuing a single regular syscall. If such a thread enters
primary mode and is then left there, Linux will not be able to run
anymore. In that case one may insert a tiny nanosleep etc. to enforce
the switch. But that's still a fairly theoretic scenario.

Jan

--=20
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

