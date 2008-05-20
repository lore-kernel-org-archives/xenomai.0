Message-ID: <2ff1a98a0805200033t7cd428cfmc1b2d8264a51a2a1@domain.hid>
Date: Tue, 20 May 2008 09:33:16 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4B2EEE69E41E524EB7FCDC62A15D68D8018D0038@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4B2EEE69E41E524EB7FCDC62A15D68D8018D0038@domain.hid>
Subject: Re: [Xenomai-help] How to interrupt blocked thread in Linux domain
	from Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas.Debes@domain.hid
Cc: xenomai@xenomai.org

On Tue, May 20, 2008 at 9:19 AM,  <Thomas.Debes@domain.hid> wrote:
> Hi,
>
> what is best way to interrupt a blocked RT-Thread waiting on a Linux
> ressource in secondary mode (e.g. socket) from another NRT-Thread? I can
> successfully detect the blocked state via rt_task_inquire and testing if
> XNRELAX is being set. Is kill(pid, SIGINT) the right way to interrupt
> the blocking system call or are there better ways to do it?

The effect of SIGINT is global, it will unblock all threads in the
process. You have to use a custom signal (either SIGUSR1, SIGUSR1 or a
real-time signal, those from SIGRTMIN to SIGRTMAX), and define an
empty handler for this signal. Then use pthread_kill (instead of kill)
to kill only the proper thread.

-- 
 Gilles

