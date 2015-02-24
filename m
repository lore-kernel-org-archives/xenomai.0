Message-ID: <54EC8CBD.6000500@xenomai.org>
Date: Tue, 24 Feb 2015 15:37:49 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CANWkrRPBG=3+k4GkcrMEO4fBb=tmvn+XKRR6t8S+p+r_ffm6vg@mail.gmail.com>
 <54EB4E8E.8040804@xenomai.org>
 <CAB+DZ3=s-pHrt=U_YN5qYo7Vtic9f-WfQQBwK3znBTdN_iVOmw@mail.gmail.com>
In-Reply-To: <CAB+DZ3=s-pHrt=U_YN5qYo7Vtic9f-WfQQBwK3znBTdN_iVOmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Failed testsuite/latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bart Vissers <bvissers@e2mtechnologies.eu>
Cc: Michael Smith <2michael.smith@gmail.com>, xenomai@xenomai.org

On 02/24/2015 02:28 PM, Bart Vissers wrote:
> Hi,
> 
> I ran into the exact same error. My setup:
> - xenomai_3.0rc3
> - Linux kernel 3.16.7 with ipipe-core-3.16-x86-2.patch
> I only deviated from the default build guide to build debian packages.
> 
> Attached, is the kernel config, dmesg log (no errors) and strace output.
> 

I can't reproduce it, so I will need more information.

Could you send the output of the following command on your target?

# xeno-config --info

I would also need a portion of the namelist of the latency binary, e.g.

$ nm $XENOMAI_ROOT/bin/latency | grep __wrap
         U __wrap_clock_gettime
         U __wrap_close
         U __wrap_fclose
         U __wrap_fprintf
         U __wrap_free
         U __wrap_fwrite
         U __wrap_ioctl
         U __wrap_kill
         U __wrap_open
         U __wrap_printf
         U __wrap_pthread_create
         U __wrap_pthread_join
         U __wrap_pthread_setname_np
         U __wrap_puts
         U __wrap_read
         U __wrap_sem_close
         U __wrap_sem_open
         U __wrap_sem_post
         U __wrap_sem_unlink
         U __wrap_sem_wait
         U __wrap_time
         U __wrap_timerfd_create
         U __wrap_timerfd_settime
         U __wrap_write

And finally, could you patch this snippet into the target kernel, then
report any message that might appear in the log once latency has exited
on failure?

diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index 7f35ea3..a65f6a0 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -210,6 +210,8 @@ struct rtdm_fd *rtdm_fd_get(int ufd, unsigned int magic)
 	xnlock_get_irqsave(&fdtree_lock, s);
 	fd = fetch_fd(p, ufd);
 	if (fd == NULL || (magic != 0 && fd->magic != magic)) {
+		printk(XENO_WARNING "%s: bad ufd=%d, magic=%#x\n",
+		       __func__, ufd, fd ? fd->magic : 0xfefefefe);
 		fd = ERR_PTR(-EBADF);
 		goto out;
 	}

-- 
Philippe.

