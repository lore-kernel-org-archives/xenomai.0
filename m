Message-ID: <7289437c0706010017s1250245nd9a39f0f471e493a@domain.hid>
Date: Fri, 1 Jun 2007 09:17:48 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <465EEDC3.6040309@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2257_26480560.1180682268663"
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>
	<7289437c0705310558y6e1b4f8fue26c640d863ae041@domain.hid>
	<465EC7C1.5080300@domain.hid> <465ECDEC.1030109@domain.hid>
	<465ECFCA.1070801@domain.hid> <465ED806.2060608@domain.hid>
	<7289437c0705310758o3512e5e5x4c1a6d1df444be63@domain.hid>
	<465EE3BC.7020905@domain.hid>
	<7289437c0705310833m40dcef0bt188a4b3e33f4c014@domain.hid>
	<465EEDC3.6040309@domain.hid>
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
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

------=_Part_2257_26480560.1180682268663
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>__real_sem_init should be defined by wrappers.o in libpthread_rt.so,
>what does nm libpthread_rt.so say ?

Here is the result of nm libpthread_rt.so :

$ nm libpthread_rt.so
0000202c t $a
00005974 t $a
0000235c t $a
000023fc t $a
00005978 t $a
0000244c t $a
00002030 t $a
00005924 t $a
0000596c t $a
00002034 t $a
00002038 t $a
0000597c t $a
00002454 t $a
000024ec t $a
00002884 t $a
000028d8 t $a
000029b4 t $a
00002a24 t $a
00002b08 t $a
00002c1c t $a
00002c68 t $a
00002cb4 t $a
00002d18 t $a
00002d8c t $a
00002dd0 t $a
00002e34 t $a
00002e84 t $a
00002ef0 t $a
00002f4c t $a
00002fa4 t $a
00003004 t $a
00003058 t $a
000030ac t $a
00003128 t $a
000031ac t $a
000031fc t $a
00003258 t $a
00003324 t $a
000033a8 t $a
000033fc t $a
00003458 t $a
000034b4 t $a
0000350c t $a
00003584 t $a
000035b8 t $a
000035f8 t $a
00003638 t $a
0000367c t $a
000036c0 t $a
00003704 t $a
00003748 t $a
0000378c t $a
000037cc t $a
0000380c t $a
000038c4 t $a
00003984 t $a
000039c0 t $a
00003a00 t $a
00003ac0 t $a
00003b20 t $a
00003b70 t $a
00003bcc t $a
00003c30 t $a
00003cc4 t $a
00003d58 t $a
00003dec t $a
00003e84 t $a
00003ec8 t $a
00003f08 t $a
00003f48 t $a
00003f8c t $a
00003fd0 t $a
00004014 t $a
00004058 t $a
0000409c t $a
000040e0 t $a
00004124 t $a
00004164 t $a
000041a8 t $a
000041f4 t $a
00004234 t $a
00004274 t $a
0000430c t $a
00004360 t $a
000043d8 t $a
00004558 t $a
000045b8 t $a
00004684 t $a
000046e8 t $a
00004738 t $a
000047c0 t $a
0000481c t $a
00004938 t $a
00004a04 t $a
00004b1c t $a
00004ba0 t $a
00004c70 t $a
00004d1c t $a
00004dd0 t $a
00004e84 t $a
00004f38 t $a
00004fe8 t $a
000050d4 t $a
000051b8 t $a
00005298 t $a
00005348 t $a
000053f8 t $a
00005494 t $a
0000554c t $a
000055d0 t $a
000056c0 t $a
0000575c t $a
000057f8 t $a
00005908 t $a
000058f0 t __aeabi_uidivmod
0000ddf0 A __bss_end__
0000ddf0 A _bss_end__
0000dde4 A __bss_start
0000dde4 A __bss_start__
0000596c t call___do_global_ctors_aux
000023fc t call___do_global_dtors_aux
0000244c t call_frame_dummy
         U close
0000dde4 b completed.3705
0000dba8 d __CTOR_END__
0000dba0 d __CTOR_LIST__
         w __cxa_finalize
