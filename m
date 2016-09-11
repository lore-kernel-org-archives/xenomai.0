References: <fe0243c96682430eb5c01ebec98b269e@itk-engineering.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <93a86010-6692-e08f-12a4-0c1f27d3aedf@xenomai.org>
Date: Sun, 11 Sep 2016 15:29:04 +0200
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

This is a shortcoming of the internal no-so-random name generator used
for anon objects in lib/alchemy: it should use a shared counter when
running in pshared mode for drawing unique names, but currently uses a
process-private one which is wrong. Hence the -EEXIST error received
when two processes draw the same private counter value, which is likely.

As a work around, you could provide named mutexes based on a sequence
number and the current pid value, until the name generator is fixed in
mainline.

-- 
Philippe.

