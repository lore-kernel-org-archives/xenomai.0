Message-ID: <b647ffbd0608300903x4ee0571fq627901c7805b87ee@domain.hid>
Date: Wed, 30 Aug 2006 18:03:53 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] Re: [patch, RFC] detect unhandled interrupts
In-Reply-To: <1156943901.4323.47.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_26032_9520524.1156953833026"
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
	<44F49A6C.5050603@domain.hid>
	<b647ffbd0608291334u4182e78bub6d874e252abbbc9@domain.hid>
	<1156943901.4323.47.camel@domain.hid>
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

------=_Part_26032_9520524.1156953833026
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> > I had it also in mind and grepped use cases of "unlikely" in kernel/
> > directory. There are a number of unlikely (a op. b) but none of
> > unlikely(a) op. unlikely (b).
> >
> > Out of curiosity, one may disassemble code for both cases. My feeling
> > though, unlikely(a && b) is at least not worse (cpu and compiler-wise)
> > but don't want to speculate as I'm quite uneducated bozo here :)
> >
>
> Since likely/unlikely are hints given to the compiler for optimizing
> branches, you might want to give it all the information you have at hand
> immediately, to augment your chances to have it do the right thing [just
> in case the optimizer has no more short-term memory than a red fish...]



(1) if (unlikely(a) && unlikely(b))
(2) if (unlikely(a && b))

(1) results in 1 more "je" instruction on the path of the CPU to a "likely"
branch than in case of (2).
And as someone more educated in this field has just told me (hopefully I got
it correct), any conditional jump leads to the pipeline flushing (maybe
recent CPUs can avoid it indeed in case a condition is false).

So the code that contains less conditional && unconditional jumps is more
pipeline-friendly.

And a compiler is not (always) "smart" (should it be though?) enough to make
the following transformation :

unlikely(a) && unlikely(b) => unlikely(a + b)


-- 
Best regards,
Dmitry Adamushko

------=_Part_26032_9520524.1156953833026
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; I had it also in mind and grepped use cases of &quot;unlikely&quot; in kernel/
<br>&gt; directory. There are a number of unlikely (a op. b) but none of<br>&gt; unlikely(a) op. unlikely (b).<br>&gt;<br>&gt; Out of curiosity, one may disassemble code for both cases. My feeling<br>&gt; though, unlikely(a &amp;&amp; b) is at least not worse (cpu and compiler-wise)
<br>&gt; but don't want to speculate as I'm quite uneducated bozo here :)<br>&gt;<br><br>Since likely/unlikely are hints given to the compiler for optimizing<br>branches, you might want to give it all the information you have at hand
<br>immediately, to augment your chances to have it do the right thing [just<br>in case the optimizer has no more short-term memory than a red fish...]</blockquote><div><br>
<br>
(1) if (unlikely(a) &amp;&amp; unlikely(b)) <br>
(2) if (unlikely(a &amp;&amp; b))<br>
<br>
(1) results in 1 more &quot;je&quot; instruction on the path of the CPU to a &quot;likely&quot; branch than in case of (2).<br>
And as someone more educated in this field has just told me (hopefully
I got it correct), any conditional jump leads to the pipeline flushing
(maybe recent CPUs can avoid it indeed in case a condition is false).<br>
<br>
So the code that contains less conditional &amp;&amp; unconditional jumps is more pipeline-friendly.<br>
<br>
And a compiler is not (always) &quot;smart&quot; (should it be though?) enough to make the following transformation :<br>
<br>
unlikely(a) &amp;&amp; unlikely(b) =&gt; unlikely(a + b)<br>
<br></div></div><br>
-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>

------=_Part_26032_9520524.1156953833026--

