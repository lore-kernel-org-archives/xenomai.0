From: Sambasiva Rao Manchili <sambasiva.manchili@domain.hid>
Date: Wed, 3 Aug 2011 16:24:44 +0200
Message-ID: <509DA52866E38F47878413CF102D751FD4207794FA@poseidon.nexus-ag.com>
References: <509DA52866E38F47878413CF102D751FD4207794F0@domain.hid>
	<1312370844.2135.10.camel@domain.hid>
	<509DA52866E38F47878413CF102D751FD4207794F2@domain.hid>
	<4E394A78.7040408@domain.hid>
	<509DA52866E38F47878413CF102D751FD4207794F8@domain.hid>
	<4E395528.5090409@domain.hid>
In-Reply-To: <4E395528.5090409@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai VxWorks Skin--->semTake
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
Cc: Antonio Gambin <antonio.gambin@domain.hid>, "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>



-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Wednesday, 03. August, 2011 16:03
To: Sambasiva Rao Manchili
Cc: Philippe Gerum; Antonio Gambin; Xenomai-help@domain.hid
Subject: Re: [Xenomai-help] Xenomai VxWorks Skin--->semTake

On 08/03/2011 03:31 PM, Sambasiva Rao Manchili wrote:
> Hi Gilles,
> I had seen the code  in src\skins\vxworks\semLib.c it returns ERROR which=
 is -1.
>
> The value that I sent earlier is the value that I got out of the followin=
g statement.
> serrLog( serrErr,
>              "resu_getonline_1_svc: semTake for restab_access_smp failed!=
!<%s>",
>               strerror(errnoGet()));
>
> Is it right ?

You want printErrno instead of strerror.

>>Samba:
>>In the beginning days of our code porting from VxWorks to Linux,  Xenomai=
 failed to create message Queue  that was working on VxWorks.
>>When xenomai failed to create message queue it returned 0x110001=3D=3D=3D=
>1114113. After reading the Xenomai code a bit I understood it is S_memLib_=
NOT_ENOUGH_MEMORY.
>>I therefore reduced the Queue size by 5 times and it was then successful.=
  The way I extracted the errno in beginning days is same as I did today. S=
o I epxected a value which >>tells the actual reason of semTake failure. Bu=
t I got this huge value which is -1.  Am I missing something ?

>
>
> Now again I tried with
>  serrLog( serrErr,
>              "resu_getonline_1_svc: semTake for restab_access_smp failed!=
!<%s> <%d>",
>               strerror(errnoGet()), errno);
>
> Here I get value 1 for errno.

1 is EPERM. Is the thread issuing the call a thread created by Xenomai?

>>Samba: Yes. I guess taskSpawn leads finally to Xenomai libraries to creat=
e thread.  All  our VxWorks code(with minor changes) as it is running on to=
p of Xenomai.
>> Please tell me,  What will you suggest me then ?

--
                                            Gilles.


This email and any attachment may contain confidential information which is=
 intended for use only by the addressee(s) named above. If you received thi=
s email by mistake, please notify the sender immediately, and delete the em=
ail from your system. You are prohibited from copying, disseminating or oth=
erwise using the email or any attachment.


