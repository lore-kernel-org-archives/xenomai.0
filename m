Date: Mon, 23 Sep 2002 00:03:12 -0300
From: Arnaldo Carvalho de Melo <acme@domain.hid>
Message-ID: <20020923030312.GM20520@domain.hid>
References: <3D8E8371.D2070D87@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8E8371.D2070D87@domain.hid>
Subject: [Adeos-main] Re: [PATCH] Adeos nanokernel for 2.5.38 1/2: no-arch code
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.mail.freesoftware.fsf.org>
List-Unsubscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.freesoftware.fsf.org/pipermail/adeos-main/>
To: Karim Yaghmour <karim@domain.hid>
Cc: linux-kernel <linux-kernel@domain.hid>, Adeos <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

Em Sun, Sep 22, 2002 at 10:58:57PM -0400, Karim Yaghmour escreveu:
> diff -urpN linux-2.5.38/kernel/printk.c linux-2.5.38-adeos/kernel/printk.c
> --- linux-2.5.38/kernel/printk.c	Sun Sep 22 00:25:31 2002
> +++ linux-2.5.38-adeos/kernel/printk.c	Sun Sep 22 21:57:19 2002
> @@ -194,17 +194,33 @@ int do_syslog(int type, char * buf, int 
>  		if (error)
>  			goto out;
>  		i = 0;
> +#ifdef CONFIG_ADEOS
> +		ipipe_hw_spin_lock_disable(&logbuf_lock);
> +#else  /* !CONFIG_ADEOS */
>  		spin_lock_irq(&logbuf_lock);
> +#endif /* CONFIG_ADEOS */
>  		while ((log_start != log_end) && i < len) {
>  			c = LOG_BUF(log_start);
>  			log_start++;
> +#ifdef CONFIG_ADEOS
> +			ipipe_hw_spin_unlock_enable(&logbuf_lock);
> +#else  /* !CONFIG_ADEOS */
>  			spin_unlock_irq(&logbuf_lock);
> +#endif /* CONFIG_ADEOS */
>  			__put_user(c,buf);
>  			buf++;
>  			i++;
> +#ifdef CONFIG_ADEOS
> +			ipipe_hw_spin_lock_disable(&logbuf_lock);
> +#else  /* !CONFIG_ADEOS */
>  			spin_lock_irq(&logbuf_lock);
> +#endif /* CONFIG_ADEOS */
>  		}
> +#ifdef CONFIG_ADEOS
> +		ipipe_hw_spin_unlock_enable(&logbuf_lock);
> +#else  /* !CONFIG_ADEOS */
>  		spin_unlock_irq(&logbuf_lock);
> +#endif /* CONFIG_ADEOS */
>  		error = i;

Why this ifdef hell and not something like:

	lockbuf_lock();
	bla
	logbuf_unlock();

and have this defined in a header, say printk.h or whatever, with the
ifdefs?

- Arnaldo


