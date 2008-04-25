Message-ID: <4811E8AE.1090000@domain.hid>
Date: Fri, 25 Apr 2008 16:20:30 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <18448.9649.956656.531081@domain.hid>	
	<18448.9901.799115.445182@domain.hid>	
	<18448.9967.355128.570111@domain.hid>	
	<18448.10037.181558.14996@domain.hid>	
	<48118CC7.4060408@domain.hid>	
	<2ff1a98a0804250626h7104d6ddg282d35798af77cb9@domain.hid>	
	<4811DFCB.8080107@domain.hid>	
	<2ff1a98a0804250650s71a6448do67a55f27c6623af1@domain.hid>	
	<4811E429.8020505@domain.hid>
	<2ff1a98a0804250713l5d0588a2m95f630f39426e3f3@domain.hid>
In-Reply-To: <2ff1a98a0804250713l5d0588a2m95f630f39426e3f3@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [3/9] Define more atomic operations in user-space
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> On Fri, Apr 25, 2008 at 4:01 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> Gilles Chanteperdrix wrote:
>>  > On Fri, Apr 25, 2008 at 3:42 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>>  >> Gilles Chanteperdrix wrote:
>>  >>  > On Fri, Apr 25, 2008 at 9:48 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>>  >>  >> Gilles Chanteperdrix wrote:
>>  >>  >>  > This patch implements the _read, _set, and _cmpxchg operations on atomic_long_t
>>  >>  >>  > and atomic_ptr_t in user-space in include/asm-generic/atomic.h which should be
>>  >>  >>  > included at the end of include/asm-*/atomic.h after the definition of the same
>>  >>  >>  > operations for the atomic_t type and atomic64_t type on 64 bits platforms.
>>  >>  >>  >
>>  >>  >>  > These operations are the basic operations used by user-space mutexes. Maybe we
>>  >>  >>  > should add the xnarch_ prefix ?
>>  >>  >>  >
>>  >>  >>
>>  >>  >>  Yes, but more generally, we should rework this to fit the existing atomic
>>  >>  >>  support in include/asm-*/atomic.h, so that we don't end up with sideways to what
>>  >>  >>  has been already designed to support set, get, xchg and the like, in both kernel
>>  >>  >>  and userland context.
>>  >>  >
>>  >>  > That is not exactly sideways... Linux include/asm-generic/atomic.h
>>  >>  > defines operations for atomic_long_t. This file adds two things:
>>  >>  > - support for atomic_long_t in user-space (where we can not include
>>  >>  > linux include/asm-generic/atomic.h)
>>  >>  > - support for a new type atomic_ptr_t both to kernel-space and
>>  >>  > user-space, the aim is to avoid all the casts that would take place if
>>  >>  > we wanted to use atomic_long_t to store pointers.
>>  >>  >
>>  >>  > However for this file to work, it has to be included by asm-*/atomic.h
>>  >>  > after the definition of atomic_t (and atomic64_t on 64 bits
>>  >>  > platforms). So linux includes asm-generic/atomic.h at the end of
>>  >>  > asm/atomic.h, I simply reproduced this scheme with Xenomai
>>  >>  > include/asm-*/atomic.h.
>>  >>  >
>>  >>
>>  >>  Focusing on user-space: 1) xnarch_atomic_xchg is meant to work on long types; 2)
>>  >>  set, get routines are not defined in that scope. If the purpose is to define
>>  >>  integer-type ops to handle pointer-type data atomically (i.e. intptr_t), then I
>>  >>  would rather check whether we actually need non-long support at all in
>>  >>  user-space. In case we don't, I would simply reply on the existing
>>  >>  implementation of asm-*/atomic.h + the set / get extensions you provide.
>>  >
>>  > I use both atomic_t and atomic_ptr_t for the implementation of
>>  > user-space mutexes. The problem is that I am constrained by the size
>>  > of pthread_mutex_t, so the "control block read-write locks"
>>  > implementation use atomic_t.
>>  >
>>
>>  Ok, makes sense. Let's just fix the namespace then, so that we don't get the
>>  feeling of having duplicate sets of operations.
> 
> That said, there is just enough room for replacing the atomic_t with
> an atomic_long_t. So, we can make xnarch_atomic_t a long type. Have
> you anything agains making an xnarch_atomic_ptr_t ?
> 

No objection, just let us call it xnarch_atomic_intptr_t to ANSIfy this a bit
more, and clearly state that we need this type to hold a pointer into an integer
value, and operate atomically on it.

-- 
Philippe.

