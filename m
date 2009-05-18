Message-ID: <4A111CD7.4050206@domain.hid>
Date: Mon, 18 May 2009 10:31:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1242572097.17138.57.camel@domain.hid>
In-Reply-To: <1242572097.17138.57.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-core] Allow "break" statement in
	RTDM_EXECUTE_ATOMICALLY()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Jan,
> 
> Would you consider allowing "break" for leaving an atomic code block as
> illustrated below?
> 
> I understand this would create a potential issue with newer RTDM drivers
> relying on this feature when backported to former RTDM implementations,
> but only having if/else constructs to control the execution flow within
> an atomic block may be painful sometimes and lead to uselessly hairy
> code, especially for error handling.
> Maybe adding another helper macro with the desired behavior, and
> documenting it separately from RTDM_EXECUTE_ATOMICALLY() would mitigate
> the portability issue?
> 
> Additionally, I would definitely shadow/hide the spl value from the code
> block in a way or another, since using "s" as a socket identifier for
> RTDM-based protocol drivers is not that unusual.

I agree that "s" requires better encapsulation, that a do-while is a
good approach for this, and I would even change its name to something
like __rtdm_s.

But I don't think we should officially support "break" here (even if it
happens to work after refactoring). The macro does not expose explicit
"{ }" to the reader of the code that makes use of it (in contrast to
LIST_FOR_EACH-like helpers e.g.). Better use "goto" here, which is quite
common for error cleanup, too.

> 
> e.g.
> 
> diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
> index 058a9f8..18b6001 100644
> --- a/include/rtdm/rtdm_driver.h
> +++ b/include/rtdm/rtdm_driver.h
> @@ -595,14 +595,16 @@ int rtdm_select_bind(int fd, rtdm_selector_t *selector,
>  	<LEAVE_ATOMIC_SECTION>			\
>  }
>  #else /* This is how it really works */
> -#define RTDM_EXECUTE_ATOMICALLY(code_block)	\
> -{						\
> +#define RTDM_ATOMIC_BLOCK(code_block)		\
> +do {						\
>  	spl_t s;				\
> -						\
>  	xnlock_get_irqsave(&nklock, s);		\
> -	code_block;				\
> +	do {					\
> +	  code_block;				\
> +	} while(0);				\
>  	xnlock_put_irqrestore(&nklock, s);	\
> -}
> +} while(0)
> +#define RTDM_EXECUTE_ATOMICALLY(code_block)	RTDM_ATOMIC_BLOCK(code_block)
>  #endif
>  /** @} Global Lock across Scheduler Invocation */
>  

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

