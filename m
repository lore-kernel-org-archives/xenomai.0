Message-ID: <4A60E4FF.9020307@domain.hid>
Date: Fri, 17 Jul 2009 22:54:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [rfc] Jumpless *llimd.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>


Hi,

we discussed this issue several times already I believe: it would be 
fine if llimd (and nodiv_llimd) could work without jumps. 32 bits 
compiler are unable to generate code without jumps for the following 
sequence:

union u64 {
	long long ll;
	unsigned l, h;
};

long long llimd(union u64 x, unsigned m, unsigned d)
{
	unsigned s = x.h & 0x80000000;
	if (s)
		x.ll = -x.ll;
	x.ll = ullimd(x.ll, m, d);
	if (s)
		x.ll = -x.ll;
}

even though this works for x86_64 compiler.

So, I thought, we might help a bit with inline assembly (after all, 
ullimd is already inline assembly). For instance, we could define macros
with the following semantic:

#define sign_split(s, x)                        \
        s = x.l & (1 << 31);                    \
        if (s)                                  \
                x.ll = -x.ll;

#define sign_apply(s, x)                        \
        if (s)                                  \
                x.ll = -x.ll


Jumpless versions on x86_32, using the cmov instruction, would give us:

#define x86_sign_split(s, x)                                            \
        ({                                                              \
                unsigned tmpl = 0, tmph = 0;                            \
                s = x.h;                                        	\
                asm ("sub %[tmpl], %[xl]\n\t"                           \
                     "sbb %[tmph], %[xh]\n\t"                           \
                     "andl $0x80000000, %[s]\n\t"                       \
                     "cmovnz %[tmpl], %[xl]\n\t"                        \
                     "cmovnz %[tmph], %[xh]\n\n"                        \
                     : [s]"+m"(s), [tmph]"+rm?"(tmph), [tmpl]"+rm?"(tmpl), \
                       [xh]"=r"(x.h), [xl]"=r"(x.l));                 	\
         })

#define x86_sign_apply(s, x)                                            \
        ({                                                              \
                unsigned tmpl = 0, tmph = 0;                            \
                asm ("sub %[tmpl], %[xl]\n\t"                           \
                     "sbb %[tmph], %[xh]\n\t"                           \
                     "cmpl $0x80000000, %[s]\n\t" 			\
                     "cmove %[tmpl], %[xl]\n\t"                 	\
                     "cmove %[tmph], %[xh]\n\n"                 	\
                     : [tmph]"+rm?"(tmph), [tmpl]"+rm?"(tmpl), 		\
                       [xh]"=r"(x.h), [xl]"=r"(x.l)                     \
                     : [s]"m"(s));                      		\
         })

What do you think? I am out of my mind? Would you see llimd defined
locally in each asm/arith.h using these macros? Or should we make this 
yet another macro defined by asm/arith.h and used by 
asm-generic/arith.h? 

Note that on ARM, the inline assembly would be shorter (maybe there are
shorter solutions on x86_32, but as usual, they are probably not natural).

-- 
					    Gilles.

