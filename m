References: <fe0243c96682430eb5c01ebec98b269e@itk-engineering.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <dcec62b2-a521-1696-3184-0975b389198e@xenomai.org>
Date: Tue, 13 Sep 2016 09:37:48 +0200
MIME-Version: 1.0
In-Reply-To: <fe0243c96682430eb5c01ebec98b269e@itk-engineering.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Multiple processes within same session
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tobias Luksch <Tobias.Luksch@itk-engineering.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/06/2016 05:38 PM, Tobias Luksch wrote:
> Hello,
> 
> [Arch:x86, Processor:Corei7, Kernel: 4.1.18, Xenomai:3.0.2]
> 
> we are using several Xenomai processes communicating using shared memory (rt_heap) and a few named mutexes. The processes also create additional unnamed task, mutexes, semaphores, etc.
> After porting to Xenomai 3, I see the following problem: To access the shared heap, I start two processes within the same session (--session from command line). Shared access to the heap works, but when creating unnamed objects, e.g. a mutex, in the second process, rt_mutex_create returns -17.
> 
> Here is a small example program to reproduce this:
> 
> #include <alchemy/task.h>
> #include <alchemy/mutex.h>
> #include <stdio.h>
> 
> int main(int argc, char* argv[])
> {
> 	rt_printf("hello  world\n");
> 	RT_MUTEX mutex;
> 	int ret_val = rt_mutex_create( &mutex, NULL );
> 	rt_printf( "rt_mutex_create: %d\n", ret_val );
> 
> 	while (true)
> 	{
> 		rt_task_sleep(1000000000);
> 		rt_printf("ping\n");
> 	}
> 	return 0;
> }
> 
> Starting this program (called xeno-test here) once gives:
> $ ./xeno-test --session=test
> hello  world
> rt_mutex_create: 0
> ping
> ping
> [..]
> 
> Starting it a second time with the same session:
> $ ./xeno-test --session=test
> hello  world
> rt_mutex_create: -17
> ping
> ping
> [..]
> 
> Starting the program another time with a different session works without error. Also using differently named mutexes for both instances works.
> 
> I am not sure about the naming mechanism (if any) when creating unnamed objects like mutexes, nor about what is actually shared between processes when using the same session. It would be great if anyone could give some details on this.
> 
> Any help would be appreciated.

This patch should address the issue:

commit e539ab0b1db5ca56f8d3db39d2ca0bdf009c9b25
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Tue Sep 13 09:36:11 2016 +0200

    boilerplate/ancillaries: fix unique name generation in pshared mode

diff --git a/lib/boilerplate/ancillaries.c b/lib/boilerplate/ancillaries.c
index a811a40..0f469a4 100644
--- a/lib/boilerplate/ancillaries.c
+++ b/lib/boilerplate/ancillaries.c
@@ -231,7 +231,11 @@ char *generate_name(char *buf, const char *radix,
 		buf[len] = '\0';
 	} else {
 		tag = atomic_add_fetch(&ngen->serial, 1);
+#ifdef CONFIG_XENO_PSHARED
+		snprintf(buf, len, "%s@%d[%d]", ngen->radix, tag, __node_id);
+#else
 		snprintf(buf, len, "%s@%d", ngen->radix, tag);
+#endif
 	}
 
 	return buf;

-- 
Philippe.

