Message-ID: <507E5D8F.2000705@xenomai.org>
Date: Wed, 17 Oct 2012 09:26:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAG_j_bA-8b-jkuaLR29bWF92aq=iD1YAfx_844mAq2w9oMhkSg@mail.gmail.com>
In-Reply-To: <CAG_j_bA-8b-jkuaLR29bWF92aq=iD1YAfx_844mAq2w9oMhkSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Trouble running native examples
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Amit Goradia <amit@automatasystems.com>
Cc: xenomai@xenomai.org

On 10/17/2012 09:12 AM, Amit Goradia wrote:
> automata@automata-xenomai:~/xenomai-2.6.1/examples/native$ make
> gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__   -lnative
> -L/usr/xenomai/lib -lxenomai -lpthread -lrt  -Xlinker -rpath -Xlinker
> /usr/xenomai/lib  trivial-periodic.c   -o trivial-periodic
> /tmp/ccJuIj7p.o: In function `demo':
> trivial-periodic.c:(.text+0x2f): undefined reference to
> `rt_task_set_periodic'
> trivial-periodic.c:(.text+0x34): undefined reference to `rt_timer_read'
> trivial-periodic.c:(.text+0x46): undefined reference to
> `rt_task_wait_period'
> trivial-periodic.c:(.text+0x4b): undefined reference to `rt_timer_read'
> /tmp/ccJuIj7p.o: In function `main':
> trivial-periodic.c:(.text+0x133): undefined reference to `rt_task_create'
> trivial-periodic.c:(.text+0x14f): undefined reference to `rt_task_start'
> trivial-periodic.c:(.text+0x160): undefined reference to `rt_task_delete'
> collect2: ld returned 1 exit status
> make: *** [trivial-periodic] Error 1
> So what am I doing wrong?
> 
> Any clues?

The link order is wrong, trivial-periodic on the command line should be
before -lnative -lxenomai, etc...

Please try the following patch:

diff --git a/examples/native/Makefile b/examples/native/Makefile
index 485b3fa..498d870 100644
--- a/examples/native/Makefile
+++ b/examples/native/Makefile
@@ -32,13 +32,13 @@ endif

 CC=$(shell $(XENOCONFIG) --cc)

-CFLAGS=$(shell $(XENOCONFIG) --skin=native --cflags) $(MY_CFLAGS)
+CPPFLAGS=$(shell $(XENOCONFIG) --skin=native --cflags) $(MY_CFLAGS)

-LDFLAGS=$(shell $(XENOCONFIG) --skin=native --ldflags) $(MY_LDFLAGS)
+LOADLIBES=$(shell $(XENOCONFIG) --skin=native --ldflags) $(MY_LDFLAGS)

 # This includes the library path of given Xenomai into the binary to
make live
 # easier for beginners if Xenomai's libs are not in any default search
path.
-LDFLAGS+=-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)
+LOADLIBES+=-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)

 all:: $(APPLICATIONS)

@@ -50,12 +50,6 @@ endif



-###### SPECIAL TARGET RULES ######
-rtprint: rtprint.c
-	$(CC) $(CFLAGS) $? $(LDFLAGS) -o $@
-
-
-
 ###### KERNEL MODULE BUILD (no change required normally) ######
 ifneq ($(MODULES),)


-- 
					    Gilles.

