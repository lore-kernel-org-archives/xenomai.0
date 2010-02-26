Message-ID: <4B881E9D.1050101@domain.hid>
Date: Fri, 26 Feb 2010 20:18:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1Nl4tX-0001N9-Hb@domain.hid>
In-Reply-To: <E1Nl4tX-0001N9-Hb@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : RTDM+POSIX: Avoid
 leaking binding objects on errors
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai core <Xenomai-core@domain.hid>

GIT version control wrote:
> diff --git a/ksrc/skins/posix/mq.c b/ksrc/skins/posix/mq.c
> index 11f47c0..a896031 100644
> --- a/ksrc/skins/posix/mq.c
> +++ b/ksrc/skins/posix/mq.c
> @@ -1283,6 +1283,7 @@ int pse51_mq_select_bind(mqd_t fd, struct xnselector *selector,
>  	return 0;
>  
>        unlock_and_error:
> +	xnfree(binding):
>  	xnlock_put_irqrestore(&nklock, s);
>  	return err;
>  }

Ok. Will pull. But I really need to fix that.

-- 
					    Gilles.

