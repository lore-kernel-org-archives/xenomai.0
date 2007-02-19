Message-ID: <b647ffbd0702190446h1c3d5387kc350e8008e7e8f61@domain.hid>
Date: Mon, 19 Feb 2007 13:46:34 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Standard linux assignment of processes to CPUs
	depends on Xenomai Config
In-Reply-To: <1171888510.9958.8.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <24461688.1170430564542.JavaMail.ngmail@domain.hid>
	<45D97B38.6060202@domain.hid>
	<b647ffbd0702190301h468a2bbemafff7b9d592e7e@domain.hid>
	<1171884201.9958.4.camel@domain.hid>
	<b647ffbd0702190413s45092566iaa044607d0d9cf4b@domain.hid>
	<1171888510.9958.8.camel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

On 19/02/07, Philippe Gerum <rpm@xenomai.org> wrote:
> On Mon, 2007-02-19 at 13:13 +0100, Dmitry Adamushko wrote:
> > > > ...
> > > > #ifdef CONFIG_SMP
> > > >         /* Make sure the init sequence is kept on the same CPU when
> > > >            running as a module. */
> > > >         set_cpus_allowed(current, cpumask_of_cpu(0));
> > > > #endif /* CONFIG_SMP */
> > > >
> > > > In fact, "running as a module" seems to be a bit
> > > > misleading here.  Then another macro should be used in addition,
> > > > MODULE or how it's called.
> > > >
> > > > Now guess who is a "current" here? It's "init" (pid 0).
> > > >
> > > > init() -> do_basic_setup() -> do_initcalls() -> ... ->
> > > > __xeno_sys_init() -> xnarch_init()
> > > >
> > > > "init" is a first process to run and all the rest will inherit its
> > > > "cpus_allowed" field.
> > > >
> > > > That's it.
> > > >
> > >
> > > Eh, that's what I call a nice one Dmitry. This is the perfect example of
> > > legacy code stabbing us in the back. We should indeed definitely check
> > > for MODULE && SMP.
> >
> > Yep, as the very least. But even in this case, it's not very nice that
> > via cpus_allowed we affect - scheduling-wise - a process which loads
> > xeno modules and all its children as It's likely to be a shell.
>
> It's insmod.

Oh yep :) Don't think it's a problem then. SMP && MODULE should be ok.

> --
> Philippe.
>

-- 
Best regards,
Dmitry Adamushko

