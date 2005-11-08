Message-ID: <437071C7.2070606@domain.hid>
Date: Tue, 08 Nov 2005 10:37:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rt_task_receive DOKU
References: <200511081122.05916.schwab@domain.hid>
In-Reply-To: <200511081122.05916.schwab@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Ulrich Schwab <schwab@domain.hid>
Cc: xenomai@xenomai.org

Ulrich Schwab wrote:
> Hello,
> 
> here is a patch, making the doku of rt_task_receive()
> more complete.
> 
> 
> diff -Nru xenomai-2.0-orig/skins/native/task.c 
> xenomai-2.0-devel/skins/native/task.c
> --- xenomai-2.0-orig/skins/native/task.c	2005-10-08 16:26:07.000000000 +0200
> +++ xenomai-2.0-devel/skins/native/task.c	2005-11-08 11:00:27.000000000 +0100
> @@ -1788,6 +1788,8 @@
>   * and no remote task is currently waiting for sending a message to
>   * the caller.
>   *
> + * - -ETIMEDOUT is returned if no message was received within the @a timeout.
> + *
>   * - -EINTR is returned if rt_task_unblock() has been called for the
>   * caller before any message was available.
>   *
> 

Applied, thanks.

-- 

Philippe.

