Message-ID: <5509B74A.8080302@xenomai.org>
Date: Wed, 18 Mar 2015 18:35:06 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t3x2u4GN0D2w_pSBY8jWVRuE1yFki66dYNUfFBSd2GQ6w@mail.gmail.com>
In-Reply-To: <CAKk99t3x2u4GN0D2w_pSBY8jWVRuE1yFki66dYNUfFBSd2GQ6w@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Makefile to use 2 APIs (rtdm and alchemy)
	simultaneously
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/18/2015 04:12 PM, Helder Daniel wrote:
> Hi
> 
> I translated the xddp-echo.c example to work with alchemy and rt_tasks
> rather than posix threads.
> 
> It was needed to include the header for alchemy tasks: #include
> <alchemy/task.h> and maintain: <rtdm.h/ipc.h>
> 
> It was compiled with a simple make file specifying in xeno-config just
> alchemy skin to get the compilation flags, however when running it gives an
> error:
> 
> socket address family not supported by protocol
> 
> To workaround the makefile was modified to get the compilation flags for
> both skins (as shown below).
> 
> But there are any other way of compiling programs that use XDDP real time
> sockets and alchemy API?

XDDP is based on RTDM, so you need POSIX, along with Alchemy for the
changes you added, i.e.:

xeno-config --alchemy --posix --ldflags

> 
> For the original version POSIX version xeno-config returns the correct
> compilation flags specifying rtdm skin or posix skin. It is not needed to
> specify both.
> 
> The makefile to get flags for RTDM and Alchemy:
> 
> https://xenomai.org/documentation/trunk/html/api/xddp-label_8c-example.html
>

Unlike with 2.6.x, mentioning RTDM is pointless with Xenomai 3.x because
you always have POSIX implicitly for any application, therefore you have
RTDM. Giving --skin=rtdm or --rtdm is a no-op for compat purpose with
legacy Makefiles actually.

With 3.x, RTDM implies POSIX I/O calls and the socket interface, which
is readily available with libcobalt, which all apps link against.

-- 
Philippe.

