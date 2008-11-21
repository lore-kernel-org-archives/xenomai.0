Message-ID: <492700CD.2050300@domain.hid>
Date: Fri, 21 Nov 2008 19:41:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4926E9C5.9020506@domain.hid>
In-Reply-To: <4926E9C5.9020506@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Refactor management of auto-shadowing,
 TLS and dlopen
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
> +#ifndef CONFIG_XENO_POSIX_AUTO_MLOCKALL
>  	if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
>  		perror("Xenomai Posix skin init: mlockall");
>  		exit(EXIT_FAILURE);
>  	}

Errr... I do not get it, the mlockall should take place if AUTO_MLOCKALL
is set, no ?

+		struct sched_param parm = { .sched_priority = 0 };

I do not like the everything-on-one-line style. And are we sure this
will work if sched_priority is a macro ?

-- 
                                                 Gilles.

