MIME-Version: 1.0
In-Reply-To: <CALH4WdaTXPmzXnUHiU1jfhKUCiBhyG+X1oA6XSK5fHXds_gLTA@mail.gmail.com>
References: <CALH4WdZ3zVeXeapCjUc_usPb4AreGjecPXaLjL_SWZzJ_mo0eQ@mail.gmail.com>
	<4F9D64C1.8070505@domain.hid>
	<CALH4WdaTXPmzXnUHiU1jfhKUCiBhyG+X1oA6XSK5fHXds_gLTA@mail.gmail.com>
Date: Fri, 11 May 2012 17:02:26 +0200
Message-ID: <CALH4WdatY-9r65xU600yf4v0J3cbYqtCeZnP7jvvG0fKvrweYw@domain.hid>
From: Frederik Bayart <frederik.bayart@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai: binding failed: Operation not permitted.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

now with mailing list in cc

Hallo Gilles,

 by adding my user to group xenomai and configuring the
 xeno_nucleus.xenomai_gid parameter on the command line, I was able to
 run my binary as non-root, so my problem is solved.

 However, I noticed that if I start my binary as root, and using
 seteuid and setegid to non-root as in de example still fails. I don't
 know whether this is normal or a bug.

 Frederik
>
> On 29 April 2012 17:56, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 04/25/2012 12:28 PM, Frederik Bayart wrote:
>>> Hallo,
>>>
>>> We are switching from linux 2.6.30.8 with xenomai 2.4.10 =A0to linux 2.=
6.38.8
>>> with xenomai 2.6.0 (stable release) on debian lenny.
>>
>> If you are concerned with security (which seems to be the case since you
>> want to avoid running real-time programs as root):
>> - you should note that debian lenny is no longer maintained for security
>> update (since february actually), so, an upgrade to squeeze is
>> recommended. Chances are that it is possible to become root when running
>> as an ordinary user on a lenny system without too much trouble.
>> - it is entirely possible that it is possible to become root abusing
>> xenomai interfaces, xenomai interfaces are not implemented with security
>> in mind.
>>
>>>
>>> In our daemon (with real pid root), we are setting effective pid and gi=
d to
>>> 1000 and are calling popen to execute a shell command.
>>> The popen succeeds, but when I try to read the output with fgets, I get=
 the
>>> error :
>>>
>>> Xenomai: binding failed: Operation not permitted.
>>>
>>> I verified that the effective user for both commands is the same.
>>>
>>> This was working on xenomai 2.4.10
>>> I added the user with pid 1000 already to the xenomai group but this
>>> doesn't work.
>>
>> That is not enough, you should also do what is said here:
>> http://www.xenomai.org/index.php/Non-root_RT
>>
>> --
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>
>
>
> --
> Frederik Bayart | Senior software engineer
> Triphase NV | Research Park Zone 1719 | Romeinse straat 18 | B-3001 Hever=
lee
> T =A0+32 2 669 06 05 | E frederik.bayart@domain.hid | W www.triphase.co=
m



--=20
Frederik Bayart | Senior software engineer
Triphase NV | Research Park Zone 1719 | Romeinse straat 18 | B-3001 Heverle=
e
T =A0+32 2 669 06 05 | E frederik.bayart@domain.hid | W www.triphase.com

