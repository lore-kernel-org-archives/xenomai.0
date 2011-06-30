Message-ID: <4E0C5979.7020202@domain.hid>
Date: Thu, 30 Jun 2011 13:09:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E0C439D.2030602@domain.hid>
In-Reply-To: <4E0C439D.2030602@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 2/2] native: Fix error cleanup of
	rt_task_create
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 06/30/2011 11:36 AM, Jan Kiszka wrote:
> When creating of a shadow task fails, rt_task_create has to free the
> task object consistently, not only on registry errors. Then we need to
> delete the core thread when fastlock allocation failed. Moreover, fix a
> double free of the fastlock object which is now released via the delete
> hook. Finally, avoid a use-after-release of the fastlock object in
> __task_delete_hook.
> 
> This fixes heap corruptions when running out of resources.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> ---
> (...)
> +
> +      fail:
> +	if (xnthread_test_state(&task->thread_base, XNSHADOW))
> +		xnfree(task);
> +
> +	return err;
>  }
>  
>  /**

Is this needed? I mean, shadows are created in syscall.c, function
__rt_task_create, and when rt_task_create returns an error, that
function calls rt_task_delete. So, there should be no leak. And worse,
here rt_task_delete will use an invalid pointer if we apply that patch.

-- 
                                                                Gilles.

