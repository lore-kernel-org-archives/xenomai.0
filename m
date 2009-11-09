Message-ID: <4AF816E0.9040809@domain.hid>
Date: Mon, 09 Nov 2009 14:19:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <ddc6e05e0911090400r37e0160aha2c3088dc673c0aa@domain.hid>
In-Reply-To: <ddc6e05e0911090400r37e0160aha2c3088dc673c0aa@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Context-sharing semaphores
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Remco den Breeje <remco@domain.hid>
Cc: xenomai@xenomai.org

Remco den Breeje wrote:
> Hi all,
> 
> I'm having trouble trying to share a semaphore that is created in
> user-space context with a rtdm-driver that runs in kernel-space. I was
> hoping you could explain me what I'm doing wrong.
> 
> I'm using a posix-skin based user-space Xenomai application that runs
> a loop which is triggered by a semaphore.
> This semaphore is posted by a pthread that runs at a specific
> frequency. However, I want to be able to synchronize this loop with an
> external hardware trigger that is read out by a rtdm-driver. To do so,
> I try to disable the semaphore-post in the user-mode pthread, and
> re-use the existing semaphore in kernel-mode (the rtdm-driver).
> Unfortunately, the rtdm-driver is not able to find the user-space
> created semaphore.
> 
> I wrote a little test-program to explain the problem. If required, I
> will post the complete test-program, but for now I will show some
> code-snippets.
> 
> In the user-space application a semphore is created using the sem_open sys-call:
> 
>   clockSem = sem_open(SEMNAME, O_CREAT, 0, 0);
> 
> clockSem, which is a pointer to sem_t returns an address (!= SEM_FAILED).
> With an ioctl-call I try to open the same semaphore in kernel-mode:
> 
>   sem_p = sem_open(SEMNAME, 0);
> 
> This fails. sem_p equals SEM_FAILED, and errno is set to 2 (ENOENT).
> 
> I'm runing Linux 2.6.29.4 x86 32bit, Xenomai 2.4.8, ipipe 2.4-01

This is supposed to work. Please post the full user-space and
kernel-space code so that we can investigate.

-- 
                                          Gilles


