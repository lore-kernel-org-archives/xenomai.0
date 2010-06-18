Message-ID: <4C1B8C04.3010900@domain.hid>
Date: Fri, 18 Jun 2010 17:08:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikU5zPKew64ZxWGokwh5R5F-sNegWdDzOENWdzB@mail.gmail.com>	<4C1B7EB1.2040006@domain.hid>	<AANLkTinABTK2nMI0QfZVaULQ4OKwF0678PKOBc_OMIn1@domain.hid>
	<AANLkTiklRlwsIJfelo0eT2GZDvI6PtDAwc4qluLCr6R5@domain.hid>
In-Reply-To: <AANLkTiklRlwsIJfelo0eT2GZDvI6PtDAwc4qluLCr6R5@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Fwd:  problem in pthread_mutex_lock/unlock
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
> 
> On Fri, Jun 18, 2010 at 7:42 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org
> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> 
>     Nero Fernandez wrote:
>     > Hi,
>     >
>     > Please find an archive attached, containing :
>     >  - a program for testing context-switch-latency using posix-APIs
>     >    for native linux kernel and xenomai-posix-skin (userspace).
>     >  - Makefile to build it using xenomai
> 
>     Your program is very long to tell fast. But it seems you are using the
>     mutex as if they were recursive. Xenomai posix skin mutexes used to be
>     recursive by default, but no longer are.
> 
>     Also note that your code does not check the return value of the posix
>     skin services, which is a really bad idea.
> 
>     --
>                                                Gilles.
> 
> 
> Thanks for the prompt response.
> 
> Could you explain  'recursive usage of mutex' a little further?
> Are the xenomai pthread-mutexes very different in behaviour than regular
> posix mutexes?

The posix specification does not define the default type of a mutex. So,
 in short, the behaviour of a "regular posix mutex" is unspecified.
However, following the principle of least surprise, Xenomai chose, like
Linux, to use the "normal" type by default.

What is the type of a posix mutex is explained in many places, starting
with Xenomai API documentation. So, no, I will not repeat it here.


-- 
					    Gilles.

