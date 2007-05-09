Message-ID: <OFCD74EB74.DD79A30F-ONC12572D6.00260A10@domain.hid>
From: "Markus Osterried" <Markus.Osterried@domain.hid>
Date: Wed, 9 May 2007 09:07:58 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: [Xenomai-core] Antwort: Re:  Arguments in psos t_start()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org


Hello Gerum,

sorry for not knowing the details. But there is another question.
Is it okay to move the pointer to the arguments to the newly created task?
Isn't it possible that the task which created the new task is rescheduled?
The old task could change the value of the argument and because the new
task only holds a reference to this argument, the new task is also
affected.

Thank you
Markus





                                                                                                                                               
                              Philippe Gerum                                                                                                   
                              <rpm@xenomai.org         An:      Markus Osterried <Markus.Osterried@domain.hid>                                 
                              g>                      Kopie:   xenomai@xenomai.org                                                            
                              Gesendet von:           Blindkopie:                                                                              
                              xenomai-core-bo         Thema:   Re: [Xenomai-core] Arguments in psos t_start()                                  
                              unces@domain.hid                                                                                                    
                                                                                                                                               
                                                                                                                                               
                              08.05.2007                                                                                                       
                              16:55                                                                                                            
                              Bitte antworten                                                                                                  
                              an rpm                                                                                                           
                                                                                                                                               
                                                                                                                                               




On Tue, 2007-05-08 at 16:07 +0200, Markus Osterried wrote:
> Hello Phillipe,
>
> in __t_start() in /ksrc/skins/psos+/syscall.c the pointer to the
> (user-space) tasks argument is directly used for the (kernel-space)
> t_start() call.
>
> u_long *argp;
> argp = (u_long *)__xn_reg_arg4(regs);
> return t_start((u_long)task, mode, startaddr, argp);
>
>
> I think the arguments must be copied to kernel-space, so isn't it better
to
> do it this way?
>
> u_long arg[4];
> if (!__xn_access_ok
>     (curr, VERIFY_READ, __xn_reg_arg4(regs), sizeof(u_long[4])))
>       return -EFAULT;
> __xn_copy_from_user(curr, arg, (void __user *)__xn_reg_arg4(regs),
>                    sizeof(u_long[4]));
> return t_start((u_long)task, mode, startaddr, arg);
>

Actually, we currently don't need to know anything about the task args
from kernel space, since we only have to relay their address to the task
trampoline code in src/skins/psos/task.c. However, we must not try to
access those args from kernel space. The patch below fixes this bug.
Thanks for pointing this out.

--- ksrc/skins/psos+/task.c          (revision 2395)
+++ ksrc/skins/psos+/task.c          (working copy)
@@ -197,9 +197,6 @@

             xnmode = psos_mode_to_xeno(mode);

-            for (n = 0; n < 4; n++)
-                        task->args[n] = targs ? targs[n] : 0;
-
             task->entry = startaddr;

 #if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
@@ -214,10 +211,15 @@
                                                    XNPOD_ALL_CPUS, (void
(*)(void *))startaddr, targs);
             else
 #endif /* __KERNEL__ && CONFIG_XENO_OPT_PERVASIVE */
+            {
+                        for (n = 0; n < 4; n++)
+                                    task->args[n] = targs ? targs[n] : 0;
+
                         xnpod_start_thread(&task->threadbase,
                                                    xnmode,
                                                    (int)((mode >> 8) &
0x7),
                                                    XNPOD_ALL_CPUS,
&psostask_trampoline, task);
+            }

       unlock_and_exit:
--
Philippe.



_______________________________________________
Xenomai-core mailing list
Xenomai-core@domain.hid
https://mail.gna.org/listinfo/xenomai-core







