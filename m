From: steven.seeger flightsystems.net <steven.seeger@flightsystems.net>
Subject: Re: [PATCH] arm64/ipipe: Add support for userspace return notifier
Date: Wed, 9 Oct 2019 01:00:24 +0000
Message-ID: <1692186.oXRrdl6OMX@omoikane>
References: <e8d943ee-1103-07ec-bede-c36b4a06c745@siemens.com>
In-Reply-To: <e8d943ee-1103-07ec-bede-c36b4a06c745@siemens.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13CDD93D9BF86347AB1B3FD496B8275B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tuesday, October 8, 2019 12:55:36 PM EDT Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> This adds the arm64-specific bits to implement the userspace return
> notifier.
>=20
> @@ -954,8 +954,23 @@ finish_ret_to_user:
>  	enable_step_tsk x1, x2
>  #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>  	bl	stackleak_erase
> +#endif
> +#ifdef CONFIG_IPIPE
> +	ldr	x0, [tsk, #TSK_TI_IPIPE]
> +	tst	x0, #_TIP_USERINTRET
> +	b.ne	call_user_intret_notifier
> +exit_head:

Shouldn't exit_head: be a few lines up where work is checked? In other=20
patches, it seems _TIF_WORK_MASK is checked again after=20
ipipe_notify_user_intreturn returns 0.

>  #endif
>  	kernel_exit 0
> +#ifdef CONFIG_IPIPE
> +call_user_intret_notifier:
> +	enable_daif
> +	bl     	__ipipe_notify_user_intreturn
> +	disable_daif
> +	cmp    	x0, #0
> +	b.ne    exit_head
> +	b	ret_to_user_noirq
> +#endif
>  ENDPROC(ret_to_user)
>=20
>  /*




