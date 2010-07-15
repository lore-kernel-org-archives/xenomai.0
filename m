Message-ID: <4C3EFB0B.7050801@domain.hid>
Date: Thu, 15 Jul 2010 14:11:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinwyQgI26INSzLlvgyP2hlAmuziK7V3iNCVa8Nd@domain.hid>
In-Reply-To: <AANLkTinwyQgI26INSzLlvgyP2hlAmuziK7V3iNCVa8Nd@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [RTnet-users] Alignment problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cyril Wallois <walloiscyril@domain.hid>
Cc: xenomai@xenomai.org

Cyril Wallois wrote:
> Hi everybody,
> 
> I have try to solve my problem by using a newer kernel (2.6.30) without
> success, I have always the same issue with rtnet when I try rtping :
> 
> #./rtping 127.0.0.1
> Xenomai: suspending kernel thread bf009310 ('rtnet-rtpc') at 0xc002d3c8
> after exception #0

Why simply not disassembling the kernel and looking at what is at
0xc002d3c8 and looking at the values of the registers? It is entirely
possible that the RTnet IP stack requires unaligned accesses (the
vanilla kernel does it, notably for handling of IP options), and as you
may know it, unaligned accesses may require software emulation on some
platforms. However, I am not sure you would get an exception #0 in that
case. Your post does not even tell us on what platform you get this
issue, though I suspect this is ARM.

-- 
					    Gilles.

