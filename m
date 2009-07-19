From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A6322E1.1030908@domain.hid>
References: <4A62D1C1.9050807@domain.hid> <4A62D2B8.8030907@domain.hid>
	<4A6322E1.1030908@domain.hid>
Content-Type: text/plain
Date: Sun, 19 Jul 2009 16:31:24 +0200
Message-Id: <1248013884.4228.155.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 2/3] x86-64: Work around gcc issues with
 populating syscall registers
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Petr Cervenka <grugh@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Sun, 2009-07-19 at 15:42 +0200, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
> > +#define LOAD_ARGS_0()	asm volatile ("" ::: "memory");
> 
> g++, at least some verions in the past, chokes on ::: so, you should do
> : /* */ : /* */ :
> 

I will fix this manually while merging.

> 
> 
-- 
Philippe.



