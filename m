Message-ID: <4C2F27C4.1050107@domain.hid>
Date: Sat, 03 Jul 2010 14:06:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>
	<1278071353-13836-7-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1278071353-13836-7-git-send-email-wolfgang.mauerer@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 6/7] posix: Userspace hostrt reading
 without switching to kernel mode
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Wolfgang Mauerer wrote:
>  int __wrap_clock_gettime(clockid_t clock_id, struct timespec *tp)
>  {
>  	int err;
> @@ -68,7 +128,11 @@ int __wrap_clock_gettime(clockid_t clock_id, struct timespec *tp)
>  		tp->tv_sec = xnarch_divrem_billion(ns, &rem);
>  		tp->tv_nsec = rem;
>  		return 0;
> +	} else if (clock_id == CLOCK_HOST_REALTIME) {
> +		err = __do_clock_host_realtime(tp, NULL);
> +		goto out;

	swich case here

-- 
					    Gilles.

