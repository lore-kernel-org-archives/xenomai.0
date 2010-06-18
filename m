Message-ID: <4C1B7EB1.2040006@domain.hid>
Date: Fri, 18 Jun 2010 16:12:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikU5zPKew64ZxWGokwh5R5F-sNegWdDzOENWdzB@mail.gmail.com>
In-Reply-To: <AANLkTikU5zPKew64ZxWGokwh5R5F-sNegWdDzOENWdzB@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] problem in pthread_mutex_lock/unlock
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Nero Fernandez <grimlynch@domain.hid>
Cc: xenomai@xenomai.org

Nero Fernandez wrote:
> Hi,
> 
> Please find an archive attached, containing :
>  - a program for testing context-switch-latency using posix-APIs
>    for native linux kernel and xenomai-posix-skin (userspace).
>  - Makefile to build it using xenomai

Your program is very long to tell fast. But it seems you are using the
mutex as if they were recursive. Xenomai posix skin mutexes used to be
recursive by default, but no longer are.

Also note that your code does not check the return value of the posix
skin services, which is a really bad idea.

-- 
					    Gilles.

