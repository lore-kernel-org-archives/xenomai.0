From: Sambasiva Rao Manchili <sambasiva.manchili@domain.hid>
Date: Fri, 5 Aug 2011 08:48:10 +0200
Message-ID: <509DA52866E38F47878413CF102D751FD420779536@domain.hid>
References: <509DA52866E38F47878413CF102D751FD4207794F0@domain.hid>
	<1312370844.2135.10.camel@domain.hid>
	<509DA52866E38F47878413CF102D751FD4207794F2@domain.hid>
	<4E394A78.7040408@domain.hid>
	<509DA52866E38F47878413CF102D751FD4207794F8@domain.hid>
	<4E395528.5090409@domain.hid>
	<509DA52866E38F47878413CF102D751FD4207794FA@poseidon.nexus-ag.com>
	<4E3966ED.1030408@domain.hid>
In-Reply-To: <4E3966ED.1030408@domain.hid>
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

Hi Gilles,
Thank you for hint. Apparently  hint (direction that I may have to look) on=
 error that I receive -EPREM seems to be promising.
To give a try I just removed all taskLock but still no luck yet.
I am trying...

I have taken your NOTE.
Thank you.
Samba.

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Wednesday, 03. August, 2011 17:19
To: Sambasiva Rao Manchili
Cc: Philippe Gerum; Antonio Gambin; Xenomai-help@domain.hid
Subject: Re: [Xenomai-help] Xenomai VxWorks Skin--->semTake

On 08/03/2011 04:24 PM, Sambasiva Rao Manchili wrote:
> You want printErrno instead of strerror.
>
>>> Samba: In the beginning days of our code porting from VxWorks to
>>> Linux,  Xenomai failed to create message Queue  that was working on
>>> VxWorks. When xenomai failed to create message queue it returned
>>> 0x110001=3D=3D=3D>1114113. After reading the Xenomai code a bit I
>>> understood it is S_memLib_NOT_ENOUGH_MEMORY. I therefore reduced the
>>> Queue size by 5 times and it was then successful.
>>> The way I extracted the errno in beginning days is same as I did
>>> today. So I epxected a value which >>tells the actual reason of
>>> semTake failure. But I got this huge value which is -1.  Am I
>>> missing something ?
>

The thing is printErrno is a xenomai posix skin function which knows S_meml=
ib_NOT_ENOUGH_MEMORY, strerror is an unrelated glibc function, and does not=
.

What you are missing is this comment in ksrc/skins/vxworks/syscall.c
/*
 * By convention, error codes are passed back through the syscall
 * return value:
 * - negative codes stand for internal (i.e. nucleus) errors;
 * - strictly positive values stand for genuine VxWorks errors.
 * - zero means success.
 *

Looking at the code, I think after a service returns an error, it may be mo=
re reliable to use errno than to use errnoOfTaskGet.

> 1 is EPERM. Is the thread issuing the call a thread created by
> Xenomai?
>
>>> Samba: Yes. I guess taskSpawn leads finally to Xenomai libraries to
>>> create thread.  All  our VxWorks code(with minor changes) as it is
>>> running on top of Xenomai. Please tell me,  What will you suggest me
>>> then ?

Trace the kernel code to know the reason for semTake to return -EPERM.
Another reason documented in txt/vxworks/skin.txt maybe that you are callin=
g semTake in a region where the scheduler has been locked (using taskLock).

NOTE: it would be nice if you could formats your mails as everybody
does: quote the mail you reply to by prepending " >" to the beginning of th=
e lines you are quoting, and do not put ">" characters in front of the line=
s you add.

--
                                            Gilles.


This email and any attachment may contain confidential information which is=
 intended for use only by the addressee(s) named above. If you received thi=
s email by mistake, please notify the sender immediately, and delete the em=
ail from your system. You are prohibited from copying, disseminating or oth=
erwise using the email or any attachment.