0000dba0 d $d
0000dbac d $d
0000ddcc d $d
0000ddd0 d $d
000023e8 t $d
00002440 t $d
00005964 t $d
0000ddd4 d $d
000024dc t $d
00002828 t $d
0000dba4 d $d
000028c8 t $d
000029a0 t $d
00002a18 t $d
00002af4 t $d
00002c14 t $d
00002c5c t $d
00002cac t $d
00002d0c t $d
00002d7c t $d
00002dc4 t $d
00002e28 t $d
00002e7c t $d
00002ee4 t $d
00002f40 t $d
00002f98 t $d
00002ffc t $d
0000304c t $d
000030a0 t $d
0000311c t $d
000031a0 t $d
000031f4 t $d
0000324c t $d
0000331c t $d
0000339c t $d
000033f0 t $d
0000344c t $d
000034a8 t $d
00003504 t $d
00003578 t $d
000035ec t $d
0000362c t $d
00003670 t $d
000036b8 t $d
000036f8 t $d
0000373c t $d
00003784 t $d
000037c0 t $d
00003800 t $d
000038b4 t $d
00003974 t $d
000039b8 t $d
000039f4 t $d
00003ab0 t $d
00003b14 t $d
00003b68 t $d
00003bc0 t $d
00003c24 t $d
00003cb8 t $d
00003d50 t $d
00003de0 t $d
00003e78 t $d
00003ec0 t $d
00003efc t $d
00003f3c t $d
00003f80 t $d
00003fc8 t $d
00004008 t $d
0000404c t $d
00004090 t $d
000040d8 t $d
00004118 t $d
00004158 t $d
000041a0 t $d
000041e8 t $d
00004228 t $d
00004268 t $d
000042fc t $d
00004354 t $d
000043d0 t $d
00004548 t $d
000045ac t $d
00004678 t $d
000046dc t $d
00004730 t $d
000047b4 t $d
00004810 t $d
00004924 t $d
000049f4 t $d
00004b0c t $d
00004b90 t $d
00004c60 t $d
00004d10 t $d
00004dc0 t $d
00004e74 t $d
00004f28 t $d
00004fdc t $d
000050c8 t $d
000051a8 t $d
0000528c t $d
00005338 t $d
000053e8 t $d
00005484 t $d
0000553c t $d
000055c0 t $d
000056b0 t $d
0000574c t $d
000057e8 t $d
0000ddcc D __data_start
00005908 t __div0
00005924 t __do_global_ctors_aux
0000235c t __do_global_dtors_aux
0000ddcc d __dso_handle
0000dbb0 d __DTOR_END__
0000dbac d __DTOR_LIST__
0000dbb8 A _DYNAMIC
0000dde4 A _edata
0000ddf0 A _end
0000ddf0 A __end__
         U __errno_location
         U exit
         U fflush
00005974 T _fini
0000dde8 b fork_handler_registered
         U fprintf
00002404 t frame_dummy
00005b9c r __FRAME_END__
         U free
         U fwrite
0000dc70 a _GLOBAL_OFFSET_TABLE_
0000202c T _init
000024ec t __init_posix_interface
0000dbb4 d __JCR_END__
0000dbb4 d __JCR_LIST__
         w _Jv_RegisterClasses
         U malloc
         U mlockall
         U mprotect
         U munlockall
0000ddec b old_sigharden_handler
0000ddd0 d p.3704
         U perror
0000dddc D __pse51_muxid
         U pthread_atfork
         U pthread_attr_getinheritsched
         U pthread_attr_getschedparam
         U pthread_attr_getschedpolicy
         U _pthread_cleanup_pop
         U _pthread_cleanup_push
000037cc t __pthread_cond_cleanup
         U pthread_exit
00004684 T pthread_intr_attach_np
000047c0 T pthread_intr_control_np
000046e8 T pthread_intr_detach_np
00004738 T pthread_intr_wait_np
         U pthread_kill
00002c6c T pthread_make_periodic_np
         U pthread_self
         U pthread_setcanceltype
00002d18 T pthread_set_mode_np
00002d8c T pthread_set_name_np
00002884 t __pthread_sigharden_handler
         U pthread_testcancel
