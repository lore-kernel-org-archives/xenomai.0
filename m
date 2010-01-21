Message-ID: <4B58233A.4070708@domain.hid>
Date: Thu, 21 Jan 2010 10:49:46 +0100
From: Alexandre Coffignal <alexandre.coffignal@domain.hid>
MIME-Version: 1.0
References: <4B57134A.3090702@domain.hid> <4B5816E7.2080108@domain.hid>
In-Reply-To: <4B5816E7.2080108@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH] assert RTS signal during transmit in
 EIA-485 half duplex mode for 16550A compatible controllers.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hello,

Thanks you for your response.

I used this patch to communicate with a slave equipment in rs485 (modbus
protocol). The data is transmitted over a 2-wire twisted pair bus.
Master initiates all communication activity, by sending data. To do this
it must set RTS line to high state during all it's transmission. Before
slave answer, master must lower the RTS line.

my slave equipment answer in less than 200us, so i must know when xmit
is completing to lower the RTS line

An extension to RTSER_RTIOC_WAIT_EVENT may be a good solution but do you
know if an extension to RTSER_RTIOC_WAIT_EVENT can guarantee this timing?


Alexandre


Jan Kiszka a =E9crit :
> Alexandre Coffignal wrote:
>  =20
>> Hi,
>>
>> I make PATCH for the 16550A serial drivers.
>> It allow to assert RTS signal during transmit in EIA-485 half duplex
>> mode for 16550A compatible controllers.
>>
>> I have also modified the libmodbus-2.0.3 to be used with xenomai if=20
>> anyone is intesested// in this lib, please let me know
>>    =20
>
> Thanks for sharing your work! In general, I'm open to enhance the driver
> to support this, but find my question regarding the necessity below.
>
>  =20
>> Thanks, Alexandre
>>
>> From 0aa88d5d4fe5ab43f3069ab4dc8125d4a866f24c Mon Sep 17 00:00:00 2001
>> From: Alexandre Coffignal <alexandre.coffignal@domain.hid>
>> Date: Wed, 20 Jan 2010 15:13:39 +0100
>> Subject: [PATCH] rtdm : Allow to assert RTS signal during transmit in EI=
A-485 half duplex
>>  mode for 16550A compatible controllers.
>>    =20
>
> Short subject line + some separate description lines, please. If you are
> interesting in getting something integrated upstream, you would also
> have to add a signed-off line.
>
>  =20
>> ---
>>  include/rtdm/rtserial.h      |   34 ++++++++++++
>>  ksrc/drivers/serial/16550A.c |  115 +++++++++++++++++++++++++++++++++++=
+++++-
>>  ksrc/drivers/serial/Kconfig  |    7 +++
>>  3 files changed, 153 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/rtdm/rtserial.h b/include/rtdm/rtserial.h
>> index 48712b2..3a7b091 100644
>> --- a/include/rtdm/rtserial.h
>> +++ b/include/rtdm/rtserial.h
>> @@ -127,8 +127,13 @@
>>  #define RTSER_NO_HAND			0x00
>>  #define RTSER_RTSCTS_HAND		0x01
>>  #define RTSER_DEF_HAND			RTSER_NO_HAND
>> +#ifdef CONFIG_XENO_DRIVERS_16550A_RS485_HALF
>> +#define RTSER_RTS_RS485_HALF	0x02
>> +#endif
>>    =20
>
> A conditionally API in a user space header makes no sense. There is no
> technical reason to hide this in the
> !CONFIG_XENO_DRIVERS_16550A_RS485_HALF case, and user space will not
> even have this define set - so won't be able to use it.
>  =20
>>  /** @} */
>> =20
>> +
>> +
>>  /*!
>>   * @anchor RTSER_FIFO_xxx   @name RTSER_FIFO_xxx
>>   * Reception FIFO interrupt threshold
>> @@ -503,4 +508,33 @@ typedef struct rtser_event {
>> =20
>>  /** @} */
>> =20
>> +#ifdef CONFIG_XENO_DRIVERS_16550A_RS485_HALF
>> +
>> +typedef struct rs485_config
>> +{
>> +	nanosecs_rel_t delay_after_send;
>> +}rs485_config_t;
>>    =20
>
> In general no typedef, please, just a struct. But we could easily fold
> this field into existing rtser_config as we have flags to indicate which
> field is valid.
>
>  =20
>> +
>> +#define RS485_DEF_DELAY_AFTER_SEND	100000	//100uS
>> +
>> +/**
>> + * Set config for rs485 half duplex mode
>> + *
>> + * @param[in] arg New rs485 config content
>> + *
>> + * @return 0 on success, otherwise negative error code
>> + *
>> + * Environments:
>> + *
>> + * This service can be called from:
>> + *
>> + * - Kernel module initialization/cleanup code
>> + * - Kernel-based task
>> + * - User-space task (RT, non-RT)
>> + *
>> + * Rescheduling: never.
>> + */
>> +#define RTSER_RTIOC_RS485_SET_CONFIG \
>> +	_IOW(RTIOC_TYPE_SERIAL, 0x07, struct rs485_config)
>> +#endif
>>    =20
>
> No need for this then.
>
>  =20
>>  #endif /* _RTSERIAL_H */
>> diff --git a/ksrc/drivers/serial/16550A.c b/ksrc/drivers/serial/16550A.c
>> index db8a515..45c5cc3 100644
>> --- a/ksrc/drivers/serial/16550A.c
>> +++ b/ksrc/drivers/serial/16550A.c
>> @@ -107,6 +107,12 @@ struct rt_16550_context {
>>  	int mcr_status;			/* MCR cache */
>>  	int status;			/* cache for LSR + soft-states */
>>  	int saved_errors;		/* error cache for RTIOC_GET_STATUS */
>> +#ifdef CONFIG_XENO_DRIVERS_16550A_RS485_HALF
>> +	size_t bytes_send;		/* bytes sent on last tx it*/
>> +	rtdm_task_t rts_task;	/* task used to assert RTS signal during transmi=
t(rs485)*/
>> + 	rtdm_sem_t itTx;		/* raised to unblock rts task (rs485) */
>> + 	rs485_config_t rs485_config;		/* delay after TX frame before rts down=
 in nanosecond(rs485) */
>> +#endif
>>  };
>> =20
>>  static const struct rtser_config default_config =3D {
>> @@ -204,8 +210,16 @@ static inline void rt_16550_tx_interrupt(struct rt_=
16550_context *ctx)
>>  			ctx->out_head &=3D (OUT_BUFFER_SIZE - 1);
>>  		}
>>  	}
>> -}
>> +#ifdef CONFIG_XENO_DRIVERS_16550A_RS485_HALF
>> +	if(ctx->config.handshake=3D=3DRTSER_RTS_RS485_HALF)
>> +	{
>> +		/* up to unblock rts task in rs485 half duplex mode */
>> +		ctx->bytes_send=3Dctx->tx_fifo-count;
>> +		rtdm_sem_up(&ctx->itTx);
>> +	}
>> +#endif
>> =20
>> +}
>>  static inline void rt_16550_stat_interrupt(struct rt_16550_context *ctx)
>>  {
>>  	unsigned long base =3D ctx->base_addr;
>> @@ -409,10 +423,15 @@ static int rt_16550_set_config(struct rt_16550_con=
text *ctx,
>>  	if (testbits(config->config_mask, RTSER_SET_HANDSHAKE)) {
>>  		/* change handshake atomically */
>>  		rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
>> -
>>    =20
>
> Take care to avoid spurious whitespace changes.
>
>  =20
>>  		ctx->config.handshake =3D config->handshake;
>> =20
>>  		switch (ctx->config.handshake) {
>> +#ifdef CONFIG_XENO_DRIVERS_16550A_RS485_HALF
>> +		case RTSER_RTS_RS485_HALF:
>> +			ctx->mcr_status =3D
>> +			    RTSER_MCR_DTR | RTSER_MCR_RTS | RTSER_MCR_OUT2;
>> +			break;
>> +#endif
>>  		case RTSER_RTSCTS_HAND:
>>  			// ...?
>> =20
>> @@ -437,6 +456,51 @@ void rt_16550_cleanup_ctx(struct rt_16550_context *=
ctx)
>>  	rtdm_mutex_destroy(&ctx->out_lock);
>>  }
>> =20
>> +#ifdef CONFIG_XENO_DRIVERS_16550A_RS485_HALF
>> +#define RTS_STD_PRIO 1
>> +
>> +/* RS485
>> + * allow to put in transmit mode explicitly by asserting RTC signal to =
the driver during
>> + * transmission
>> + *
>> + * This allows EIA-485 to implement linear topologies using only two wi=
res
>> + *
>> + */
>> +void rts_task(void *arg)
>> +{
>> +	struct rt_16550_context *ctx=3D (struct rt_16550_context *)arg;
>> + 	int ret;
>> + 	nanosecs_rel_t delay ;
>> + 	char event=3D1;
>> +
>> + 	while(1){
>> + 		//wait sem up from itTx
>> + 		ret =3Drtdm_sem_down (&ctx->itTx);
>> + 		if(ret)
>> + 			printk("error rts_task... sem down error %d\n",ret);
>> +
>> + 		do{
>> + 			//wait end of transmission nbit + * fifo size / baud rate
>> + 			delay=3D11*ctx->bytes_send*1000000/ctx->config.baud_rate;
>> + 			ret=3Drtdm_sem_timeddown(&ctx->itTx, delay*1000+ctx->rs485_config.d=
elay_after_send,NULL);
>> +  			if(ret){
>> + 				if(ret!=3D-ETIMEDOUT){
>> + 					printk("error rts_task rtdm_event_timedwait... error %d\n",ret);
>> + 				}
>> + 				//no new rtdm event itTx receive during the transfert
>> + 				event=3D0;
>> + 			}
>> + 			else//new rtdm event itTx receive during the transfert, still waiti=
ng
>> + 				event=3D1;
>> +
>> + 		}while(event);
>> +		//down RTS
>> +		ctx->mcr_status &=3D ~RTSER_MCR_RTS;
>> +		rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx),ctx->base_addr, MCR, =
ctx->mcr_status);
>> +	}
>>    =20
>
> This task can't be terminated properly. So you risk all kinds of
> corruptions by enforcing this on close via rtdm_task_destroy. Most
> problematic: Deleting the sem and not breaking out of the loop will
> freeze your box (without an active Xenomai watchdog).
>
> However, can you describe to me as someone not really familiar with 485
> what it is doing? Also, what prevents running this job in user space,
> maybe extending the existing rtserial API a bit if something is missing
> to do so? Do you need some xmit completing indication? That would be an
> extension to RTSER_RTIOC_WAIT_EVENT then.
>  =20
>  =20
>> +}
>> +#endif
>> +
>>  int rt_16550_open(struct rtdm_dev_context *context,
>>  		  rtdm_user_info_t * user_info, int oflags)
>>  {
>> @@ -458,7 +522,9 @@ int rt_16550_open(struct rtdm_dev_context *context,
>>  	rt_16550_init_io_ctx(dev_id, ctx);
>> =20
>>  	ctx->tx_fifo =3D tx_fifo[dev_id];
>> -
>> +#ifdef CONFIG_XENO_DRIVERS_16550A_RS485_HALF
>> +	ctx->rs485_config.delay_after_send=3DRS485_DEF_DELAY_AFTER_SEND;
>> +#endif
>>  	ctx->in_head =3D 0;
>>  	ctx->in_tail =3D 0;
>>  	ctx->in_npend =3D 0;
>> @@ -475,6 +541,7 @@ int rt_16550_open(struct rtdm_dev_context *context,
>>  	ctx->status =3D 0;
>>  	ctx->saved_errors =3D 0;
>> =20
>> +
>>  	rt_16550_set_config(ctx, &default_config, &dummy);
>> =20
>>  	err =3D rtdm_irq_request(&ctx->irq_handle, irq[dev_id],
>> @@ -493,6 +560,17 @@ int rt_16550_open(struct rtdm_dev_context *context,
>> =20
>>  	rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
>> =20
>> +#ifdef CONFIG_XENO_DRIVERS_16550A_RS485_HALF
>> +	/* create semaphore used to unblock rts_task (rs485)*/
>> +	rtdm_sem_init(&ctx->itTx, 0);
>> +	/* create task used to assert RTS signal during transmit in (rs485)*/
>> +	err =3D rtdm_task_init(&ctx->rts_task, "rts_task", &rts_task,  ctx, RT=
S_STD_PRIO, 0);
>> +	if (err) {
>> +		printk("error rtdm_task_init\n");
>> +		return 0;
>> +	}
>> +#endif
>> +
>>  	/* enable interrupts */
>>  	ctx->ier_status =3D IER_RX;
>>  	rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx), ctx->base_addr, IER,
>> @@ -535,6 +613,11 @@ int rt_16550_close(struct rtdm_dev_context *context,
>> =20
>>  	rtdm_irq_free(&ctx->irq_handle);
>> =20
>> +#ifdef CONFIG_XENO_DRIVERS_16550A_RS485_HALF
>> +	rtdm_sem_destroy(&ctx->itTx);
>> +	rtdm_task_destroy(&ctx->rts_task);
>> +#endif
>> +
>>  	rt_16550_cleanup_ctx(ctx);
>> =20
>>  	if (in_history) {
>> @@ -802,6 +885,24 @@ int rt_16550_ioctl(struct rtdm_dev_context *context,
>>  		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
>>  		break;
>>  	}
>> +#ifdef CONFIG_XENO_DRIVERS_16550A_RS485_HALF
>> +	case RTSER_RTIOC_RS485_SET_CONFIG: {
>> +		struct rs485_config *config;
>> +		struct rs485_config config_buf;
>> +		config =3D (struct rtser_config *)arg;
>> +		if (user_info) {
>> +			err =3D rtdm_safe_copy_from_user(user_info, &config_buf,
>> +						     arg,
>> +						     sizeof(struct rs485_config));
>> +			if (err)
>> +				return err;
>> +
>> +			config =3D &config_buf;
>> +			ctx->rs485_config.delay_after_send=3Dconfig->delay_after_send;
>> +		}
>> +		break;
>> +#endif
>> +	}
>> =20
>>  	default:
>>  		err =3D -ENOTTY;
>> @@ -1005,6 +1106,14 @@ ssize_t rt_16550_write(struct rtdm_dev_context * =
context,
>>  	if (ret)
>>  		return ret;
>> =20
>> +#ifdef CONFIG_XENO_DRIVERS_16550A_RS485_HALF
>> +	if(ctx->config.handshake=3D=3DRTSER_RTS_RS485_HALF)
>> +	{
>> +		//assert RTS signal during transmit in rs485 half duplex mode
>> +		ctx->mcr_status |=3D RTSER_MCR_RTS;
>> +		rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx),ctx->base_addr, MCR, =
ctx->mcr_status);
>> +	}
>> +#endif
>>    =20
>
> Again my question: Does this have to be in the driver?
>
>  =20
>>  	while (nbyte > 0) {
>>  		rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
>> =20
>> diff --git a/ksrc/drivers/serial/Kconfig b/ksrc/drivers/serial/Kconfig
>> index afbaabf..95337bf 100644
>> --- a/ksrc/drivers/serial/Kconfig
>> +++ b/ksrc/drivers/serial/Kconfig
>> @@ -39,4 +39,11 @@ config XENO_DRIVERS_16550A_ANY
>> =20
>>  endchoice
>> =20
>> +config XENO_DRIVERS_16550A_RS485_HALF
>> +	depends on XENO_DRIVERS_16550A
>> +	bool "EIA-485 half duplex"
>> +	help
>> +	Assert RTS signal during transmit in EIA-485 half duplex mode
>> +	for 16550A compatible controllers.
>> +
>>  endmenu
>> -- 1.6.0.4
>>    =20
>
> Jan
>
>  =20

Thank

--=20
Alexandre COFFIGNAL, Chef de Projet
Email: alexandre.coffignal@domain.hid
<mailto:alexandre.coffignal@domain.hid>
------------------------------------
C=E9noSYS <http://www.cenosys.com>
10, Rue Xavier Bichat
F-72000 Le MANS
Tel: +33(0) 243 511 797
web : http://www.cenosys.com
------------------------------------
CONFIDENTIALITE : Ce message =E9lectronique et tous les fichiers attach=E9s
qu'il contient sont confidentiels et destin=E9s exclusivement =E0 l'usage de
la personne =E0 laquelle ils sont adress=E9s. Si vous avez re=E7u ce message
par erreur, merci de le retourner imm=E9diatement a son =E9metteur sans en
conserver de copie.

CONFIDENTIALITY : This e-mail and any attachments are confidential and
may also be privileged. If you are not the named recipient, please
notify the sender immediately and do not disclose the contents to an
other person, use it for any purpose, or store or copy the information
in any medium.

