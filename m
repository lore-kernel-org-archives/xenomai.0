Message-ID: <497F40F3.3010801@domain.hid>
Date: Tue, 27 Jan 2009 17:14:27 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <497F3E29.6050303@domain.hid>
In-Reply-To: <497F3E29.6050303@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] xnpipe: Fix minor number management
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
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
> This is an attempt to fix the bugs found in the minor number management:
> - changing the bitmap requires atomic operations
> - clrbits/setbits work against xnarch_atomic_t, and that is only 32 bit
>   wide on x86-64

I think we should rather fix xnarch_atomic_t to be the size of a long on
x86-64, than having to cope with xnarch_atomic_t of various sizes in the
code (there are probably other places where we depend on the size of
xnarch_atomic_t).

As for the find_first_bit, why not simply taking the nklock
xnpipe_minor_free ? This is a first masking section, so this should not
matter a lot.

-- 
                                                 Gilles.

