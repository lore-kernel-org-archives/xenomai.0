Message-ID: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
Date: Tue, 29 Aug 2006 21:28:13 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_12988_22297658.1156879693483"
Subject: [Xenomai-core] [patch, RFC] detect unhandled interrupts
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>

------=_Part_12988_22297658.1156879693483
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

Jan has rised this question initially and I was struggling last week to get
his request eventually done :)

The main idea is to prevent system lockups when the cross domain IRQ sharing
isn't properly used (there were a number of reports recently).

So here is an initial patch as well as some related critics (yep, I
critisize my own patch).

I tend to think now :

1) "unhandled" is not necessary indeed (do we need chasing "spurious"
interrupts the way Linux does it? i.e. it disables the line only after a
number of consequently unhandled interrupts > SOME_LIMIT);

2) XN_ISR_NONE --> should _not_ imply that the line gets re-enabled.

XN_ISR_HANDLED -- implies it, that's ok.

But XN_ISR_NONE (all ISRs in case of a shared RT line) should really mean
"something strange happens" and it can be :

 o  either a spurious interrupt;

 o  something is "sitting" on the same line in the linux domain. ISR should
have returned XN_ISR_PROPAGATE in this case.


That said, if we are not interested in chasing "spurious" interrupts the
linux way, then this patch could be highly simplified to just adding the
following check in all nucleus ISR handlers.

+       if (unlikely(s == XN_ISR_NONE)) {
+               xnlogerr("xnintr_check_status: %d of unhandled consequent
interrupts. "
+                       "Disabling the IRQ line #%d\n",
+                       XNINTR_MAX_UNHANDLED, irq);
+               s |= XN_ISR_NOENABLE;
+       }

I tend to think this would be nicer?



-- 
Best regards,
Dmitry Adamushko

------=_Part_12988_22297658.1156879693483
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>
Hello,<br>
<br>
Jan has rised this question initially and I was struggling last week to get his request eventually done :)<br>
<br>
The main idea is to prevent system lockups when the cross domain IRQ
sharing isn't properly used (there were a number of reports recently).<br>
<br>
So here is an initial patch as well as some related critics (yep, I critisize my own patch).<br>
<br>
I tend to think now :<br>
<br>
1) &quot;unhandled&quot; is not necessary indeed (do we need chasing &quot;spurious&quot;
interrupts the way Linux does it? i.e. it disables the line only after
a number of consequently unhandled interrupts &gt; SOME_LIMIT);<br>
<br>
2) XN_ISR_NONE --&gt; should _not_ imply that the line gets re-enabled.<br>
<br>
XN_ISR_HANDLED -- implies it, that's ok.<br>
<br>
But XN_ISR_NONE (all ISRs in case of a shared RT line) should really mean &quot;something strange happens&quot; and it can be :<br>
<br>
&nbsp;o&nbsp; either a spurious interrupt;<br>
<br>
&nbsp;o&nbsp; something is &quot;sitting&quot; on the same line in the linux
domain. ISR should have returned XN_ISR_PROPAGATE in this case.<br>
<br>
<br>
That said, if we are not interested in chasing &quot;spurious&quot; interrupts
the linux way, then this patch could be highly simplified to just
adding the following check in all nucleus ISR handlers.<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(s == XN_ISR_NONE)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
xnlogerr(&quot;xnintr_check_status: %d of unhandled consequent interrupts. &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;Disabling the IRQ line #%d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
XNINTR_MAX_UNHANDLED, irq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s |= XN_ISR_NOENABLE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
I tend to think this would be nicer?<br>
<br>
<br clear="all"><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_12988_22297658.1156879693483--