00002a24 t __pthread_trampoline
00002cb4 T pthread_wait_np
         U __real_accept
         U __real_bind
         U __real_close
         U __real_connect
         U __real_ftruncate
         U __real_getpeername
         U __real_getsockname
         U __real_getsockopt
         U __real_ioctl
         U __real_listen
         U __real_mmap
         U __real_munmap
         U __real_open
         U __real_pthread_create
         U __real_pthread_getschedparam
         U __real_pthread_setschedparam
         U __real_read
         U __real_recv
         U __real_recvfrom
         U __real_recvmsg
         U __real_sched_yield
         U __real_sem_destroy
         U __real_sem_init
         U __real_sem_post
         U __real_sem_wait
         U __real_send
         U __real_sendmsg
         U __real_sendto
         U __real_setsockopt
         U __real_shutdown
         U __real_socket
         U __real_write
0000ddd4 D __rtdm_fd_start
0000ddd8 D __rtdm_muxid
00004558 T __shm_close
         U sigaction
         U sigemptyset
         U signal
         U stderr
         U strerror
         U strncmp
000057f8 t __udivsi3
000055d0 T __wrap_accept
000053f8 T __wrap_bind
000033fc T __wrap_clock_getres
00003458 T __wrap_clock_gettime
0000350c T __wrap_clock_nanosleep
000034b4 T __wrap_clock_settime
00004ba0 T __wrap_close
00005494 T __wrap_connect
00004360 T __wrap_ftruncate
0000575c T __wrap_getpeername
000056c0 T __wrap_getsockname
00005298 T __wrap_getsockopt
00004c70 T __wrap_ioctl
0000554c T __wrap_listen
000043d8 T __wrap_mmap
00003ac0 T __wrap_mq_close
00003b70 T __wrap_mq_getattr
00003e84 T __wrap_mq_notify
00003a00 T __wrap_mq_open
00003d58 T __wrap_mq_receive
00003c30 T __wrap_mq_send
00003bcc T __wrap_mq_setattr
00003dec T __wrap_mq_timedreceive
00003cc4 T __wrap_mq_timedsend
00003b20 T __wrap_mq_unlink
000045b8 T __wrap_munmap
00003584 T __wrap_nanosleep
0000481c T __wrap_open
000035f8 T __wrap_pthread_condattr_destroy
00003638 T __wrap_pthread_condattr_getclock
000036c0 T __wrap_pthread_condattr_getpshared
000035b8 T __wrap_pthread_condattr_init
0000367c T __wrap_pthread_condattr_setclock
00003704 T __wrap_pthread_condattr_setpshared
000039c0 T __wrap_pthread_cond_broadcast
0000378c T __wrap_pthread_cond_destroy
00003748 T __wrap_pthread_cond_init
00003984 T __wrap_pthread_cond_signal
000038c4 T __wrap_pthread_cond_timedwait
0000380c T __wrap_pthread_cond_wait
00002b08 T __wrap_pthread_create
000029b4 T __wrap_pthread_getschedparam
00003f08 T __wrap_pthread_mutexattr_destroy
00003fd0 T __wrap_pthread_mutexattr_getprotocol
00004058 T __wrap_pthread_mutexattr_getpshared
00003f48 T __wrap_pthread_mutexattr_gettype
00003ec8 T __wrap_pthread_mutexattr_init
00004014 T __wrap_pthread_mutexattr_setprotocol
0000409c T __wrap_pthread_mutexattr_setpshared
00003f8c T __wrap_pthread_mutexattr_settype
00004124 T __wrap_pthread_mutex_destroy
000040e0 T __wrap_pthread_mutex_init
00004164 T __wrap_pthread_mutex_lock
000041a8 T __wrap_pthread_mutex_timedlock
000041f4 T __wrap_pthread_mutex_trylock
00004234 T __wrap_pthread_mutex_unlock
000028d8 T __wrap_pthread_setschedparam
00002c68 T __wrap_pthread_yield
00004d1c T __wrap_read
000050d4 T __wrap_recv
00004a04 T __wrap_recvfrom
00004e84 T __wrap_recvmsg
00002c1c T __wrap_sched_yield
00003324 T __wrap_sem_close
00003004 T __wrap_sem_destroy
000031fc T __wrap_sem_getvalue
00002fa4 T __wrap_sem_init
00003258 T __wrap_sem_open
00003058 T __wrap_sem_post
00003128 T __wrap_sem_timedwait
000031ac T __wrap_sem_trywait
000033a8 T __wrap_sem_unlink
000030ac T __wrap_sem_wait
000051b8 T __wrap_send
00004f38 T __wrap_sendmsg
00004fe8 T __wrap_sendto
00005348 T __wrap_setsockopt
00004274 T __wrap_shm_open
0000430c T __wrap_shm_unlink
00004b1c T __wrap_shutdown
00004938 T __wrap_socket
00002dd0 T __wrap_timer_create
00002e34 T __wrap_timer_delete
00002f4c T __wrap_timer_getoverrun
00002ef0 T __wrap_timer_gettime
00002e84 T __wrap_timer_settime
00004dd0 T __wrap_write
00002454 t xeno_handle_mlock_alert
0000dde0 V xeno_sigxcpu_no_mlock


