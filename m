Message-ID: <5291BD6B.3090903@xenomai.org>
Date: Sun, 24 Nov 2013 09:48:43 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <9bd00c3871dd96b26eaf.1385053376@devws164.be.alcatel-lucent.com>
In-Reply-To: <9bd00c3871dd96b26eaf.1385053376@devws164.be.alcatel-lucent.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Xenomai-forge: pSOS add priority denormalize
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kim De Mey <kim.demey@gmail.com>, xenomai@xenomai.org

On 11/21/2013 06:02 PM, Kim De Mey wrote:
> Add the psos_task_denormalize_priority() and psos_task_get_priority()
> functions. Use psos_task_get_priority() to fill oldprio_r in t_setpri().
>
> Signed-off-by: Kim De Mey <kim.demey@gmail.com>
>
> ---
>
> It is necessary to denormalize the oldprio_r in t_setpri(). Else this
> oldprio_r value can not be used if the user application overrides the
> normalize function.
>

Ack.

[snip]

> diff --git a/lib/psos/task.h b/lib/psos/task.h
> --- a/lib/psos/task.h
> +++ b/lib/psos/task.h
> @@ -71,6 +71,8 @@ void put_psos_task(struct psos_task *tas
>
>   int __ev_send(struct psos_task *task, unsigned long events);
>
> +int psos_task_get_priority(struct psos_task *task);
> +

Why do you have to introduce this routine in the API?

-- 
Philippe.

