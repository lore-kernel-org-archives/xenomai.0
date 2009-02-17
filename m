Message-ID: <499AF09F.8040402@domain.hid>
Date: Tue, 17 Feb 2009 17:15:11 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20090217170418.1425.56126.stgit@domain.hid>
	<20090217170419.1425.15313.stgit@domain.hid>
In-Reply-To: <20090217170419.1425.15313.stgit@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v2 1/4] POSIX: Fix SCHED_RR thread
	creation
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> @@ -192,6 +192,9 @@ static void *__pthread_trampoline(void *arg)
>  
>  	param.sched_priority = iargs->prio;
>  	policy = iargs->policy;
> +	if (policy == SCHED_RR)
> +		/* Restrict round-robin scheduling to the Xenomai domain. */
> +		policy = SCHED_FIFO;

Should not there be the same thing in __wrap_pthread_setschedparam ?
-- 
                                                 Gilles.

