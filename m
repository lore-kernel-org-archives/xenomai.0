MIME-Version: 1.0
Sender: had2006@gmail.com
Date: Tue, 17 Mar 2015 18:35:17 +0000
Message-ID: <CAKk99t1uNuO81qXKwkQuLTaHLNSydY94H1uOKdODAXsRp0Zfig@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Differences when compiling with g++ support in Mercury
	and Cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>, Helder Daniel <hdaniel@ualg.pt>

I am compiling a small Alchemy App with C++ support, that is perfectly
compiled in Xenomai 2.5.x.

Xenomai Alchemy support is included in source code as:

#include <task.h>
#include <sem.h>

or as:

#include <alchemy/task.h>
#include <alchemy/sem.h>

and also in Cobalt (but not in Mercury) as:

#include <native/task.h>
#include <native/sem.h>

In the makefile Xenomai flags are found with:

skin  :=  native
#or skin  :=  alchemy

CFLAGS  := $(shell xeno-config --skin=$(skin) --cflags)
LDFLAGS := $(shell xeno-config --skin=$(skin) --ldflags)

If using an ANSI C compiler there is no problem specifying skin as native
or alchemy in the makefile,
but when using a C++ compiler:

#use c++ compiler
CC = g++

using skin := native xeno-config reports correct flags only in Mercury.
In Cobalt some functions like:

rt_task_set_periodic() and rt_task_spawn ()

are reported as "not declared in this scope"
Other, such as the one below are found:

rt_task_shadow ()
rt_task_wait_period()
rt_task_delete()

rt_sem_create()
rt_sem_bind()
rt_sem_delete()
rt_sem_v()
rt_sem_p()

Using skin := alchemy both gcc and g++ can found all functions in both
Mercury and Cobalt.

this might suggest that the native API legacy support is not fully
operational?
Because using the API designation of Alchemy all compiles fine.

Also there is a best way to include Alchemy headers in 3.x?

#include <alchemy/task.h> ...
or just:
#include <task.h> ...

Any of these forms will be deprecated in the future?

Thanks,

PS:
skin := native in Mercury is equal to skin := Alchemy in Cobalt (the only
diff is macros -D__MERCURY__ and -D__COBALT__)

skin := native in Cobalt is very different. It seems to include support not
only for legacy APIs but also for Mercury and Cobalt at the same time
-lalchemy -lcobalt (?)

xeno-config output for these cases:

skin := native in Mercury
g++ -o readport readport.cpp -I/usr/xenomai/include/mercury
-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__MERCURY__
-I/usr/xenomai/include/alchemy -lalchemy -Wl,--wrap=main
-Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib
-lcopperplate -lpthread -lrt -lfuse


skin := Alchemy in Cobalt
g++ -o readport readport.cpp -I/usr/xenomai/include/cobalt
-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__COBALT__
-I/usr/xenomai/include/alchemy  -lalchemy -Wl,--wrap=main
-Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -lcopperplate
-L/usr/xenomai/lib -lcobalt -lpthread -lrt    -lfuse

skin := native in Cobalt
g++ -o readport readport.cpp -I/usr/xenomai/include/trank -D__XENO_COMPAT__
-I/usr/xenomai/include/cobalt -I/usr/xenomai/include -D_GNU_SOURCE
-D_REENTRANT -D__COBALT__ -I/usr/xenomai/include/alchemy -ltrank  -lalchemy
-Wl,--wrap=main -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld
-lcopperplate -L/usr/xenomai/lib -lcobalt -lpthread -lrt    -lfuse


-- 
Helder
