Message-ID: <2ff1a98a0804250626h7104d6ddg282d35798af77cb9@domain.hid>
Date: Fri, 25 Apr 2008 15:26:38 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <48118CC7.4060408@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18448.9649.956656.531081@domain.hid>
	<18448.9901.799115.445182@domain.hid>
	<18448.9967.355128.570111@domain.hid>
	<18448.10037.181558.14996@domain.hid>
	<48118CC7.4060408@domain.hid>
Subject: Re: [Xenomai-core] [3/9] Define more atomic operations in user-space
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
Cc: xenomai@xenomai.org

On Fri, Apr 25, 2008 at 9:48 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> Gilles Chanteperdrix wrote:
>  > This patch implements the _read, _set, and _cmpxchg operations on atomic_long_t
>  > and atomic_ptr_t in user-space in include/asm-generic/atomic.h which should be
>  > included at the end of include/asm-*/atomic.h after the definition of the same
>  > operations for the atomic_t type and atomic64_t type on 64 bits platforms.
>  >
>  > These operations are the basic operations used by user-space mutexes. Maybe we
>  > should add the xnarch_ prefix ?
>  >
>
>  Yes, but more generally, we should rework this to fit the existing atomic
>  support in include/asm-*/atomic.h, so that we don't end up with sideways to what
>  has been already designed to support set, get, xchg and the like, in both kernel
>  and userland context.

That is not exactly sideways... Linux include/asm-generic/atomic.h
defines operations for atomic_long_t. This file adds two things:
- support for atomic_long_t in user-space (where we can not include
linux include/asm-generic/atomic.h)
- support for a new type atomic_ptr_t both to kernel-space and
user-space, the aim is to avoid all the casts that would take place if
we wanted to use atomic_long_t to store pointers.

However for this file to work, it has to be included by asm-*/atomic.h
after the definition of atomic_t (and atomic64_t on 64 bits
platforms). So linux includes asm-generic/atomic.h at the end of
asm/atomic.h, I simply reproduced this scheme with Xenomai
include/asm-*/atomic.h.

-- 
 Gilles

