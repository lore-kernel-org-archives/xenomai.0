Date: Tue, 21 Apr 2015 20:25:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150421182550.GE7109@hermes.click-hack.org>
References: <20150421160625.GX7109@hermes.click-hack.org>
 <553676DF.8020607@siemens.com>
 <20150421161623.GY7109@hermes.click-hack.org>
 <553678CC.5020206@siemens.com>
 <20150421163247.GZ7109@hermes.click-hack.org>
 <55367CB0.90609@siemens.com> <55368E4F.4040101@siemens.com>
 <20150421175651.GC7109@hermes.click-hack.org>
 <55369131.9070406@siemens.com>
 <20150421181602.GD7109@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150421181602.GD7109@hermes.click-hack.org>
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : lib/cobalt: Rework minimum
 stack size enforcement
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Tue, Apr 21, 2015 at 08:16:02PM +0200, Gilles Chanteperdrix wrote:
> On Tue, Apr 21, 2015 at 08:04:33PM +0200, Jan Kiszka wrote:
> > On 2015-04-21 19:56, Gilles Chanteperdrix wrote:
> > > On Tue, Apr 21, 2015 at 07:52:15PM +0200, Jan Kiszka wrote:
> > >> On 2015-04-21 18:37, Jan Kiszka wrote:
> > >>> Possibly the crash was limited to the case where the application set a
> > >>> stack address and Xenomai messed up the size. I'm rechecking this right
> > >>> now, and if we are lucky, PTHREAD_STACK_MIN turns out to be fine for
> > >>> Xenomai as well.
> > >>
> > >> Too bad, it wasn't that easy. Just try this, even without Xenomai:
> > >>
> > >> #include <stdio.h>
> > >> #include <pthread.h>
> > >> #include <limits.h>
> > >>
> > >> void *thread_func(void *arg)
> > >> {
> > >> 	fprintf(stderr, "crash %s\n", "me");
> > >> 	return NULL;
> > >> }
> > >>
> > >> int main(int argc, char *argv[])
> > >> {
> > >> 	pthread_t thread;
> > >> 	pthread_attr_t attr;
> > >>
> > >> 	pthread_attr_init(&attr);
> > >> 	pthread_attr_setstacksize(&attr, PTHREAD_STACK_MIN);
> > >>
> > >> 	pthread_create(&thread, &attr, thread_func, NULL);
> > >>
> > >> 	pthread_join(thread, NULL);
> > >>
> > >> 	return 0;
> > >> }
> > >>
> > >> Crashes on my x86-64 boxes all the time. stdout/printf is fine. Some
> > >> internal glibc function requires a lot of stack space.
> > > 
> > > Well, as I said several time in that thread, using printf with glibc
> > > and PTHREAD_STACK_MIN crashes. Yes, this is an issue I had noticed a
> > > long time ago. I always assumed it was because printf used alloca or
> > > allocated a large buffer on stack by some other mean.
> > > 
> > >>
> > >> The problem is that we trigger the very same pattern with warning() in
> > >> Xenomai. When that is called by the thread trampoline, the user cannot
> > >> run threads with otherwise totally fine PTHREAD_STACK_MIN.
> > >>
> > >> Now we can
> > >> - ask the user to specify for more stack (by contract)
> > >> - reject too small stacks (my patches)
> > >> - warn about too small stacks, but accept them (maybe a compromise)
> > >> - simply ignore this
> > > 
> > > This is not our business. Really.
> > > 
> > 
> > It is our business as we change the interface for the user in a
> > non-configurable way.
> 
> Again: we should not change the interface for the user. Period.
> Whatever he passes to pthread_attr_setstacksize or
> pthread_attr_setstack gets used by the glibc. The average user
> should not use these interfaces, the users who uses them should know
> what he is doing.
> 
> What we can change is the default stack size used, pick a stack size
> which does not cause printf to segfault (for reasonable string
> sizes, of say 80 characters), and hide that in pthread_attr_init.
> Because the average user is not going to pass a stack size and can
> expect the default to work reasonably well.
> 
> > The bare minimum is documentation,
> 
> Well, all the books on the pthread API warn you that
> pthread_attr_setstack is not a good idea. Maybe even the open group
> documentation and the linux documentation do.

Nothing in the open group documentation, but the Linux documentation
states: 

These functions are provided for applications that must ensure that
a thread's stack is placed in a particular location. For most
applications, this is not necessary, and the use of these functions
should be avoided.

-- 
					    Gilles.

