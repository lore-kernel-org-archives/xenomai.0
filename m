Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 May 2007 08:58:02 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01EB15D1@domain.hid>
In-Reply-To: <4642D901.9050304@domain.hid>
References: <1072004B0EE21141A9DEBA9785A77F14658A70@domain.hid>	<4641CD8B.8050309@domain.hid>	<7289437c0705090643gc9f0ddax6fa6cff44895c9ed@domain.hid>	<7289437c0705090735n58b4a0fbm7e31c8571efb7514@domain.hid>	<17986.12574.488256.997900@domain.hid>	<17986.15326.243315.427529@domain.hid>	<1178748178.11688.45.camel@domain.hid>	<17986.20728.617772.991566@domain.hid><1178784303.11688.108.camel@domain.hid>
	<4642D901.9050304@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: Re: [Xenomai-help] Problem with pthread_setschedparam
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

Hi,

Can this be related to the still unuanswered problem I was posting here:

https://mail.gna.org/public/xenomai-help/2007-05/msg00039.html

?

Best regards,=20

--=20
Daniel Schnell                   | daniel.schnell@domain.hid
Hugb=FAna=F0arger=F0                   | www.marel.com


-----Original Message-----
From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] =
On Behalf Of Gilles Chanteperdrix
Sent: 10. ma=ED 2007 08:34
To: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Problem with pthread_setschedparam

Philippe Gerum wrote:
> On Wed, 2007-05-09 at 23:23 +0200, Gilles Chanteperdrix wrote:
> > Gilles Chanteperdrix wrote:
> >  > Perrine Martignoni wrote:
> >  >  > On 5/9/07, Perrine Martignoni <perrmart@domain.hid> wrote:
> >  >  > >  On 5/9/07, Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org> wrote:
> >  >  > > >
> >  >  > > > Noren, Andrew wrote:
> >  >  > > > > Hi Gilles,
> >  >  > > > >
> >  >  > > > > I too have encountered this issue with the POSIX skin.
> >  >  > > > > I think it may have to do with the order in which the=20
> > posix skin hooks  >  > > > > are run on thread deletion.
> >  >  > > > >
> >  >  > > > > In ksrc/skins/posix/syscall.c  >  > > > >=20
> > xnpod_remove_hook(XNHOOK_THREAD_DELETE, &__shadow_delete_hook);  > =20
> > > > > >  >  > > > > and ksrc/skins/posix/thread.c  >  > > > >=20
> > xnpod_add_hook(XNHOOK_THREAD_DELETE, thread_delete_hook);  >  > > >=20
> > >  >  > > > > The thread_delete_hook seems to run first causing the=20
> > thread data to  >  > > > be  >  > > > > destroyed before=20
> > __shadow_delete_hook has a chance to run.
> >  >  > > > >
> >  >  > > > > This results in __shadow_delete_hook failing in various =
cases.
> >  >  > > > >
> >  >  > > > > An example of an error case linked with this would be=20
> > the failure to  >  > > > > remove the thread key from the hash=20
> > bucket after application  >  > > > exit.  The  >  > > > > next run=20
> > of an application can then result in pthread_setschedparam  >  > > > =

> > > failing to create a shadow since it likely finds an id in the hash =
=20
> > >  > > > > bucket already.
> >  >  > > >
> >  >  > > > Hi,
> >  >  > > >
> >  >  > > > thanks for pointing this out, I see other skins use=20
> > xnfreesafe in their  >  > > > thread deletion hook instead of =
xnfree. The attached patch fixes this.
> >  >  > > >
> >  >  > > > Perrine, could you apply this patch and check that it=20
> > solves your issue  >  > > > ?
> >  >  > >
> >  >  > > I'll do that as soon as I can.
> >  >  > > Thanks
> >  >  > >
> >  >  >
> >  >  > I have applied the patch.
> >  >  > It doesn't solve the problem but I have more information :
> >  >  >
> >  >  >
> >  >  > pthread_create returned 11
> >  >  >
> >  >  > __pthread_shadow: -11
> >  >  >
> >  >  > Xenomai Posix skin init: pthread_setschedparam: Resource=20
> > temporarily  >  > unavailable  >  > Ok, I could reproduce the=20
> > problem. The issue is most likely an access to  > the thread memory=20
> > after it has been freed which breaks the allocator  > linked list of =

> > free pages by replacing a link to a next free page by a  > NULL=20
> > pointer. xnheap_alloc interprets this NULL pointer as the end of the =
=20
> > > linked list and hence considers that it is out of memory.
> >=20
> > And the winner is... RPI! The offset of the thread structure member=20
> > that is set to NULL is the one of the rpi pointer. Disabling RPI=20
> > makes the problem vanish.
> >=20
> > Philippe, when is this pointer set to NULL ?
> >=20
>=20
> When the thread leaves secondary mode or exits, which in turn removes=20
> it from the queue the nucleus considers for priority boosting the root =

> thread. Check rpi_none().

Conclusion: the problem is the one Andrew spotted, there are two hooks =
and the shadow hook (which calls xnshadow_unmap, which in turn calls =
rpi_pop, which sets the rpi pointer to null) gets called after the other =
thread deletion hook which initially called xnfree, and now calls =
xnfreesafe.

But it seems that even xnfreesafe is not safe enough, and it frees the =
thread pointer immediately whereas we would like the operation to be =
deferred.

This problem is a problem for all skins, the freed memory is accessed =
after it has been freed, it is only visible with the posix skin on ARM, =
because the offset of the rpi pointer is the same as the place where the =
xnheap allocator stores the pointer to the next free page.

So, I propose the following patch which makes xnfreesafe safer.

Other solutions are:
- call directly xnheap_schedule_free in thread deletion hooks
- change the execution order of the deletion hooks
- merge the two deletion hooks, enclosing the shadow deletion hook in an =
 #ifdef CONFIG_XENO_OPT_PERVASIVE, to get sure of the execution order.

--=20
                                                 Gilles Chanteperdrix

