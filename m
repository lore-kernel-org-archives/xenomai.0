Message-ID: <4DA463D2.9030502@domain.hid>
Date: Tue, 12 Apr 2011 16:38:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTikTWM75UZknkYRt=MeOUDJVsNmLAA@mail.gmail.com>
In-Reply-To: <BANLkTikTWM75UZknkYRt=MeOUDJVsNmLAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread exit and PTHREAD_WARNSW
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

Jeff Weber wrote:

Hi Jeff,

any news about the hostrt patch I sent you for x86_32? Does it work?

> From testing, I found that if I enable PTHREAD_WARNSW for a pthread, I must
> explicitly disable this mode before the thread terminates, or the thread
> draws a signal 24 SIGXCPU.

Yes, the problem is that we can put such migration if the thread
function returns, but it will not work in case pthread_exit is called.

> 
> I've tried to simplify my thread terminations by pushing a function which
> calls pthread_set_mode_np(PTHREAD_WARNSW, 0) onto the thread cleanup stack,
> and always terminating the thread via pthread_exit().  However, this method
> still draws a signal 24 SIGXCPU.    Here's a sample backtrace:

... and pthread_exit is basically a Linux service, so, we can not
guarantee that it does not make any syscall before executing the cleanup
handlers.

-- 
					    Gilles.

