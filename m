Message-ID: <4A6337D8.7030300@domain.hid>
Date: Sun, 19 Jul 2009 17:12:24 +0200
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
> gcc-4.1.3 of kubuntu has problem with proper syscall register
> initialization in rt_task_shadow if TLS is enabled. But it is likely
> that more compiler versions below 4.3 and more configuration variants
> are affected.
> 
> This patch installs a workaround for these gcc versions which places an
> optimization barrier before the register variable setup. This forces gcc
> to actually load the registers.

I have tried the barrier with arm gcc, it does not work. However,
marking the registered clobbered instead of the memory fixes arm gcc 4.3
bug. So, I wonder, would not it make more sense to mark the registers as
clobbered by the barrier instead of memory on x86 too?

-- 
					    Gilles.

