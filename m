From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17986.15326.243315.427529@domain.hid>
References: <1072004B0EE21141A9DEBA9785A77F14658A70@domain.hid>
	<4641CD8B.8050309@domain.hid>
	<7289437c0705090643gc9f0ddax6fa6cff44895c9ed@domain.hid>
	<7289437c0705090735n58b4a0fbm7e31c8571efb7514@domain.hid>
	<17986.12574.488256.997900@domain.hid>
	<17986.15326.243315.427529@domain.hid>
Content-Type: text/plain
Date: Thu, 10 May 2007 00:02:58 +0200
Message-Id: <1178748178.11688.45.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Problem with pthread_setschedparam
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 2007-05-09 at 23:23 +0200, Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>  > Perrine Martignoni wrote:
>  >  > On 5/9/07, Perrine Martignoni <perrmart@domain.hid> wrote:
>  >  > >  On 5/9/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>  >  > > >
>  >  > > > Noren, Andrew wrote:
>  >  > > > > Hi Gilles,
>  >  > > > >
>  >  > > > > I too have encountered this issue with the POSIX skin.
>  >  > > > > I think it may have to do with the order in which the posix skin hooks
>  >  > > > > are run on thread deletion.
>  >  > > > >
>  >  > > > > In ksrc/skins/posix/syscall.c
>  >  > > > > xnpod_remove_hook(XNHOOK_THREAD_DELETE, &__shadow_delete_hook);
>  >  > > > >
>  >  > > > > and ksrc/skins/posix/thread.c
>  >  > > > > xnpod_add_hook(XNHOOK_THREAD_DELETE, thread_delete_hook);
>  >  > > > >
>  >  > > > > The thread_delete_hook seems to run first causing the thread data to
>  >  > > > be
>  >  > > > > destroyed before __shadow_delete_hook has a chance to run.
>  >  > > > >
>  >  > > > > This results in __shadow_delete_hook failing in various cases.
>  >  > > > >
>  >  > > > > An example of an error case linked with this would be the failure to
>  >  > > > > remove the thread key from the hash bucket after application
>  >  > > > exit.  The
>  >  > > > > next run of an application can then result in pthread_setschedparam
>  >  > > > > failing to create a shadow since it likely finds an id in the hash
>  >  > > > > bucket already.
>  >  > > >
>  >  > > > Hi,
>  >  > > >
>  >  > > > thanks for pointing this out, I see other skins use xnfreesafe in their
>  >  > > > thread deletion hook instead of xnfree. The attached patch fixes this.
>  >  > > >
>  >  > > > Perrine, could you apply this patch and check that it solves your issue
>  >  > > > ?
>  >  > >
>  >  > > I'll do that as soon as I can.
>  >  > > Thanks
>  >  > >
>  >  >
>  >  > I have applied the patch.
>  >  > It doesn't solve the problem but I have more information :
>  >  > 
>  >  > 
>  >  > pthread_create returned 11
>  >  > 
>  >  > __pthread_shadow: -11
>  >  > 
>  >  > Xenomai Posix skin init: pthread_setschedparam: Resource temporarily
>  >  > unavailable
>  > 
>  > Ok, I could reproduce the problem. The issue is most likely an access to
>  > the thread memory after it has been freed which breaks the allocator
>  > linked list of free pages by replacing a link to a next free page by a
>  > NULL pointer. xnheap_alloc interprets this NULL pointer as the end of the
>  > linked list and hence considers that it is out of memory.
> 
> And the winner is... RPI! The offset of the thread structure member that
> is set to NULL is the one of the rpi pointer. Disabling RPI makes the
> problem vanish.
> 
> Philippe, when is this pointer set to NULL ?
> 

When the thread leaves secondary mode or exits, which in turn removes it
from the queue the nucleus considers for priority boosting the root
thread. Check rpi_none().

-- 
Philippe.



