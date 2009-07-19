Message-ID: <4A6322E1.1030908@domain.hid>
Date: Sun, 19 Jul 2009 15:42:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A62D1C1.9050807@domain.hid> <4A62D2B8.8030907@domain.hid>
In-Reply-To: <4A62D2B8.8030907@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> +#define LOAD_ARGS_0()	asm volatile ("" ::: "memory");

g++, at least some verions in the past, chokes on ::: so, you should do
: /* */ : /* */ :



-- 
					    Gilles.

