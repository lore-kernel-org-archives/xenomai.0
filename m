Subject: Re: [Xenomai-help] xenomai revision 1772 on arm
From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
In-Reply-To: <Pine.GSO.4.64.0610301611060.6748@domain.hid>
References: <1162218640.4993.5.camel@domain.hid>
	<Pine.GSO.4.64.0610301611060.6748@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nqT1+M2WE27fD/KtqCrf"
Date: Thu, 02 Nov 2006 15:08:53 +0100
Message-Id: <1162476533.5015.19.camel@domain.hid>
Mime-Version: 1.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>


--=-nqT1+M2WE27fD/KtqCrf
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-10-30 at 16:12 +0100, Sebastian Smolorz wrote:
> On Mon, 30 Oct 2006, Schl=E4gl Manfred jun. wrote:
>=20
> > Should be a hint, if anyone has similar Problems:
> >
> > Xenomai (rev. 1772) was not running on my platform. (no
> > timer_tick-calls; timer stopped)
> >
> > I had to do following downgrade:
> >
> > Index: include/asm-arm/hal.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- include/asm-arm/hal.h       (revision 1772)
> > +++ include/asm-arm/hal.h       (working copy)
> > @@ -103,10 +103,13 @@
> >
> > static inline void rthal_timer_program_shot (unsigned long delay)
> > {
> > +    if(!delay)
> > +        delay =3D 10;
> > +    __ipipe_mach_set_dec(delay);
> > -    if(!delay)
> > -        rthal_trigger_irq(RTHAL_TIMER_IRQ);
> > -     else
> > -       __ipipe_mach_set_dec(delay);
> > }
> >
> >     /* Private interface -- Internal use only */
> >
> >
> > It's simply a workaround yet. I'll try to find the error in my
> > timer-handling.
>=20
> What is your timer operation mode? Free-running or counting down and=20
> aperiodic?
>=20
> Sebastian

Using arm926 with Xenomai rev. 1790 (2.6.15.7 with ipipe-1.5-01)

I'm using an aperiodic timer without wraparound. the problem:
To ack the timer interrrupt I have to disable the timer (!TEN) and the
timer_interrupt generation (!INTS) first.
When i disable the timer (!TEN) the timer-read-register is automatically
reloaded with the timer-count-register. So a timer-read (getticksoffset)
after __ipipe_mach_acktimer returns the reload value not 0. Is this the
right behavior.
Or my solution (to backup the timer-value before disabling the timer for
later reads).

My solution works for the old xenomai implementation (2.2.3)=20
hal.h:
static inline void rthal_timer_program_shot (unsigned long delay)
{
   if(!delay)
      delay =3D 10;
   __ipipe_mach_set_dec(delay);
}
but not for the new one:
static inline void rthal_timer_program_shot (unsigned long delay)
{
   if(!delay)
      rthal_trigger_irq(RTHAL_TIMER_IRQ);
   else
      __ipipe_mach_set_dec(delay);
}




My timer-implementation:

#include <linux/module.h>	/* EXPORT_SYMBOL */
#include <linux/ioport.h>	/* request_resource */
#include <linux/interrupt.h>	/* irqreturn_t */

#include <asm/io.h>		/* writel */
#include <asm/mach-types.h>

#include <asm/arch/ns9750_sys.h> /* NS_SYS */
#include <asm/arch/irqs.h>	/* IRQ_TIMER_0 */
#include <asm/arch/time.h> 	/* ns_time_init */


#include<linux/delay.h>


/* activate sequence lock while interrupt (from integrator) */
#define SEQ_LOCK

/* start default debug-level */
#define DEBUG_ENABLED
#define DEFAULT_DEBUG 1


/**************************************************************************=
***********
# begin		DEFINITIONS
***************************************************************************=
***********/

/* full clock-frequency */
#if 0
#define	CFG_HZ		(CPU_CLK_FREQ/64)
#else
#define	CFG_HZ		(CPU_CLK_FREQ)
#endif

#define TIMER_USED	0


static irqreturn_t ns9750_timer_interrupt( /*@unused@*/ int irq,
					   void* dev_id,
					   struct pt_regs* regs );


