Message-ID: <2ff1a98a0803110236r13a58c2fl7b142d834336673d@domain.hid>
Date: Tue, 11 Mar 2008 10:36:03 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d3f72a390803110152q4af121dxdacde86189088549@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d3f72a390803070526r3867c800u9bfb40ac1eba705e@domain.hid>
	<2ff1a98a0803070539i6cfa19a4t63e56e266fbfba71@domain.hid>
	<d3f72a390803070630je3a4d4fsaf96b79c0de792ea@domain.hid>
	<2ff1a98a0803070635g253cfc2cod690f90dd934b62e@domain.hid>
	<d3f72a390803100122q23e381f9y7cbdf2c14b177415@domain.hid>
	<2ff1a98a0803100341p1e72d412l27d002b018ddbf9@domain.hid>
	<d3f72a390803110152q4af121dxdacde86189088549@domain.hid>
Subject: Re: [Xenomai-help] [Xenomai-core] WIRED INTERRUPT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: axel axel <softaxel@domain.hid>, xenomai-help <xenomai@xenomai.org>

On Tue, Mar 11, 2008 at 9:52 AM, axel axel <softaxel@domain.hid> wrote:
>
>
> 2008/3/10, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> > On Mon, Mar 10, 2008 at 9:22 AM, axel axel <softaxel@domain.hid> wrote:
> > > I installed trunk but nothing was changed.
> >
> >
> > If you measure the jitter when receiving the semaphore, that's normal:
> > unlocked context switches improve interrupt latency, not scheduling
> > latency.
> >
> >
> > >  So i saw in the documentation that i can put an interrupt shield on a
> task.
> > >
> > > But when i use interrupt shield i saw with the oscilloscope that linux
> > > doesn't work, instead xenomai task and interrupt handler yes, and the
> jitter
> > > go down in about 50~us.
> >
> >
> > The interrupt shield only make a difference for tasks running in
> > secondary mode. So, if you observe a difference, it means that your
> > task is running in secondary mode. Or you may observe an indirect
> > effect (Linux interrupts do not run, so they do not fill the cache).
>
> Probabily it's an an indirect effect.
> How does the cache work ?

http://en.wikipedia.org/wiki/Cache

ARM cache is usually of type VIVT

>  It's an interrupt chache?

No, I am talking about the memory (data & instruction) cache.

> what does it mean fill the cache with the shield setting in primary mode ?
>
>
>
> > >
> > > The problem is:
> > > - xenomai task wait on the 2ms semaphore, put on/off a led and just wait
> on
> > > the previous semaphore, in conclusion there is a little work,
> > >  but linux hang.
> > >
> > >
> > >
> > > So i have this situation and the relative c code:
> > >
> > > 1. i have a kernel module that handle a xenomai interrupt of 2ms, do
> some
> > > work, enable a semaphore;
> > >
> > > int isrIntFujitsu( xnintr_t* cookie )
> > > {
> > >      word16 i;
> > >
> > >     CLEAR_IRQ();
> > >
> > >      //-----------------------LED---------------------------------------
> > >         //    P6 on
> > >      __raw_writel( __raw_readl( GPIO_PCDR ) | 0x00000020 , GPIO_PCDR );
> > >
> > >     //-----------------------------------------------------------------
> > >
> > >     physFujMem->cmd.dpBusySync[ 2 ] = TRUE;
> > >
> > >     //copiamo l'area dalla dualport del fujitsu
> > >      for( i=0; i < 24; i++)
> > >     {
> > >         *( (word16 * )adrLocalRead + i ) = *( adrPhysRead + i );
> > >      }
> > >
> > >     //Scriviamo nella dualport del fujitsu
> > >     for( i=0; i < 24; i++)
> > >      {
> > >         *( adrPhysWrite + i ) = *( (word16 * )adrLocalWrite + i );
> > >     }
> > >
> > >     physFujMem->cmd.dpBusySync[ 2 ] = FALSE;
> > >
> > >             //    P6 off
> > >      __raw_writel( __raw_readl( GPIO_PCDR ) & 0xFFFFFCF , GPIO_PCDR);
> > >
> > >
> > >          //incrementa il semaforo ( il fujitsu ha alzato un interrupt )
> > >     rt_sem_v( &rtFujSem );
> > >
> > >     return RT_INTR_HANDLED ;
> > > }
> > >
> > >
> > >
> > >
> > > 2. a xenomai task that wait on the same semaphore of kernel xenomai
> > > interrupt and start his work.
> > >
> > > void taskCan (void *cookie)
> > > {
> > >     int err;
> > >
> > >
> > >     err = rt_task_set_mode( 0, T_PRIMARY | T_SHIELD ,0);
> > >      if( err != 0 )
> > >     {
> > >         printf( "Impossible to set task mode\n" );
> > >         fflush( stdout );
> > >     }
> > >
> > >     for (;;)
> > >     {
> > >
> > >         rt_sem_p( &rtSemCan,TM_INFINITE );
> >
> >
> > Could you test the return value of rt_sem_p here ? If it fails, then
> > you are calling it in a loop, causing the machine to hang. In any
> > case, you may activate Xenomai watchdog and Linux soft-lockup detector
> > to detect all kinds of soft lockups.
>
> the return value of rt_sem_p is always 0.
>
>
>



-- 
 Gilles Chanteperdrix

