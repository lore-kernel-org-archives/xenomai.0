Message-ID: <4C068321.1000902@domain.hid>
Date: Wed, 02 Jun 2010 18:13:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikLJC_pFm9l6G1t7vlUfzrqMAt7zu9t_uRNZV15@domain.hid>
In-Reply-To: <AANLkTikLJC_pFm9l6G1t7vlUfzrqMAt7zu9t_uRNZV15@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xeno-test problem
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
> Thanks for your fast reply gilles,
> 
> I don't use the right word to explain my problem, the lock-up with
> xeno-test is solve with newer version of xenomai and linux kernel.

Not quite. It will work with the newer version because the default
period of the latency test is 1000us instead of 100us. But your ARM is
still probably not able to sustain a 100us period.

> 
> I have always to solve my problem when running rtnet :
> 
> Xenomai: suspending kernel thread bf0270e0 ('rtnet-rtpc') at 0xbf02b814
> after exception #8

What you need is to type cat /proc/modules on the target to see the
module to which the address 0xbf02b814 corresponds. Then run objdump to
disassemble the faulting module. But I believe Jan explained you all
that when answering the original request.


>
> Now, I'm searching for tools to debug the kernel on a remote target and
> read the value in the register.
> https://mail.gna.org/listinfo/xenomai-help


To print the values of registers, you can add some printks to the
xnpod_trap_fault function in the ksrc/nucleus/pod.c file in Xenomai
sources. We could arguably add that to Xenomai code, but we did not do
it yet.

As for the alignment issue itself, please take care, on the receive path
of your driver to pass, to the rtnet stack, buffers where the IP header
is aligned on a 4 bytes boundary. Since the ethernet header is 6 bytes
long, it means that the ethernet header alignement should be 2 modulo 4.

-- 
					    Gilles.

