Message-ID: <4E1ADAFD.1010604@domain.hid>
Date: Mon, 11 Jul 2011 13:14:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C15B4995-28DC-403B-8117-B9F8062571D4@domain.hid>
	<4E153BFA.601@domain.hid> <4E1567DB.9020505@domain.hid>
In-Reply-To: <4E1567DB.9020505@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5.3 vs gettimeofday() --> livelock?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Uwe Fechner <u.fechner@domain.hid>
Cc: Jeremy Friesner <jaf@domain.hid>, xenomai@xenomai.org

On 07/07/2011 10:01 AM, Uwe Fechner wrote:
>  Hi,
> 
> where can I find the documentation of the rtdk library?
> I googled it, but only found people talking about it, but no api
> documentation.

I do not think it has a documentation, but the code is relatively short.
The essential part of the API is rt_printf which essentially works as a
drop-in replacement for printf, except that you need some
initializations (rt_print_auto_init, or rt_print_init for each thread
which wants to log).

-- 
                                                                Gilles.

