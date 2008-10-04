Message-ID: <48E787B6.5030205@domain.hid>
Date: Sat, 04 Oct 2008 17:11:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48E76494.9030901@domain.hid>
In-Reply-To: <48E76494.9030901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] gdb lockup on multi-threaded process exit
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
> +static int sigkill_pending(struct task_struct *tsk)
> +{
> +	return ((sigismember(&tsk->pending.signal, SIGKILL) ||
> +		 sigismember(&tsk->signal->shared_pending.signal, SIGKILL)) &&
> +		!unlikely(sigismember(&tsk->blocked, SIGKILL)));
> +}
> +

Posix says SIGKILL can not be blocked.

-- 
					    Gilles.

