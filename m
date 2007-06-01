MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18015.52016.943527.960213@domain.hid>
Date: Fri, 1 Jun 2007 09:30:56 +0200
In-Reply-To: <7289437c0706010017s1250245nd9a39f0f471e493a@domain.hid>
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>
	<7289437c0705310558y6e1b4f8fue26c640d863ae041@domain.hid>
	<465EC7C1.5080300@domain.hid> <465ECDEC.1030109@domain.hid>
	<465ECFCA.1070801@domain.hid> <465ED806.2060608@domain.hid>
	<7289437c0705310758o3512e5e5x4c1a6d1df444be63@domain.hid>
	<465EE3BC.7020905@domain.hid>
	<7289437c0705310833m40dcef0bt188a4b3e33f4c014@domain.hid>
	<465EEDC3.6040309@domain.hid>
	<7289437c0706010017s1250245nd9a39f0f471e493a@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

Perrine Martignoni wrote:
 > >__real_sem_init should be defined by wrappers.o in libpthread_rt.so,
 > >what does nm libpthread_rt.so say ?
 > 
 > Here is the result of nm libpthread_rt.so :
 > 
 >          U __real_accept
 >          U __real_bind
 >          U __real_close
 >          U __real_connect
 >          U __real_ftruncate
 >          U __real_getpeername
 >          U __real_getsockname
 >          U __real_getsockopt
 >          U __real_ioctl
 >          U __real_listen
 >          U __real_mmap
 >          U __real_munmap
 >          U __real_open
 >          U __real_pthread_create
 >          U __real_pthread_getschedparam
 >          U __real_pthread_setschedparam
 >          U __real_read
 >          U __real_recv
 >          U __real_recvfrom
 >          U __real_recvmsg
 >          U __real_sched_yield
 >          U __real_sem_destroy
 >          U __real_sem_init
 >          U __real_sem_post
 >          U __real_sem_wait
 >          U __real_send
 >          U __real_sendmsg
 >          U __real_sendto
 >          U __real_setsockopt
 >          U __real_shutdown
 >          U __real_socket
 >          U __real_write

Looks like wrappers.c is missing. Could you show us the command line
used when xenomai builds libpthread_rt.so ?

-- 


					    Gilles Chanteperdrix.