static struct irqaction ns_timer_irq =3D {
	.name		=3D "NS9750 Timer Tick",
	.flags		=3D SA_INTERRUPT | SA_TIMER,
	.handler	=3D ns9750_timer_interrupt
};

/* reload value for timer */
static unsigned int ns_timer_reload;

/* correct ticks */
static unsigned long ns_timer_delta_old;
static unsigned int ns_timer_jiffies_old;

/* lost ticks, saved if __ipipe_mach_set_sec while running timer */
static unsigned long ns_timer_lxlost;

/* timer ok - flag */
static int ns_tscok;



/* IPIPE-SPECIFIC VARIABLES */
#ifdef CONFIG_IPIPE
#ifdef CONFIG_NO_IDLE_HZ
#error "dynamic tick timer not yet supported with IPIPE"
#endif /* CONFIG_NO_IDLE_HZ */

/* the timer interrupt */
int __ipipe_mach_timerint =3D IRQ_TIMER_0 + TIMER_USED;
EXPORT_SYMBOL(__ipipe_mach_timerint);

/* ticks-counter */
static unsigned long long __ipipe_mach_tsc;

static DEFINE_SPINLOCK(timer_lock);

static int ns_valid=3D1;

/* timer stolen - flag */
int __ipipe_mach_timerstolen =3D 0;
EXPORT_SYMBOL(__ipipe_mach_timerstolen);
#endif


/* timer-ticks per jiffy (init in ns_time_init) */
unsigned int __ipipe_mach_ticks_per_jiffy;
EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);=20


void __tm_init_timer(void);



/**************************************************************************=
***********
# begin		TIMER-SPECIFIC HELP-FUNCTIONS
***************************************************************************=
***********/

/* begin
TODO ??????????????????????????????????????????????????????????????????????=
 */

/* backup for timer-value if timer gets disabled */
static unsigned long timer_value_backup;

unsigned long ns_read_timer_value(void )=20
{
	if(ns_valid=3D=3D1) {
		return readl(NS_SYS_TIMER_READ( TIMER_USED ));
	} else {
		return timer_value_backup;	=09
//		return ns_timer_reload;
//		return 0;
//		return readl(NS_SYS_TIMER_READ( TIMER_USED ));
	}
}


/* disable timer */
#define DISABLE_TIMER()																				\
do {																								\
timer_value_backup=3Dns_read_timer_value(); \
	rmwl( NS_SYS_TIMER_CTRL( TIMER_USED ), & ~NS_SYS_TIMER_CTRL_TEN &
~NS_SYS_TIMER_CTRL_INTS);		\
} while(0)



/* end
TODO ??????????????????????????????????????????????????????????????????????=
 */

#define ENABLE_TIMER()				\
	rmwl( NS_SYS_TIMER_CTRL( TIMER_USED ), | NS_SYS_TIMER_CTRL_TEN |
NS_SYS_TIMER_CTRL_INTS)

#define CLEAR_TIMER()				\
	writel(0,NS_SYS_TIMER_CTRL( TIMER_USED ) )

#define INIT_TIMER()														\
	writel(																	\
		NS_SYS_TIMER_CTRL_TDBG |	/* stop timer in debug-mode */			\
		NS_SYS_TIMER_CTRL_INTS |	/* generate irq */						\
		NS_SYS_TIMER_CTRL_UDS |		/* down-counter */						\
		NS_SYS_TIMER_CTRL_TSZ 		/* 32 bit */							\
		, NS_SYS_TIMER_CTRL( TIMER_USED ) )

#define ACK_TIMER_INT()														\
do {																		\
	rmwl( NS_SYS_TIMER_CTRL( TIMER_USED ), | NS_SYS_TIMER_CTRL_INTC );		\
	rmwl( NS_SYS_TIMER_CTRL( TIMER_USED ), & ~NS_SYS_TIMER_CTRL_INTC );		\
}while (0)




/**************************************************************************=
***********
# end		TIMER-SPECIFIC HELP-FUNCTIONS
***************************************************************************=
***********/


/**************************************************************************=
***********
# begin		GENERAL TIMER-FUNCTIONS
***************************************************************************=
***********/


static inline void set_dec(unsigned long reload)
{
	/* disable timer (not nessecary?)*/
	DISABLE_TIMER();

	/* reload */
	writel( reload, NS_SYS_TIMER_COUNT( TIMER_USED ) );

	/* activate timer */
	ENABLE_TIMER();

	/* save reload */
	ns_timer_reload =3D reload;
}

