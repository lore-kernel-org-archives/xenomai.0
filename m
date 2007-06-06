MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18022.64424.836736.431121@domain.hid>
Date: Wed, 6 Jun 2007 20:23:36 +0200
In-Reply-To: <4666B716.6010909@domain.hid>
References: <46649F7E.3060104@domain.hid> <46651F7D.9090702@domain.hid>
	<18021.58231.177931.286548@domain.hid>
	<46668CC3.8050002@domain.hid> <4666ACE5.7030200@domain.hid>
	<4666AFB3.6040602@domain.hid> <4666B4C7.6020308@domain.hid>
	<4666B716.6010909@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH-STACK] Updates, timerstats, rtdm-timers
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
 > Gilles Chanteperdrix wrote:
 > > Not when the macro and inline bear names that are easy to understand. If
 > > you do not find the names easy to understand, then change them (I do not
 > > like rthal_llmul either, but I could not find a name). To make the
 > > assembly fully understandable, you would need to comment every
 > > statement. And now, run the assembly code in gdb, and try and print the
 > > value of a 64 bits intermediate result: you can't.
 > 
 > No question, this is a matter of taste.

No, really, being able to debug the code inside gdb appears to me as
something more than a "matter of taste", I thought that as the person
who made Xenomai run with kgdb you would have agreed with me.

Now, about the way I wrote arithmetic code, their are reasons behind my
choices. There are some repetitive patterns in this arithmetic code and
I wanted to facter them out. The first pattern is the conversion between
32 bits and 64 bits, we have to do this in a way that is understood by
the compiler on a particular platform, hence the definition of
rthal_u64from/tou32 which is different for each platform. x86
understands shifts and mask (or cast), but gcc for power pc or arm
prefers the union trick.
There is also only one way to cause gcc to use the 32x32->64 fast
multiplication it is exactly what does rthal_ullmul. If you want to do
the same thing, but write it differently, you invariably cause gcc to
use a full 64 bits multiplication.

So, when in rthal_generic_llmulshft, I read:

    long long hi = (ll >> BITS_PER_LONG) * m;
    unsigned long long lo = ((long)ll) * m;

I think this is all wrong:
- on a 64 bits machine, BITS_PER_LONG is 64 and ll is 64 bits, so ll >>
  BITS_PER_LONG is 0

- for the first multiplication, the compiler will not detect the
  "fastmult" condition, and will use a full 64 bits multiplication. In
  order to get it to generate the minimal multiplication, you should
  have used:

  long long hi = (long long)(int)(ll >> 32) * (int) m

 I find:
static inline long long rthal_llmi(const int i, const int j)
{
        /* Fast 32x32->64 multiplication */
	return (long long) i * j;
}

/* (...) */
	__rthal_u64tou32(op, oph, opl);
	hi = rthal_llmi(oph, m);

easier to write and maintain, understand once you know what
rthal_llmi does, and generates better code with regard to the
32bits/64bits conversion.

- for the second multiplication, since the two arguments are 32 bits, the
  compiler will use a 32 bits multiplication, and since you (wrongly)
  cast the first argument to long, it will use a signed multiplication,
  whereas we would want it to use an unsigned multiplication, as the
  assembly routine correctly does.

Here again, using:

      lo = rthal_ullmul(opl, m);
would have been less error-prone.
   
So, Ok, I will try to do something for x86 (either reduce the numbers of
registers used by the C code, or reduce the assembly to the bare
minimum). But, please, pick my generic implementation of llmulshft, it
was carefully written.

-- 


					    Gilles Chanteperdrix.

