Message-ID: <b647ffbd0608291334u4182e78bub6d874e252abbbc9@domain.hid>
Date: Tue, 29 Aug 2006 22:34:13 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <44F49A6C.5050603@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_14177_5383211.1156883653639"
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
	<44F49A6C.5050603@domain.hid>
Subject: [Xenomai-core] Re: [patch, RFC] detect unhandled interrupts
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
Cc: xenomai@xenomai.org

------=_Part_14177_5383211.1156883653639
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 29/08/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Dmitry Adamushko wrote:
>
> I think the additional costs of maintaining an error counter are almost
> negligible. The test is in the unlikely path, and the first condition
> already keeps us away from touching the counter.


But it's updated (unhandled = 0) any time the ISR(s) report something
different from XN_ISR_NONE.  Hence, it's at the beginning of the xnintr_t
structure, hopefully, at the same cache line with other highly-used members
(i.e. isr, cookie and hits).


The benefit of not
> kicking out IRQ lines on spurious IRQs is obvious (think of EMC issues,
> though one should better solve them on the board...).


Yep, that's why I'm asking whether we really need it or no. If a scenario
when "spurious" interrupts indeed happen from time to time and a minor
number of them (consequently) is not something completely unacceptable, then
we might keep this "unhandled" counter. Here I don't have enough practical
experience/evidence and may only rely on the linux way (damn, now I
understand why they advised people not to read windows kernel code :)


BTW, is there a difference between unlikely(a && b) and unlikely(a) &&
> unlikely(b) that we should care about here?


I had it also in mind and grepped use cases of "unlikely" in kernel/
directory. There are a number of unlikely (a op. b) but none of unlikely(a)
op. unlikely (b).

Out of curiosity, one may disassemble code for both cases. My feeling
though, unlikely(a && b) is at least not worse (cpu and compiler-wise) but
don't want to speculate as I'm quite uneducated bozo here :)



> Jan
>
>


-- 
Best regards,
Dmitry Adamushko

------=_Part_14177_5383211.1156883653639
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><span class="gmail_quote">On 29/08/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Dmitry Adamushko wrote:<br><br>I think the additional costs of maintaining an error counter are almost<br>negligible. The test is in the unlikely path, and the first condition<br>already keeps us away from touching the counter.
</blockquote><div><br>
But it's updated (unhandled = 0) any time the ISR(s) report something
different from XN_ISR_NONE.&nbsp; Hence, it's at the beginning of the
xnintr_t structure, hopefully, at the same cache line with other
highly-used members (i.e. isr, cookie and hits).<br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> The benefit of not<br>kicking out IRQ lines on spurious IRQs is obvious (think of EMC issues,
<br>though one should better solve them on the board...).</blockquote><div><br>
Yep, that's why I'm asking whether we really need it or no. If a
scenario when &quot;spurious&quot; interrupts indeed happen from time to time and
a minor number of them (consequently) is not something completely
unacceptable, then we might keep this &quot;unhandled&quot; counter. Here I don't
have enough practical experience/evidence and may only rely on the
linux way (damn, now I understand why they advised people not to read
windows kernel code :)<br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">BTW, is there a difference between unlikely(a &amp;&amp; b) and unlikely(a) &amp;&amp;
<br>unlikely(b) that we should care about here?</blockquote><div><br>
I had it also in mind and grepped use cases of &quot;unlikely&quot; in kernel/
directory. There are a number of unlikely (a op. b) but none of
unlikely(a) op. unlikely (b).<br>
<br>
Out of curiosity, one may disassemble code for both cases. My feeling
though, unlikely(a &amp;&amp; b) is at least not worse (cpu and
compiler-wise) but don't want to speculate as I'm quite uneducated bozo
here :)<br>
<br>
<br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>Jan<br><br></blockquote></div><br><br clear="all"><br>-- <br>Best regards,<br>Dmitry Adamushko
<br>
<br>


------=_Part_14177_5383211.1156883653639--

