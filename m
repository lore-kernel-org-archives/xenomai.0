Message-ID: <49077D56.8040908@domain.hid>
Date: Tue, 28 Oct 2008 22:00:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49076E08.5060708@domain.hid>
In-Reply-To: <49076E08.5060708@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] llimd.
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
Cc: Xenomai core <Xenomai-core@domain.hid>

Gilles Chanteperdrix wrote:
> Hi Jan,
> 
> I see that the implementation of rthal_llmulshft seems to account for
> the first argument sign. Does it work ? Namely, in the generic
> implementation will __rthal_u96shift propagate the sign bit ?

Yes, this works (given there is no overflow, of course). If you consider
a high word of 0xfffffff0 and a (right) shift of 8, we effectively cut
off all the leading 1s: high << (32-8) = 0xf0000000. But this only works
because we replace a right shift with a left shift (plus some OR'ing
later on). If we had to do a real right shift, we would also have to
take signed vs. unsigned into account (ie. shift in zeros or the sign
bit from the left?).

> 
> If yes, do you see a way llimd could be made to work the same way ? This
> way we would avoid inline ullimd twice in llimd code.

As the basic building block here is a multiplication, we cannot get
around telling apart signed from unsigned (or converting signed into
unsigned): the underlying multiplication logic is different.

But what about this approach:

static inline __attribute__((__const__)) long long
__rthal_generic_llimd (long long op, unsigned m, unsigned d)
{
	int signed = 0;
	long long ret;

	if (op < 0LL) {
		op = -op;
		signed = 1;
	}
	ret = __rthal_generic_ullimd(op, m, d);
	return signed ? -ret : ret;
}

However, I guess writing this in assembly for archs that suffer should
be more efficient.

Jan

