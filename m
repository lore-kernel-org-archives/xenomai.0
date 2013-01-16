Message-ID: <50F6FA6D.7080709@siemens.com>
Date: Wed, 16 Jan 2013 20:07:25 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <50F6C3EE.1020508@siemens.com> <50F6C657.2060503@xenomai.org>
	<50F6C781.2060407@siemens.com> <50F6CCCE.2050801@siemens.com>
In-Reply-To: <50F6CCCE.2050801@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe: fix domain migration helper
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-01-16 16:52, Jan Kiszka wrote:
> @@ -1095,12 +1120,8 @@ int __ipipe_switch_tail(void)
>  	hard_local_irq_disable();
>  #endif
>  	x = __ipipe_root_p;
> -
> -#ifdef CONFIG_IPIPE_LEGACY
> -	current->state &= ~TASK_HARDENING;
> -#else
> -	complete_domain_migration();
> -#endif	/* !CONFIG_IPIPE_LEGACY */
> +	if (x)
> +		complete_domain_migration();

This seems wrong, at least for legacy: Now we no longer clear
TASK_HARDENING after the switch back from the gatekeeper because the
current domain is Xenomai then. Does the new migration scheme work
differently in this regard? Then we will have to keep the #ifdef.

Do I get this correctly that the patch did not target an issue with
legacy usage? Or is there still a problem that could also affect Xenomai
2.6?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

