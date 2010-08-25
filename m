From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C74EF8B.5090704@domain.hid>
References: <1278071401-13880-1-git-send-email-wolfgang.mauerer@domain.hid>
	<1278071401-13880-2-git-send-email-wolfgang.mauerer@domain.hid>
	<1282725843.1709.12.camel@domain.hid>
	<4C74D948.6010906@domain.hid>
	<1282726435.1709.22.camel@domain.hid>
	<4C74DB38.3010104@domain.hid>
	<1282727242.1709.26.camel@domain.hid>
	<4C74E022.8030105@domain.hid>
	<1282728443.1709.46.camel@domain.hid>
	<4C74EF8B.5090704@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 Aug 2010 13:23:30 +0200
Message-ID: <1282735410.1709.129.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH 1/2] ipipe: Pass NTP-corrected time
 information from Linux to higher domains
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "adeos-main@gna.org" <adeos-main@gna.org>, "Mauerer,
	Wolfgang" <wolfgang.mauerer@domain.hid>

On Wed, 2010-08-25 at 12:25 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Wed, 2010-08-25 at 11:19 +0200, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> On Wed, 2010-08-25 at 10:58 +0200, Jan Kiszka wrote:
> >>>> Philippe Gerum wrote:
> >>>>> On Wed, 2010-08-25 at 10:50 +0200, Jan Kiszka wrote:
> >>>>>> Philippe Gerum wrote:
> >>>>>>> On Fri, 2010-07-02 at 13:50 +0200, Wolfgang Mauerer wrote:
> >>>>>>>
> >>>>>>> <snip>
> >>>>>>>
> >>>>>>>> diff --git a/include/linux/ipipe_tickdev.h b/include/linux/ipipe_tickdev.h
> >>>>>>>> index 4a1cb1b..86f13e0 100644
> >>>>>>>> --- a/include/linux/ipipe_tickdev.h
> >>>>>>>> +++ b/include/linux/ipipe_tickdev.h
> >>>>>>>> @@ -25,6 +25,7 @@
> >>>>>>>>  #if defined(CONFIG_IPIPE) && defined(CONFIG_GENERIC_CLOCKEVENTS)
> >>>>>>> Since we should have CONFIG_HAVE_IPIPE_HOSTRT by now, let's use it.
> >>>>>> Don't get yet how this fits here.
> >>>>> arch-dep would define CONFIG_HAVE_IPIPE_HOSTRT [if IPIPE]
> >>>>>
> >>>> Still don't see the relation to the line you cited above.
> >>>>
> >>> That is because you chose to have CONFIG_IPIPE_HOSTRT and
> >>> CONFIG_HAVE_IPIPE_HOSTRT. I would have only defined the latter, the way
> >>> you define the former. I'm looking for the hostrt support to be compiled
> >>> in if CONFIG_HAVE_IPIPE_HOSTRT is available from the arch-dep section,
> >>> so we don't need CONFIG_IPIPE_HOSTRT. Generic bits may depend on HAVE_*
> >>> as well.
> >> First of all, the code you cited _above_ is not changed by our patches,
> >> so the context still puzzles me (but maybe you are referring to some
> >> other place in fact).
> > 
> > Patch v2 says:
> > 
> > diff --git a/kernel/ipipe/Kconfig b/kernel/ipipe/Kconfig
> > index de5e6a3..bc7a00c 100644
> > --- a/kernel/ipipe/Kconfig
> > +++ b/kernel/ipipe/Kconfig
> > @@ -33,3 +33,10 @@ config IPIPE_UNMASKED_CONTEXT_SWITCH
> >         bool
> >         depends on IPIPE
> >         default n
> > +
> > +config HAVE_IPIPE_HOSTRT
> > +       bool
> > +
> > +config IPIPE_HOSTRT
> > +       def_bool y
> > +       depends on HAVE_IPIPE_HOSTRT && IPIPE
> > 
> > So what's your point?
> > 
> >> Second, CONFIG_HAVE_IPIPE_HOSTRT is designed to be set independently of
> >> CONFIG_IPIPE - it's a static arch feature like all the other
> >> CONFIG_HAVE_* in arch/*/Kconfig. So it takes a second, generically
> >> defined CONFIG switch if the generic support also depends on
> >> CONFIG_IPIPE like in this case.
> > 
> > Which does not make any sense. We don't want to make this selectable at
> > all. Mainline has CONFIG_HAVE_SYSCALL_WRAPPERS for instance, and you
> > won't find any CONFIG_SYSCALL_WRAPPERS, because it makes no sense not to
> > use them when the architecture _have_ them. It goes exactly the same way
> > with hostrt.
> 
> Don't find your example.

I just did:
 find . -name 'Kconfig*' -print |xargs grep SYSCALL_WRAPPERS

>  But maybe you should have a look at
> [HAVE_]USER_RETURN_NOTIFIER (and maybe I should push [HAVE_]IPIPE_HOSTRT
> into arch/Kconfig).

And select it conditionally on IPIPE in arch/x86/Kconfig? why not.

> 
> Jan
> 

-- 
Philippe.



