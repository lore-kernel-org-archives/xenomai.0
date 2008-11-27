Message-ID: <492EF786.4040303@domain.hid>
Date: Thu, 27 Nov 2008 20:39:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081127175234.163sujmgcgcgs4gk@domain.hid>
In-Reply-To: <20081127175234.163sujmgcgcgs4gk@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Zombie user tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mehmet Alphan Ulusoy <alphan@domain.hid>
Cc: xenomai@xenomai.org

Mehmet Alphan Ulusoy wrote:
> void terminateGracefully(int sig)
> {
>      int err;
> 	    while (( err = rt_task_delete(&tid)) != 0)
> 	    {
> 	        printf("Error deleting task. Code %d.\n");
> 	    }
> 	    while (( err = rt_alarm_delete(&aid)) != 0)
> 	    {
> 	        printf("Error deleting alarm. Code %d.\n");
> 	    }
> 	    while (( err = rt_pipe_delete(&pidMon)) != 0)
> 	    {
> 	        printf("Error deleting pipe. Code %d.\n");
> 	    }
> 	    while (( err = close(sid)) != 0)
> 	    {
> 	        printf("Error deleting socket. Code %d.\n");
> 	    }
> 	}

This code is seriously broken. You risk an infinite loop which may brick
your box, if ever it happens over a thread with the SCHED_FIFO policy.
All these calls are not async signal safe, so should not be called in a
signal handler. Almost the only thing permitted in a signal handler is
to call sem_post, or to set a flag used by your application when a
syscall returns EINTR.

> - The child process which makes the system() call has a signal handler  
> installed for SIGCHILD signal and calls wait() to collect their exit  
> status.

The handler for SIGCHLD should be installed in the parent process, not
the children.

> 
> signal(SIGCHLD, waitChild);
> 
> void waitChild(int sig)
> {
> 
>      int status =0;
> 
>      wait(&status);
> 
> }

That is incorrect, you may receive SIGCHLD only once for several
children termination, so, you should call wait4 in non blocking mode
until it returns EWOULDBLOCK.

Or you should ignore explicitely SIGCHLD altogether, passing SIG_IGN to
signal or sigaction, Linux will then take care correctly of terminated
children.

> Is there a specific order to follow while deleting real-time entities?  
> Is the system() call or "pkill -SIGTERM" the problem?

why using system, why not using the kill service directly?

-- 
					    Gilles.

