Message-ID: <49814ED3.9080607@domain.hid>
Date: Thu, 29 Jan 2009 07:38:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <ba9b368a0901282227i705ebe80oe75782ccc5cdc17f@domain.hid>
In-Reply-To: <ba9b368a0901282227i705ebe80oe75782ccc5cdc17f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem using sem_open and rt_sem_create
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Adams <dadams81@domain.hid>
Cc: xenomai@xenomai.org

Daniel Adams wrote:
> Hi *,
> 
> I'm fairly new to Xenomai and am having a few issues and was wondering if
> anyone could provide me with help
> 
> I have written some code to create a process which waits on a named
> semaphore and then there is another process which posts to it. I originally
> developed the code using the posix interface under a standard Linux
> environment and have proved it works.
> I have since ported the code so that the waiting half creates and waits on
> the semaphore using the native skin and the posting half uses the posix
> skin.
> 
> I tried naming the semaphore using the leading '/' as the posix standard
> suggests, but found that using the '/' causes the rt_sem_create(&rt_sem,
> SEM_NAME, 0, S_PULSE)  to return EINVAL. Removing the '/' allows the
> semaphore to be created but now when I try to open the semaphore
> with sem_open(SEM_NAME, O_EXCL), I get an error that the file doesn't exist.
> Is there something that I'm missing? I've check the registry and the
> semaphore appears under /proc/xenomai/registry/native/semaphores/.

The objects created by the two skins are completely separate.

-- 
					    Gilles.

