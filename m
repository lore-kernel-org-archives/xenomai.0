Message-ID: <48E48501.4050005@domain.hid>
Date: Thu, 02 Oct 2008 10:23:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <894886ec0810012230j57e2f87n343a5b07bbdbd46@domain.hid>	
	<48E45E3C.30605@domain.hid>
	<894886ec0810012258o67da00d7x2e3d54c7e601b470@domain.hid>
	<48E4649B.6090506@domain.hid> <48E47C34.5070908@domain.hid>
In-Reply-To: <48E47C34.5070908@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] clock drift
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Theo Veenker <Theo.Veenker@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Theo Veenker wrote:
> May ask a (probably silly) question. Does clock_get/settime(clock_id) in
> /usr/include/time.h and in .../xenomai/include/posix/time.h refer to exactly
> the same clock? Or do these interfaces just refer to similar clocks.

The timing subsystems of Xenomai and Linux are different, so they refer
to similar clocks.

Xenomai's implementation of clock_gettime(CLOCK_MONOTONIC) reads the tsc
(which does not need a syscall on most architectures) and converts it to
a struct timespec, whereas the implementation of
clock_gettime(CLOCK_REALTIME) issues a syscall which reads the tsc, adds
an offset, and convert it to a struct timespec.
clock_settime(CLOCK_REALTIME) adjusts the offset used by
clock_gettime(CLOCK_REALTIME) and runs some timers.

-- 
                                                 Gilles.