On 5/31/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Perrine Martignoni wrote:
> > I tried to put essai_mutex.c before the flags but it's the same thing.
> >
> > It compiles with no problem, and after when I want to launch it on my
> > board I have the error about __real_sem_init.
> >
> > I noticed that with cyclictest it's the same. When I want to launch the
> > application, I have the same error :
> > can't resolve symbol '__real_sem_init'
>
> __real_sem_init should be defined by wrappers.o in libpthread_rt.so,
> what does nm libpthread_rt.so say ?
>
> --
>                                                 Gilles Chanteperdrix
>

------=_Part_2257_26480560.1180682268663
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>&gt;__real_sem_init should be defined by wrappers.o in libpthread_rt.so,<br>&gt;what does nm libpthread_rt.so say ?<br>&nbsp;</div>
<div>Here is the result of nm libpthread_rt.so : </div>
<div>&nbsp;</div>
<div>$ nm libpthread_rt.so<br>0000202c t $a<br>00005974 t $a<br>0000235c t $a<br>000023fc t $a<br>00005978 t $a<br>0000244c t $a<br>00002030 t $a<br>00005924 t $a<br>0000596c t $a<br>00002034 t $a<br>00002038 t $a<br>0000597c t $a
<br>00002454 t $a<br>000024ec t $a<br>00002884 t $a<br>000028d8 t $a<br>000029b4 t $a<br>00002a24 t $a<br>00002b08 t $a<br>00002c1c t $a<br>00002c68 t $a<br>00002cb4 t $a<br>00002d18 t $a<br>00002d8c t $a<br>00002dd0 t $a
<br>00002e34 t $a<br>00002e84 t $a<br>00002ef0 t $a<br>00002f4c t $a<br>00002fa4 t $a<br>00003004 t $a<br>00003058 t $a<br>000030ac t $a<br>00003128 t $a<br>000031ac t $a<br>000031fc t $a<br>00003258 t $a<br>00003324 t $a
<br>000033a8 t $a<br>000033fc t $a<br>00003458 t $a<br>000034b4 t $a<br>0000350c t $a<br>00003584 t $a<br>000035b8 t $a<br>000035f8 t $a<br>00003638 t $a<br>0000367c t $a<br>000036c0 t $a<br>00003704 t $a<br>00003748 t $a
<br>0000378c t $a<br>000037cc t $a<br>0000380c t $a<br>000038c4 t $a<br>00003984 t $a<br>000039c0 t $a<br>00003a00 t $a<br>00003ac0 t $a<br>00003b20 t $a<br>00003b70 t $a<br>00003bcc t $a<br>00003c30 t $a<br>00003cc4 t $a
<br>00003d58 t $a<br>00003dec t $a<br>00003e84 t $a<br>00003ec8 t $a<br>00003f08 t $a<br>00003f48 t $a<br>00003f8c t $a<br>00003fd0 t $a<br>00004014 t $a<br>00004058 t $a<br>0000409c t $a<br>000040e0 t $a<br>00004124 t $a
<br>00004164 t $a<br>000041a8 t $a<br>000041f4 t $a<br>00004234 t $a<br>00004274 t $a<br>0000430c t $a<br>00004360 t $a<br>000043d8 t $a<br>00004558 t $a<br>000045b8 t $a<br>00004684 t $a<br>000046e8 t $a<br>00004738 t $a
<br>000047c0 t $a<br>0000481c t $a<br>00004938 t $a<br>00004a04 t $a<br>00004b1c t $a<br>00004ba0 t $a<br>00004c70 t $a<br>00004d1c t $a<br>00004dd0 t $a<br>00004e84 t $a<br>00004f38 t $a<br>00004fe8 t $a<br>000050d4 t $a
<br>000051b8 t $a<br>00005298 t $a<br>00005348 t $a<br>000053f8 t $a<br>00005494 t $a<br>0000554c t $a<br>000055d0 t $a<br>000056c0 t $a<br>0000575c t $a<br>000057f8 t $a<br>00005908 t $a<br>000058f0 t __aeabi_uidivmod<br>
0000ddf0 A __bss_end__<br>0000ddf0 A _bss_end__<br>0000dde4 A __bss_start<br>0000dde4 A __bss_start__<br>0000596c t call___do_global_ctors_aux<br>000023fc t call___do_global_dtors_aux<br>0000244c t call_frame_dummy<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U close
<br>0000dde4 b completed.3705<br>0000dba8 d __CTOR_END__<br>0000dba0 d __CTOR_LIST__<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; w __cxa_finalize<br>0000dba0 d $d<br>0000dbac d $d<br>0000ddcc d $d<br>0000ddd0 d $d<br>000023e8 t $d<br>00002440 t $d<br>00005964 t $d
<br>0000ddd4 d $d<br>000024dc t $d<br>00002828 t $d<br>0000dba4 d $d<br>000028c8 t $d<br>000029a0 t $d<br>00002a18 t $d<br>00002af4 t $d<br>00002c14 t $d<br>00002c5c t $d<br>00002cac t $d<br>00002d0c t $d<br>00002d7c t $d
<br>00002dc4 t $d<br>00002e28 t $d<br>00002e7c t $d<br>00002ee4 t $d<br>00002f40 t $d<br>00002f98 t $d<br>00002ffc t $d<br>0000304c t $d<br>000030a0 t $d<br>0000311c t $d<br>000031a0 t $d<br>000031f4 t $d<br>0000324c t $d
<br>0000331c t $d<br>0000339c t $d<br>000033f0 t $d<br>0000344c t $d<br>000034a8 t $d<br>00003504 t $d<br>00003578 t $d<br>000035ec t $d<br>0000362c t $d<br>00003670 t $d<br>000036b8 t $d<br>000036f8 t $d<br>0000373c t $d
<br>00003784 t $d<br>000037c0 t $d<br>00003800 t $d<br>000038b4 t $d<br>00003974 t $d<br>000039b8 t $d<br>000039f4 t $d<br>00003ab0 t $d<br>00003b14 t $d<br>00003b68 t $d<br>00003bc0 t $d<br>00003c24 t $d<br>00003cb8 t $d
<br>00003d50 t $d<br>00003de0 t $d<br>00003e78 t $d<br>00003ec0 t $d<br>00003efc t $d<br>00003f3c t $d<br>00003f80 t $d<br>00003fc8 t $d<br>00004008 t $d<br>0000404c t $d<br>00004090 t $d<br>000040d8 t $d<br>00004118 t $d
<br>00004158 t $d<br>000041a0 t $d<br>000041e8 t $d<br>00004228 t $d<br>00004268 t $d<br>000042fc t $d<br>00004354 t $d<br>000043d0 t $d<br>00004548 t $d<br>000045ac t $d<br>00004678 t $d<br>000046dc t $d<br>00004730 t $d
<br>000047b4 t $d<br>00004810 t $d<br>00004924 t $d<br>000049f4 t $d<br>00004b0c t $d<br>00004b90 t $d<br>00004c60 t $d<br>00004d10 t $d<br>00004dc0 t $d<br>00004e74 t $d<br>00004f28 t $d<br>00004fdc t $d<br>000050c8 t $d
<br>000051a8 t $d<br>0000528c t $d<br>00005338 t $d<br>000053e8 t $d<br>00005484 t $d<br>0000553c t $d<br>000055c0 t $d<br>000056b0 t $d<br>0000574c t $d<br>000057e8 t $d<br>0000ddcc D __data_start<br>00005908 t __div0<br>
00005924 t __do_global_ctors_aux<br>0000235c t __do_global_dtors_aux<br>0000ddcc d __dso_handle<br>0000dbb0 d __DTOR_END__<br>0000dbac d __DTOR_LIST__<br>0000dbb8 A _DYNAMIC<br>0000dde4 A _edata<br>0000ddf0 A _end<br>0000ddf0 A __end__
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __errno_location<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U exit<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U fflush<br>00005974 T _fini<br>0000dde8 b fork_handler_registered<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U fprintf<br>00002404 t frame_dummy<br>00005b9c r __FRAME_END__<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U free
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U fwrite<br>0000dc70 a _GLOBAL_OFFSET_TABLE_<br>0000202c T _init<br>000024ec t __init_posix_interface<br>0000dbb4 d __JCR_END__<br>0000dbb4 d __JCR_LIST__<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; w _Jv_RegisterClasses<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U malloc
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U mlockall<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U mprotect<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U munlockall<br>0000ddec b old_sigharden_handler<br>0000ddd0 d p.3704<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U perror<br>0000dddc D __pse51_muxid<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U pthread_atfork<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U pthread_attr_getinheritsched
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U pthread_attr_getschedparam<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U pthread_attr_getschedpolicy<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U _pthread_cleanup_pop<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U _pthread_cleanup_push<br>000037cc t __pthread_cond_cleanup<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U pthread_exit<br>
00004684 T pthread_intr_attach_np<br>000047c0 T pthread_intr_control_np<br>000046e8 T pthread_intr_detach_np<br>00004738 T pthread_intr_wait_np<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U pthread_kill<br>00002c6c T pthread_make_periodic_np<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U pthread_self
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U pthread_setcanceltype<br>00002d18 T pthread_set_mode_np<br>00002d8c T pthread_set_name_np<br>00002884 t __pthread_sigharden_handler<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U pthread_testcancel<br>00002a24 t __pthread_trampoline<br>00002cb4 T pthread_wait_np
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_accept<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_bind<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_close<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_connect<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_ftruncate<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_getpeername<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_getsockname<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_getsockopt
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_ioctl<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_listen<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_mmap<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_munmap<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_open<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_pthread_create<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_pthread_getschedparam<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_pthread_setschedparam
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_read<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_recv<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_recvfrom<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_recvmsg<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_sched_yield<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_sem_destroy<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_sem_init<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_sem_post
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_sem_wait<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_send<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_sendmsg<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_sendto<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_setsockopt<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_shutdown<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_socket<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U __real_write
<br>0000ddd4 D __rtdm_fd_start<br>0000ddd8 D __rtdm_muxid<br>00004558 T __shm_close<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U sigaction<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U sigemptyset<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U signal<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U stderr<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U strerror<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U strncmp<br>
000057f8 t __udivsi3<br>000055d0 T __wrap_accept<br>000053f8 T __wrap_bind<br>000033fc T __wrap_clock_getres<br>00003458 T __wrap_clock_gettime<br>0000350c T __wrap_clock_nanosleep<br>000034b4 T __wrap_clock_settime<br>00004ba0 T __wrap_close
<br>00005494 T __wrap_connect<br>00004360 T __wrap_ftruncate<br>0000575c T __wrap_getpeername<br>000056c0 T __wrap_getsockname<br>00005298 T __wrap_getsockopt<br>00004c70 T __wrap_ioctl<br>0000554c T __wrap_listen<br>000043d8 T __wrap_mmap
<br>00003ac0 T __wrap_mq_close<br>00003b70 T __wrap_mq_getattr<br>00003e84 T __wrap_mq_notify<br>00003a00 T __wrap_mq_open<br>00003d58 T __wrap_mq_receive<br>00003c30 T __wrap_mq_send<br>00003bcc T __wrap_mq_setattr<br>00003dec T __wrap_mq_timedreceive
<br>00003cc4 T __wrap_mq_timedsend<br>00003b20 T __wrap_mq_unlink<br>000045b8 T __wrap_munmap<br>00003584 T __wrap_nanosleep<br>0000481c T __wrap_open<br>000035f8 T __wrap_pthread_condattr_destroy<br>00003638 T __wrap_pthread_condattr_getclock
<br>000036c0 T __wrap_pthread_condattr_getpshared<br>000035b8 T __wrap_pthread_condattr_init<br>0000367c T __wrap_pthread_condattr_setclock<br>00003704 T __wrap_pthread_condattr_setpshared<br>000039c0 T __wrap_pthread_cond_broadcast
<br>0000378c T __wrap_pthread_cond_destroy<br>00003748 T __wrap_pthread_cond_init<br>00003984 T __wrap_pthread_cond_signal<br>000038c4 T __wrap_pthread_cond_timedwait<br>0000380c T __wrap_pthread_cond_wait<br>00002b08 T __wrap_pthread_create
<br>000029b4 T __wrap_pthread_getschedparam<br>00003f08 T __wrap_pthread_mutexattr_destroy<br>00003fd0 T __wrap_pthread_mutexattr_getprotocol<br>00004058 T __wrap_pthread_mutexattr_getpshared<br>00003f48 T __wrap_pthread_mutexattr_gettype
<br>00003ec8 T __wrap_pthread_mutexattr_init<br>00004014 T __wrap_pthread_mutexattr_setprotocol<br>0000409c T __wrap_pthread_mutexattr_setpshared<br>00003f8c T __wrap_pthread_mutexattr_settype<br>00004124 T __wrap_pthread_mutex_destroy
<br>000040e0 T __wrap_pthread_mutex_init<br>00004164 T __wrap_pthread_mutex_lock<br>000041a8 T __wrap_pthread_mutex_timedlock<br>000041f4 T __wrap_pthread_mutex_trylock<br>00004234 T __wrap_pthread_mutex_unlock<br>000028d8 T __wrap_pthread_setschedparam
<br>00002c68 T __wrap_pthread_yield<br>00004d1c T __wrap_read<br>000050d4 T __wrap_recv<br>00004a04 T __wrap_recvfrom<br>00004e84 T __wrap_recvmsg<br>00002c1c T __wrap_sched_yield<br>00003324 T __wrap_sem_close<br>00003004 T __wrap_sem_destroy
<br>000031fc T __wrap_sem_getvalue<br>00002fa4 T __wrap_sem_init<br>00003258 T __wrap_sem_open<br>00003058 T __wrap_sem_post<br>00003128 T __wrap_sem_timedwait<br>000031ac T __wrap_sem_trywait<br>000033a8 T __wrap_sem_unlink
<br>000030ac T __wrap_sem_wait<br>000051b8 T __wrap_send<br>00004f38 T __wrap_sendmsg<br>00004fe8 T __wrap_sendto<br>00005348 T __wrap_setsockopt<br>00004274 T __wrap_shm_open<br>0000430c T __wrap_shm_unlink<br>00004b1c T __wrap_shutdown
<br>00004938 T __wrap_socket<br>00002dd0 T __wrap_timer_create<br>00002e34 T __wrap_timer_delete<br>00002f4c T __wrap_timer_getoverrun<br>00002ef0 T __wrap_timer_gettime<br>00002e84 T __wrap_timer_settime<br>00004dd0 T __wrap_write
<br>00002454 t xeno_handle_mlock_alert<br>0000dde0 V xeno_sigxcpu_no_mlock<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 5/31/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Perrine Martignoni wrote:<br>&gt; I tried to put essai_mutex.c before the flags but it&#39;s the same thing.
<br>&gt;<br>&gt; It compiles with no problem, and after when I want to launch it on my<br>&gt; board I have the error about __real_sem_init.<br>&gt;<br>&gt; I noticed that with cyclictest it&#39;s the same. When I want to launch the
<br>&gt; application, I have the same error :<br>&gt; can&#39;t resolve symbol &#39;__real_sem_init&#39;<br><br>__real_sem_init should be defined by wrappers.o in libpthread_rt.so,<br>what does nm libpthread_rt.so say ?<br>
<br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix<br></blockquote></div><br>

------=_Part_2257_26480560.1180682268663--

