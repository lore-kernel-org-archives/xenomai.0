Message-ID: <4E580A61.8020107@domain.hid>
Date: Fri, 26 Aug 2011 23:04:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2BB74055-EB0C-4474-BA76-BE4227C56B50@domain.hid>
In-Reply-To: <2BB74055-EB0C-4474-BA76-BE4227C56B50@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5.3 process doubles its memory
 footprint when spawning a subprocess?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeremy Friesner <jaf@domain.hid>
Cc: xenomai@xenomai.org, Jeff Koftinoff <jeffk@domain.hid>

On 08/26/2011 10:54 PM, Jeremy Friesner wrote:
> I suspect that is has something to do with mlockall() and/or some
> other aspect of Xenomai partially or fully defeating the fork()
> call's Copy-On-Write feature, meaning that when the sub-process is
> spawned, most or all of the RAM pages allocated by the parent process
> are being duplicated, even though they are all going to be thrown
> away again immediately because I'm going to call exec() right
> afterwards.

The "copy-on-write" feature causes faults both in the parent and child
process, which causes threads to exit primary mode. So, in order to
avoid it, we duplicate the memory space when forking.

> 
> My question is, is there some recommended way to launch a sub-process
> from a large Xenomai process that will avoid massive amounts of
> overhead?  I suppose I could launch a separate, persistent,
> non-Xenomai process that would act as a "non-Xenomai process server",
> and connect to it via TCP and ask it to spawn processes on my
> behalf.... but that seems like an awful lot of extra work.  Is there
> an easier way around this problem?

If what you intend is to execute another thread, you do not need to use
fork(), you can use vfork() which will avoid the issue you are
mentioning. Normally, if you are using a recent libc, system() already
uses vfork().

It is also worth mentioning that the reason why your process consumes so
much memory in the first place may be because of the space allocated for
the threads stacks (2MB by default), because of mlockall. So, if you are
using the posix API, think about setting the stacks sizes to a more
reasonable size with pthread_attr_setstacksize.

-- 
                                                                Gilles.

