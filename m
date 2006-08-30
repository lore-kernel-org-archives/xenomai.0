From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17653.47846.660686.886474@domain.hid>
Date: Wed, 30 Aug 2006 18:20:54 +0200
Subject: Re: [Xenomai-core] Re: [patch, RFC] detect unhandled interrupts
In-Reply-To: <b647ffbd0608300903x4ee0571fq627901c7805b87ee@domain.hid>
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
	<44F49A6C.5050603@domain.hid>
	<b647ffbd0608291334u4182e78bub6d874e252abbbc9@domain.hid>
	<1156943901.4323.47.camel@domain.hid>
	<b647ffbd0608300903x4ee0571fq627901c7805b87ee@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Dmitry Adamushko wrote:
 > > > I had it also in mind and grepped use cases of "unlikely" in kernel/
 > > > directory. There are a number of unlikely (a op. b) but none of
 > > > unlikely(a) op. unlikely (b).
 > > >
 > > > Out of curiosity, one may disassemble code for both cases. My feeling
 > > > though, unlikely(a && b) is at least not worse (cpu and compiler-wise)
 > > > but don't want to speculate as I'm quite uneducated bozo here :)
 > > >
 > >
 > > Since likely/unlikely are hints given to the compiler for optimizing
 > > branches, you might want to give it all the information you have at hand
 > > immediately, to augment your chances to have it do the right thing [just
 > > in case the optimizer has no more short-term memory than a red fish...]
 > 
 > 
 > 
 > (1) if (unlikely(a) && unlikely(b))
 > (2) if (unlikely(a && b))
 > 
 > (1) results in 1 more "je" instruction on the path of the CPU to a "likely"
 > branch than in case of (2).
 > And as someone more educated in this field has just told me (hopefully I got
 > it correct), any conditional jump leads to the pipeline flushing (maybe
 > recent CPUs can avoid it indeed in case a condition is false).
 > 
 > So the code that contains less conditional && unconditional jumps is more
 > pipeline-friendly.
 > 
 > And a compiler is not (always) "smart" (should it be though?) enough to make
 > the following transformation :
 > 
 > unlikely(a) && unlikely(b) => unlikely(a + b)

If I was a compiler, I would evaluate the two differently. When
evaluating a && b, there are three branches: !a, a && !b, a && b, the
first two of which jump to the same block, but that's not important.

when writing unlikely(a) && unlikely(b), you mean that !a is likely, 
a && !b is at the same time likely and unlikely (so, probably unlikely
if we assume that the probability of the association is the product of
the elementary probabilities) a && b is unlikely.

when writing unlikely(a && b), you mean that !a and a && !b are likely,
whereas a && b is unlikely.

-- 


					    Gilles Chanteperdrix.

