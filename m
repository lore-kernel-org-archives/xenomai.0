Message-ID: <fb3e91c788e98c96e2c5061a83b96def.squirrel@www.xenomai.org>
In-Reply-To: <49E736B33FAAA645BCAB9FFEC26712E6FD1648@EXDAG0-B0.intra.cea.fr>
References: <49E736B33FAAA645BCAB9FFEC26712E6FD0C05@EXDAG0-B0.intra.cea.fr>
	<b7108896dbd73baf5b1890f4cddc62b0.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD1648@EXDAG0-B0.intra.cea.fr>
Date: Wed, 19 Jun 2013 14:00:37 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] CPU time limit exceeded
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: HAUTBOIS Flavian <Flavian.HAUTBOIS@cea.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


HAUTBOIS Flavian wrote:
> Thanks a lot for this complete and short answer.
>
> - I didn't find any mention of PTHREAD_WARNSWS throughout the entire code
> via a grep command. However, I found a T_WARNSW mention in the Orocos
> files, which according to sigdebug.c apparently does the same thing.

Hi Flavian,

Yes, that is the same thing.

> - This __wrap_send problem might be a key to solving this issue. I
> enclosed the "ldd" and "nm" traces of the some_core library (you can find
> mentions of __wrap_send in the nm.txt file, as well as the core_dump.txt
> file which contains a backtrace of the core dump when the program
> crashes).

send is replaced with __wrap_send when passing --wrap send to the linker,
which happens when you are using the compiler flags given by:
xeno-config --skin posix --ldflags
__wrap_send is implemented in libpthread_rt.so, part of xenomai user-space
support and emits a system call relying on xenomai kernel-space support,
using rtnet or other rtdm based drivers, depending on the socket family the
socket you pass to __wrap_send is using. If that fails, because, the
correct options were not enabled in xenomai kernel-space, because the RTnet
driver is not started, or for other reasons, __wrap_send falls back to the
glibc send service, which will cause a SIGXCPU to be sent if you enabled
T_WARNSW.

So, either your application is using glibc to send the packet because this
is what you want, in which case you should not arm the T_WARNSW bit for
this thread, or you would like to use RTnet to send the particular packet
which causes the SIGXCPU signal to be sent, in which case something is not
configured correctly and you should find what.

> - I included the handler of sigdebug.c in my own file. I'm also enclosing
> what it returned in sigcpu.txt. I didn't find anything new or unexpected
> in it, but I have to admit that I don't know how to read 95% of the file.

The part of the sigdebug.c I was interested in was not the part which prints
the backtrace, since you already had the backtrace, but the part that
prints a message depending on the reason.

>
> Do you have any ideas why RTNet does not seem to be used? How to fix it?

I do not really know what your application does, this may be normal or not.
A first step to see if the socket you pass to __wrap_send is an RTnet socket
is to check its value. RTDM normally uses socket numbers between 1024 -
128 and 1023 inclusive.

Regards.


-- 
                    Gilles.


