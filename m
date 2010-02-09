Message-ID: <4B716732.3040306@domain.hid>
Date: Tue, 09 Feb 2010 14:46:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B71666A.6040508@domain.hid>
In-Reply-To: <4B71666A.6040508@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai FAILED to register object
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexandre Coffignal <alexandre.coffignal@domain.hid>
Cc: xenomai@xenomai.org

Alexandre Coffignal wrote:
> Hi all,
> 
> I use xenomai to port PSOS application, so I am using xenomai PSOS skin,
> but i want to use xenomai pthread.
> 
> My question is do you know if i can use psos skin and posix skin in the
> same time?
> 
> I already test it without success : when I load my prog, I have this
> message :
>     Xenomai pSOS skin init: t_shadow() failed, status -17
> 
> and this message in dmess
>     Xenomai: FAILED to register object MAIN (unknown type), status -17

Because the main thread is already shadowed by the posix skin. It is
already a xenomai task.

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