/* get ticks-offset */
#define ns_getticksoffset() 					\
	(likely(ns_tscok) ? ns_timer_reload - ns_read_timer_value() : 0)


/*
 * Returns number of us since last clock interrupt.  Note that
interrupts
 * will have been disabled by do_gettimeoffset()
 */
unsigned long ns9750_gettimeoffset(void)
{
	/* get ticks */
	unsigned long timer_delta =3D ns_getticksoffset();

#if 1 /* correction from original-implementation */
	if( ns_timer_jiffies_old =3D=3D jiffies && ns_timer_delta_old >
timer_delta ) {
		/* we are called by arm/kernel/time.c:do_gettimeofday with
		 * interrupts disabled.
		 * It may happen then that there is a timer reload after
		 * interrupts disable. Therefore jiffies is not incremented.
		 * So while jiffies has not been updated, return the old
		 * time. */
		timer_delta =3D ns_timer_delta_old;
	} else {
		ns_timer_delta_old =3D timer_delta;
		ns_timer_jiffies_old =3D jiffies;
	}
#endif

	/* calc */
	return ( (1000 * (ns_timer_lxlost + timer_delta)) /
(__ipipe_mach_ticks_per_jiffy / 10) );
}
EXPORT_SYMBOL(ns9750_gettimeoffset);

/*
 * IRQ handler for the timer
 */
static irqreturn_t ns9750_timer_interrupt( /*@unused@*/ int irq,
					   void* dev_id,
					   struct pt_regs* regs )
{
#ifdef SEQ_LOCK
	write_seqlock(&xtime_lock);
#endif

	ns_timer_lxlost =3D 0;


#ifdef CONFIG_IPIPE
	/*
	 * - if Linux is running natively (no ipipe), ack and reprogram the
timer
	 * - if Linux is running under ipipe, but it still has the control over
	 *   the timer (no Xenomai for example), then reprogram the timer
(ipipe
	 *   has already acked it)
	 * - if some other domain has taken over the timer, then do nothing
	 *   (ipipe has acked it, and the other domain has reprogramed it)
	 */
	if (!__ipipe_mach_timerstolen) {
		__ipipe_mach_tsc +=3D ns_getticksoffset();
#else
	/* ack interrupt and disable timer */
	DISABLE_TIMER();
	ACK_TIMER_INT();
#endif

		/* activate timer */
		ENABLE_TIMER();

#ifdef CONFIG_IPIPE
	}=20
#endif

	/* linux timer tick */
	timer_tick( regs );

#ifdef SEQ_LOCK
	write_sequnlock(&xtime_lock);
#endif

	return IRQ_HANDLED;
}

static struct resource timer_resource[ 3 ] =3D {
	{
		.name	=3D "system timer",
		.start	=3D (NS_SYS_TIMER_CTRL( TIMER_USED ) ),
		.end	=3D (NS_SYS_TIMER_CTRL( TIMER_USED ) ) + 3,
	},
	{
		.name	=3D "system timer",
		.start	=3D (NS_SYS_TIMER_READ( TIMER_USED ) ),
		.end	=3D (NS_SYS_TIMER_READ( TIMER_USED ) ) + 3,
	},
	{
		.name	=3D "system timer",
		.start	=3D (NS_SYS_TIMER_COUNT( TIMER_USED ) ),
		.end	=3D (NS_SYS_TIMER_COUNT( TIMER_USED ) ) + 3,
	}
};

/*
 * Set up timer interrupt, and return the current time in seconds.
 */
void __init ns_time_init( void )
{
	request_resource( &iomem_resource, &timer_resource[ 0 ] );
	request_resource( &iomem_resource, &timer_resource[ 1 ] );
	request_resource( &iomem_resource, &timer_resource[ 2 ] );

	/* clear */
	CLEAR_TIMER();

	/* init */
	INIT_TIMER();

	__ipipe_mach_ticks_per_jiffy =3D CFG_HZ/HZ;

	dbg(0,"\n CFG_HZ:            %d\n"
		" HZ:                %d\n"
		" ticks_per_jiffy:   %d\n"
		" uSecs_per_jiffy:   %d\n"
		,
		CFG_HZ,
		HZ,
		__ipipe_mach_ticks_per_jiffy,
		10000
	);

	setup_irq( IRQ_TIMER_0 + TIMER_USED, &ns_timer_irq );

	/* programm and enable timer */
	set_dec(__ipipe_mach_ticks_per_jiffy); /* a tick every HZ */

	ns_tscok =3D 1;

	__tm_init_timer();
}

