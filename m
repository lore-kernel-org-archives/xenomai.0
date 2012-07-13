Message-ID: <50007045.8040208@xenomai.org>
Date: Fri, 13 Jul 2012 21:00:21 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4FFF2C70.7080509@bollue.de>
In-Reply-To: <4FFF2C70.7080509@bollue.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Pool memory leak when writing to full queue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kai <mlist1@bollue.de>
Cc: xenomai@xenomai.org

On 07/12/2012 09:58 PM, Kai wrote:
> Hi,
>
> I have a problem using rt_queue_write() (native skin):
> As far as I understand, the function wraps around rt_queue_send() by
> allocating pool memory first and memcpy-ing the user-supplied buffer
> into it.
> Problem: If sending fails because the queue is full (w.r.t. the number
> of queued messages), the error is returned to the caller, but the
> allocated pool memory is never freed.
> The attached program shows how the pool memory gets almost completely
> filled without any messages left in the queue.
>
> The following patch seems to fix it:
>
> --- xenomai-2.6.1/ksrc/skins/native/syscall_old.c       2012-07-12
> 19:53:48.464968791 +0200
> +++ xenomai-2.6.1/ksrc/skins/native/syscall.c   2012-07-12
> 19:48:34.174968603 +0200
> @@ -2358,6 +2358,8 @@
>          ret = rt_queue_send(q, mbuf, size, mode);
>          if (ret == 0 && (mode & Q_BROADCAST))
>                  rt_queue_free(q, mbuf); /* Nobody received, free the
> buffer. */
> +       if (ret < 0) /* Send failed */
> +               rt_queue_free(q, mbuf);
>
>          return ret;
>   }

Ack. Picking this one for 2.6.2, thanks.

-- 
Philippe.



