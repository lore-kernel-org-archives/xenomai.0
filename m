Message-ID: <4DB5191A.9020801@domain.hid>
Date: Mon, 25 Apr 2011 08:47:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DB4DA61.9070906@domain.hid>
In-Reply-To: <4DB4DA61.9070906@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Calling rt_task_shadow from a POSIX thread with
 --enable-dlopen-skins
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Simon Leonard <sleonard@domain.hid>
Cc: xenomai@xenomai.org

Simon Leonard wrote:
> I have code based on the POSIX skin. For a (python related) reason, I 
> had to re-compile Xenomai with --enable-dlopen-skins. The result is that 
> unless I call rt_task_shadow, my threads don't work like they used to.

Mmmm. Normally, without --enable-dlopen-skins, only the main thread is
automatically made real-time.

> 
> Although I *think* my code works by mixing rt_task_shadow with the POSIX 
> skin I'm not convinced that it is legit. Can anybody advise?

It works, but, there are services in the POSIX skin which will only work
if the thread is a posix skin thread, not if it is a native skin thread.
Anyway, you can use pthread_setschedparam instead of rt_task_shadow.


-- 
                                                                Gilles.

