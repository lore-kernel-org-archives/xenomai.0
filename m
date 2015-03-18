MIME-Version: 1.0
Sender: had2006@gmail.com
Date: Wed, 18 Mar 2015 15:12:15 +0000
Message-ID: <CAKk99t3x2u4GN0D2w_pSBY8jWVRuE1yFki66dYNUfFBSd2GQ6w@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Makefile to use 2 APIs (rtdm and alchemy) simultaneously
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>, Helder Daniel <hdaniel@ualg.pt>

Hi

I translated the xddp-echo.c example to work with alchemy and rt_tasks
rather than posix threads.

It was needed to include the header for alchemy tasks: #include
<alchemy/task.h> and maintain: <rtdm.h/ipc.h>

It was compiled with a simple make file specifying in xeno-config just
alchemy skin to get the compilation flags, however when running it gives an
error:

socket address family not supported by protocol

To workaround the makefile was modified to get the compilation flags for
both skins (as shown below).

But there are any other way of compiling programs that use XDDP real time
sockets and alchemy API?

For the original version POSIX version xeno-config returns the correct
compilation flags specifying rtdm skin or posix skin. It is not needed to
specify both.

The makefile to get flags for RTDM and Alchemy:

https://xenomai.org/documentation/trunk/html/api/xddp-label_8c-example.html

the compilation flags to compile it

skin1   :=  alchemy
skin2   :=  rtdm

CFLAGS  := $(shell xeno-config --skin=$(skin1) --cflags)
CFLAGS  += $(shell xeno-config --skin=$(skin2) --cflags)
LDFLAGS := $(shell xeno-config --skin=$(skin1) --ldflags)
LDFLAGS += $(shell xeno-config --skin=$(skin2) --ldflags)

$(target): $(target).c
$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
