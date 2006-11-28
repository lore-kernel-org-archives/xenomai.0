Message-ID: <456C887D.9040008@domain.hid>
Date: Tue, 28 Nov 2006 20:05:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <456C3EFB.7030303@domain.hid>
In-Reply-To: <456C3EFB.7030303@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [RFC][PATCH 2/2] global CPU affinity control
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
Cc: "M. Koehrer" <mathias_koehrer@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> This is version 4 of the /proc/xenomai/affinity feature. It has been
> rebased on the reworked xnshadow_map code, now applying the default
> affinity mask in a (hopefully) correct way also on shadow threads.
> 
> What has been said for the previous patch also applies here: test and
> comment! Mathias, you asked for this feature, please let us know if it
> fulfils your requirements.
> 
> Philippe, you were looking for documentation of this new behaviour.
> Please let me know where you would like to see this. Surely in the
> nucleus API, I guess. Anywhere else?
> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> (...)
> @@ -909,8 +911,8 @@ int xnpod_start_thread(xnthread_t *threa
>  	if (!testbits(thread->status, XNDORMANT))
>  		return -EBUSY;
>  
> -	if (xnarch_cpus_empty(affinity))
> -		affinity = XNARCH_CPU_MASK_ALL;
> +	if (xnarch_cpus_equal(affinity, XNPOD_ALL_CPUS))
> +		affinity = nkaffinity;

Should not this be:
	if (xnarch_cpus_empty(affinity))
		affinity = XNARCH_CPU_MASK_ALL;
	xnarch_cpus_and(affinity, affinity, nkaffinity);
	if (xnarch_cpus_empty(affinity))
		return -EINVAL;

so that no thread could escape the rule imposed by nkaffinity.

-- 
                                                 Gilles Chanteperdrix

