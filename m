Message-ID: <4C45F08A.6040307@domain.hid>
Date: Tue, 20 Jul 2010 20:52:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460F5995EE@exchserver.basler.com>
In-Reply-To: <181804936ABC2349BE503168465576460F5995EE@exchserver.basler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Stack size of shadowed thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

Steve Deiters wrote:
> What is the stack size of a thread shadowed with rt_task_shadow, or one
> that is already shadowed from main because it is linked against the
> POSIX skin?
> 
> Is there any way of adjusting the stack size that will be used when
> shadowing a thread?

This matter is not in the hands of Xenomai. The maximum main thread
stack size is determined by ulimit -s, but is mapped on demand. However
Xenomai faults a few Kbytes to avoid the faults getting in the way, if
the main thread is used as a real-time thread. If you need more, you
should fault the main thread stack yourself.

Non-main thread stack size is determined by the value passed to
pthread_attr_setstacksize when creating the thread with pthread_create.

-- 
					    Gilles.

