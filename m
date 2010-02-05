Message-ID: <4B6C4745.3040602@domain.hid>
Date: Fri, 05 Feb 2010 17:28:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201002051723.22556.sinisa.denic@domain.hid>
In-Reply-To: <201002051723.22556.sinisa.denic@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xeno2.5  -  2.5.1 API mismatch?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sinisa Denic <sinisa.denic@domain.hid>
Cc: xenomai@xenomai.org

Sinisa Denic wrote:
> Building one of the our software with xeno 2.5.1, I'v got this error:
> 
>  error: 'MCL_CURRENT' undeclared (first use in this function)
> 
> but building the same source with xeno 2.5.0 there is no errors.
> 
> ??
> 
> Sinisa
> 

MCL_CURRENT is defined in <sys/mman.h>

Coud you send us a small test case using MCL_CURRENT which fails to compile?

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

