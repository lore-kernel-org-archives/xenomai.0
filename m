Message-ID: <441C4279.10800@domain.hid>
Date: Sat, 18 Mar 2006 18:25:13 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <441C2574.4030901@domain.hid>
In-Reply-To: <441C2574.4030901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: get the simulator running...
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe,
> 
> here are some patches and comments on the simulator "quick"-start
> process. I guess the patches are due to latest changes in trunk, and I
> cannot guarantee that they are clean - but the simulator compiles now.
> 
> Regarding the rest of its build and start process: There are two hidden
> requirements, namely gcc < 4 (due to -fwritable-strings)

Normally, availability of --fwritable-strings should be auto-detected by 
the configure script. So there is something wrong going there, I will 
look at it.

  and gdb 5.x. A

I've been unlucky with GDB 6.x too, but did not check the latest 
release; I'm currently using 5.3 when running simulations.

> note in sim/README about them would be great. Or do you have a fix for
> those issues scheduled?

--fwritable-strings should be fixed. I'm not sure if the requirement for 
GDB 5.x still applies though.
> 
> Well, once you got this far (i.e. the xenoscope is built and an ancient
> gdb has been prepared), the next step is to produce a test program. Am I
> overseeing some example?

Look into ksrc/skins/{vxworks,psos+}/demos. The Makefile also produces a 
simulation executable for satch. Then run "xenoscope satch_sim"

  Fortunately, I had that demo I once produced
> (last year), but that one was easier to build. I first had to drag in
> the libs and includes of both the simulator and a regular xenomai
> installation (I think to remember this once worked without this
> add-ons). Then I need this additional trick in the simulators include dir:
> 
> mkdir asm
> ln -s <xeno-inst-dir>/include/asm-sim asm/xenomai
> 
> This maps #include <asm/xenomai/system.h> to the correct "arch".
> Shouldn't this be created automatically during the simulator
> installation? Or is something else broken on my box?
> 

You clearly should not need this trick to compile apps against the 
simulation environment; the instrumenter (gcic) sets the proper flags. 
I'm going to rebuild one and let you know.

> In case there is no demo prepared, I could pack my own tiny stuff and
> submit it.
> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: ksrc/skins/vxworks/msgQLib.c
> ===================================================================
> --- ksrc/skins/vxworks/msgQLib.c	(Revision 742)
> +++ ksrc/skins/vxworks/msgQLib.c	(Arbeitskopie)
> @@ -199,7 +199,7 @@
>      appendq(&wind_msgq_q, &queue->link);
>      xnlock_put_irqrestore(&nklock, s);
>      
> -#ifdef CONFIG_XENO_OPT_REGISTRY
> +#ifdef CONFIG_XENO_EXPORT_REGISTRY
>      sprintf(queue->name,"mq%lu",msgq_ids++);
>  
>      if (xnregistry_enter(queue->name,queue,&queue->handle,&msgq_pnode))
> @@ -208,7 +208,7 @@
>  	msgQDelete((MSG_Q_ID)queue);
>  	return 0;
>  	}
> -#endif /* CONFIG_XENO_OPT_REGISTRY */
> +#endif /* CONFIG_XENO_EXPORT_REGISTRY */
>  
>      return (MSG_Q_ID) queue;
>  }
> Index: ksrc/skins/vxworks/wdLib.c
> ===================================================================
> --- ksrc/skins/vxworks/wdLib.c	(Revision 742)
> +++ ksrc/skins/vxworks/wdLib.c	(Arbeitskopie)
> @@ -123,7 +123,7 @@
>      appendq(&wind_wd_q,&wd->link);
>      xnlock_put_irqrestore(&nklock, s);
>  
> -#ifdef CONFIG_XENO_OPT_REGISTRY
> +#ifdef CONFIG_XENO_EXPORT_REGISTRY
>      sprintf(wd->name,"wd%lu",wd_ids++);
>  
>      if (xnregistry_enter(wd->name,wd,&wd->handle,&wd_pnode))
> @@ -132,7 +132,7 @@
>  	wdDelete((WDOG_ID)wd);
>  	return 0;
>  	}
> -#endif /* CONFIG_XENO_OPT_REGISTRY */
> +#endif /* CONFIG_XENO_EXPORT_REGISTRY */
>  
>      return (WDOG_ID) wd;
>  }
> Index: ksrc/skins/vxworks/semLib.c
> ===================================================================
> --- ksrc/skins/vxworks/semLib.c	(Revision 742)
> +++ ksrc/skins/vxworks/semLib.c	(Arbeitskopie)
> @@ -479,7 +479,7 @@
>      xnlock_get_irqsave(&nklock, s);
>      appendq(&wind_sem_q,&sem->link);
>      xnlock_put_irqrestore(&nklock, s);
> -#ifdef CONFIG_XENO_OPT_REGISTRY
> +#ifdef CONFIG_XENO_EXPORT_REGISTRY
>      sprintf(sem->name,"sem%lu",sem_ids++);
>  
>      if (xnregistry_enter(sem->name,sem,&sem->handle,&sem_pnode))
> @@ -488,7 +488,7 @@
>  	semDelete((SEM_ID)sem);
>  	return 0;
>  	}
> -#endif /* CONFIG_XENO_OPT_REGISTRY */
> +#endif /* CONFIG_XENO_EXPORT_REGISTRY */
>  
>      return (SEM_ID) sem;
>  }
> Index: include/asm-sim/system.h
> ===================================================================
> --- include/asm-sim/system.h	(Revision 742)
> +++ include/asm-sim/system.h	(Arbeitskopie)
> @@ -80,6 +80,7 @@
>  
>  #define XNARCH_DEFAULT_TICK         10000000 /* ns, i.e. 10ms */
>  #define XNARCH_HOST_TICK            0 /* No host ticking service. */
> +#define HZ                          0 /* dummy define for HZ */
>  
>  #define XNARCH_THREAD_STACKSZ 0 /* Let the simulator choose. */
>  #define XNARCH_ROOT_STACKSZ   0	/* Only a placeholder -- no stack */


-- 

Philippe.

