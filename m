Date: Tue, 25 Jan 2011 12:32:52 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4D3E9D71.7040008@domain.hid>
Message-ID: <alpine.DEB.1.10.1101251228220.12329@domain.hid>
References: <alpine.DEB.1.10.1101251010320.12329@domain.hid>
	<4D3E97D5.3050609@domain.hid>
	<alpine.DEB.1.10.1101251049460.12329@domain.hid>
	<4D3E9D71.7040008@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] NULL pointer access on bfin when linking with
 xenomai and pthread
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> If not, recompile xenomai with --enable-debug, try and put a breakpoint
> on the function xeno_sigshadow_handler.  If you hit the breakpoint, try
> and execute the function step by step, looking whether a pointer could

I can only make it halt at pthread_sighandler_rt. To me it seems the attempt
to call the user handler fails, not the call itself

Breakpoint 2, pthread_sighandler_rt (signo=28, si=0x16bd3ac, uc=0x16bd42c) at libpthread/linuxthreads.old/signals.c:112
112	{
(gdb) next
113	  pthread_descr self = thread_self();
(gdb) next
117	  if (THREAD_GETMEM(self, p_sigwaiting)) {
(gdb) next
124	  in_sighandler = THREAD_GETMEM(self, p_in_sighandler);
(gdb) next
125	  if (in_sighandler == NULL)
(gdb) next
126	    THREAD_SETMEM(self, p_in_sighandler, CURRENT_STACK_FRAME);
(gdb) next
127	  sighandler[signo].rt(signo, si, uc);
(gdb) print signo
$1 = 28
(gdb) print si
$2 = (struct siginfo *) 0x16bd3ac
(gdb) print *si
$4 = {si_signo = 28, si_errno = 0, si_code = -1, _sifields = {_pad = {0, 0, 2, 0 <repeats 26 times>}, _kill = {
       si_pid = 0, si_uid = 0}, _timer = {si_tid = 0, si_overrun = 0, si_sigval = {sival_int = 2, sival_ptr = 0x2}},
     _rt = {si_pid = 0, si_uid = 0, si_sigval = {sival_int = 2, sival_ptr = 0x2}}, _sigchld = {si_pid = 0, si_uid = 0,
       si_status = 2, si_utime = 0, si_stime = 0}, _sigfault = {si_addr = 0x0}, _sigpoll = {si_band = 0, si_fd = 0}}}
(gdb) print uc
$3 = (struct ucontext *) 0x16bd42c
(gdb) print *uc
$5 = {uc_flags = 0, uc_link = 0x0, uc_stack = {ss_sp = 0x0, ss_flags = 2, ss_size = 0}, uc_mcontext = {gregs = {0,
       23844280, 23844140, 8, 23849124, 28, 23598632, 23844280, 174, 31, 23844140, 23598632, 23640412, 23844464, 23844100,
       0, 0, 0, 0, 33562689, 25097346, 24956702, 24956702, 23844112, 23844596, 1, 2, 6, 180, 1, 6146, 91, 0, 0, 0, 0, 311,
       192, 2147479552, 0, 0, 1023, 25035906, 24737144, 25035907, 24737185, 393216}}, uc_sigmask = {__val = {2147483648,
       0, 0, 0, 0, 23844420, 25097346, 23844280, 0, 0, 0, 8, 0, 0, 23139796, 0 <repeats 17 times>}}}
(gdb) print sighandler[signo]
$2 = {old = <error reading variable>, rt = <error reading variable>}
(gdb) print sighandler
$3 = {{old = <error reading variable>, rt = <error reading variable>} <repeats 24 times>, {
     old = @0x204a94: 0x15c965c <xeno_handle_mlock_alert>, rt = @0x204a94: 0x15c965c <xeno_handle_mlock_alert>}, {
     old = <error reading variable>, rt = <error reading variable>} <repeats 40 times>}
(gdb) step

Program received signal SIGSEGV, Segmentation fault.


Kolja


