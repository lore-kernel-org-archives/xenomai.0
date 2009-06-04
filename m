Message-ID: <4A27D3A3.4040302@domain.hid>
Date: Thu, 04 Jun 2009 16:01:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <325d766d0906040408w7d9712a0gb8927529796a3913@domain.hid>	
	<4A27ACEA.6010500@domain.hid>
	<325d766d0906040601v2251a4f6ma5374c967fb98758@domain.hid>
In-Reply-To: <325d766d0906040601v2251a4f6ma5374c967fb98758@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Support for Atmel AT91SAM9G20 processor
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: martin mangard <martin@domain.hid>
Cc: xenomai@xenomai.org

martin mangard wrote:
> Hello
> 
> You are right! This part of the patch is not necessary and is ignored
> if the AT91SAM9G20 is selected in the kernel configuration. I made
> this  change  during a test with another kernel configuration. Sadly
> this change was still present during the creation of the patch. The
> attached patch does not contain this part any more.

Applied, thanks.

-- 
					    Gilles.

