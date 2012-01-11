Message-ID: <4F0DDCFD.3070902@domain.hid>
Date: Wed, 11 Jan 2012 20:03:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BLU166-W4379BD842C749BADC78DE7C49E0@domain.hid>
In-Reply-To: <BLU166-W4379BD842C749BADC78DE7C49E0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Question about context switching
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan-Erik Lange <jan0385@domain.hid>
Cc: xenomai@xenomai.org

On 01/11/2012 07:12 PM, Jan-Erik Lange wrote:
> 
> Hello,
> 
> I have a question about the context switching:
> 
> Unless that there a rtdm_copy_to_user() available in the rtdm API.
> Would cause the function copy_to_user() in an xenomai kernel based rt
> task a switch into the secondary domain? Because copy_to_user() not
> actually a syscall right?

Absolutely no function in kernel-space causes an automatic switch to
secondary mode. As Philippe answered to the very first mail you posted
to this list, the only events which cause a switch to secondary mode are:

- invoking a regular linux syscall
- receiving a linux signal (e.g. kill(2) and GDB)
- causing a CPU trap (e.g. invalid memory access), hitting a breakpoint
(e.g. GDB)

All these events only happen for threads in user-space.

-- 
                                                                Gilles.

