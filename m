Message-ID: <4E3966ED.1030408@domain.hid>
Date: Wed, 03 Aug 2011 17:19:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <509DA52866E38F47878413CF102D751FD4207794F0@domain.hid>	<1312370844.2135.10.camel@domain.hid>
	<509DA52866E38F47878413CF102D751FD4207794F2@domain.hid>
	<4E394A78.7040408@domain.hid>
	<509DA52866E38F47878413CF102D751FD4207794F8@domain.hid>
	<4E395528.5090409@domain.hid>
	<509DA52866E38F47878413CF102D751FD4207794FA@poseidon.nexus-ag.com>
In-Reply-To: <509DA52866E38F47878413CF102D751FD4207794FA@poseidon.nexus-ag.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Sambasiva Rao Manchili <sambasiva.manchili@domain.hid>
Cc: Antonio Gambin <antonio.gambin@domain.hid>, "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

On 08/03/2011 04:24 PM, Sambasiva Rao Manchili wrote:
> You want printErrno instead of strerror.
> 
>>> Samba: In the beginning days of our code porting from VxWorks to
>>> Linux,  Xenomai failed to create message Queue  that was working
>>> on VxWorks. When xenomai failed to create message queue it
>>> returned 0x110001===>1114113. After reading the Xenomai code a
>>> bit I understood it is S_memLib_NOT_ENOUGH_MEMORY. I therefore
>>> reduced the Queue size by 5 times and it was then successful.
>>> The way I extracted the errno in beginning days is same as I did
>>> today. So I epxected a value which >>tells the actual reason of
>>> semTake failure. But I got this huge value which is -1.  Am I
>>> missing something ?
> 

The thing is printErrno is a xenomai posix skin function which knows
S_memlib_NOT_ENOUGH_MEMORY, strerror is an unrelated glibc function, and
does not.

What you are missing is this comment in ksrc/skins/vxworks/syscall.c
/*
 * By convention, error codes are passed back through the syscall
 * return value:
 * - negative codes stand for internal (i.e. nucleus) errors;
 * - strictly positive values stand for genuine VxWorks errors.
 * - zero means success.
 *

Looking at the code, I think after a service returns an error, it may be
more reliable to use errno than to use errnoOfTaskGet.

> 1 is EPERM. Is the thread issuing the call a thread created by
> Xenomai?
> 
>>> Samba: Yes. I guess taskSpawn leads finally to Xenomai libraries
>>> to create thread.  All  our VxWorks code(with minor changes) as
>>> it is running on top of Xenomai. Please tell me,  What will you
>>> suggest me then ?

Trace the kernel code to know the reason for semTake to return -EPERM.
Another reason documented in txt/vxworks/skin.txt maybe that you are
calling semTake in a region where the scheduler has been locked (using
taskLock).

NOTE: it would be nice if you could formats your mails as everybody
does: quote the mail you reply to by prepending " >" to the beginning of
the lines you are quoting, and do not put ">" characters in front of the
lines you add.

-- 
					    Gilles.

