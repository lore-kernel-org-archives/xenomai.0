Message-ID: <51ACDB5C.8030206@xenomai.org>
Date: Mon, 03 Jun 2013 20:07:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51A6F9AD.3000207@free.fr> <51A73A1A.8000404@xenomai.org>
	<51A75049.2020504@free.fr> <51A79835.1090609@xenomai.org>
	<51AC9B33.4070504@free.fr>
In-Reply-To: <51AC9B33.4070504@free.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Context switching kernel tracing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@free.fr>
Cc: xenomai@xenomai.org

On 06/03/2013 03:33 PM, Stéphane ANCELOT wrote:

> Hi,
> 
> 
> The SMI is the source of my problems. the global SMI bit in the ICH6 can 
> not be disabled .


I read the URL you posted (which I had already read when writing the smi
module when Xenomai was still part of the RTAI project), and it does not
say that. It says that the global bit can only be used if the SMI_LOCK
bit is not set. So there was a time when the smi module checked the
SMI_LOCK bit, but after some time, we found that on some machines, even
when the SMI_LOCK bit was not armed, it was not possible to mask the
SMI_EN bit, so we replaced the check with the current check (re-reading
the bits, to check if the masked bit are actually masked).

Anyway, the only reason why the SMI_LOCK bit is armed, is if some code,
so, presumably the BIOS code, has armed it. Hence my original answer to
your query:

>> Ok then, your BIOS vendor does not want you to disable the SMI global

>> bit, have you tried other bits?


Got it?

-- 
                                                                Gilles.

