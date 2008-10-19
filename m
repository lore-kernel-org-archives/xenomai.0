Message-ID: <48FB74B6.9090206@domain.hid>
Date: Sun, 19 Oct 2008 19:56:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48FB693B.2080104@domain.hid> <48FB6D40.5090903@domain.hid>
	<48FB73C4.4090408@domain.hid>
In-Reply-To: <48FB73C4.4090408@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH] x86: Don't instrument vdso functions
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>

Philippe Gerum wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> The mcount instrumentation is currently leaking into vdso functions.
>>> Patch below fixes this (bits taken from 2.6.27).
>> What are these vdso functions? Functions called from user-space?
>>
> 
> Yes. Bits of kernel code mapped into user-space to eliminate the need for
> reaching them via syscalls.

They have copied it from ARM or Blackfin!

-- 
					    Gilles.

