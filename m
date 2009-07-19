Message-ID: <4A6323D9.50900@domain.hid>
Date: Sun, 19 Jul 2009 15:47:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A60E4FF.9020307@domain.hid> <4A62D608.2090802@domain.hid>
In-Reply-To: <4A62D608.2090802@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [rfc] Jumpless *llimd.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> The approach is generally fine, but you have to take measures to avoid
> using cmove on CPUs that don't support it. They may be still around
> (older VIA C3 e.g.).

The kernel has a #define and in user-space, we would have to add a
configure option, and we can test in /proc/cpuinfo if the instruction is
supported by the processor.

-- 
					    Gilles.

