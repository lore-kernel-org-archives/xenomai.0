MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18234.6110.166676.909212@domain.hid>
Date: Tue, 13 Nov 2007 22:32:14 +0100
In-Reply-To: <47397C4B.1070901@domain.hid>
References: <472F6C17.2070100@domain.hid> <472F6DAD.20308@domain.hid>
	<472F990A.2030209@domain.hid> <473006D8.4080808@domain.hid>
	<47302D55.9050808@domain.hid> <47339C53.5010700@domain.hid>
	<4734677E.6010904@domain.hid> <47348EE0.5020007@domain.hid>
	<473493CB.4080701@domain.hid> <4734995B.20900@domain.hid>
	<4737510F.7010309@domain.hid> <47397C4B.1070901@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [Adeos-main] [PATCH] i386: switch to root domain
 on unhandled non-root faults
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org, Jan Kiszka <jan.kiszka@domain.hid>, Xenomai-core@domain.hid

Philippe Gerum wrote:
 > (...) In
 > future updates, we may want to rely on raw UART output when the platform
 > provides for it (currently, all blackfin, mpc52xx and some? ARM do, IIRC).

ARMs do have printascii, which outputs a string to the UART, it is
defined from include/asm-arm/arch-*/debug-macro.S, so I guess all ARM
architectures with a non-trivial debug-macro.S have a working
printascii. Note that compilation of printascii depends on the option
CONFIG_DEBUG_LL to be enabled in the kernel configuration.


-- 


					    Gilles Chanteperdrix.