/**************************************************************************=
***********
# end		GENERAL TIMER-FUNCTIONS
***************************************************************************=
***********/




#ifdef CONFIG_IPIPE
/**************************************************************************=
***********
# begin		IPIPE-FUNCTIONS
***************************************************************************=
***********/

/* called after each timer-interrupt if stolen */
void __ipipe_mach_acktimer(void)
{
	if(ns_valid=3D=3D-1) {
		nop();
	}

	if(readl(NS_SYS_TIMER_READ( TIMER_USED ))) {
		nop();
//		printk("1 : %u\n", readl(NS_SYS_TIMER_READ( TIMER_USED )));
//		printk("2 : %u\n", readl(NS_SYS_TIMER_READ( TIMER_USED )));
	}

	DISABLE_TIMER();
	ns_valid=3D0;
	ACK_TIMER_INT();
//	rmwl( NS_SYS_TIMER_CTRL( TIMER_USED ), | NS_SYS_TIMER_CTRL_INTS);
//	rmwl( NS_SYS_TIMER_CTRL( TIMER_USED ), | NS_SYS_TIMER_CTRL_TEN);
//	ENABLE_TIMER();
}
EXPORT_SYMBOL(__ipipe_mach_acktimer);

unsigned long long __ipipe_mach_get_tsc(void)
{
	unsigned long long result;
	unsigned long flags;

	spin_lock_irqsave_hw(&timer_lock, flags);
	result =3D __ipipe_mach_tsc + ns_getticksoffset();
	spin_unlock_irqrestore_hw(&timer_lock, flags);

	return result;
}
EXPORT_SYMBOL(__ipipe_mach_get_tsc);


/* begin
TODO ??????????????????????????????????????????????????????????????????????=
 */
/* see include/asm/xenomai/hal.h rthal_timer_program_shot too */
void __ipipe_mach_set_dec(unsigned long reload)
{
	unsigned long ticks;
	unsigned long flags;

#if 1
	/* test new xenomai-handling (xeno 2.2.3 rthal_timer_program_shot is
used) *
	if(reload=3D=3D10) {
		ns_valid=3D-1;
		ipipe_trigger_irq(IRQ_TIMER_0 + TIMER_USED);
		return;

//		reload=3D1;
	}
#endif
	spin_lock_irqsave_hw(&timer_lock, flags);
=09
	ticks =3D ns_getticksoffset();
	__ipipe_mach_tsc +=3D ticks;

	ns_timer_lxlost +=3D ticks;

	if(reload>0) {
		set_dec(reload);
		ns_valid=3D1;
		spin_unlock_irqrestore_hw(&timer_lock, flags);
	} else {
		/* trigger manually */
		spin_unlock_irqrestore_hw(&timer_lock, flags);
		ipipe_trigger_irq(IRQ_TIMER_0 + TIMER_USED);
	}
}
EXPORT_SYMBOL(__ipipe_mach_set_dec);
/* end
TODO ??????????????????????????????????????????????????????????????????????=
 */

unsigned long __ipipe_mach_get_dec(void)
{
	if(unlikely(ns_valid<1)) printk("GET_DEC INVALID ################# %ul
\n",readl(NS_SYS_TIMER_READ( TIMER_USED )));
	return readl(NS_SYS_TIMER_READ( TIMER_USED ));
}
EXPORT_SYMBOL(__ipipe_mach_get_dec);

#endif /* CONFIG_IPIPE */


--=-nqT1+M2WE27fD/KtqCrf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBFSfv1bMvu5jIEpfsRAup5AJ9HCogNMdras3vZsTwhpqqOiqvO9QCfVdCE
kFm0/Aysik/dctz8NdaJrcY=
=ruVb
-----END PGP SIGNATURE-----

--=-nqT1+M2WE27fD/KtqCrf--


