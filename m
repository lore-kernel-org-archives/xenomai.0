In-Reply-To: <437B2D05.6070003@domain.hid>
Message-ID: <OF43F82788.626A53FE-ONC12570BB.004EC675-C12570BB.0050F738@domain.hid>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Wed, 16 Nov 2005 15:44:21 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA28DFDD40E58f9e8a93df938690918c4EBBFA28DFDD40E5"
Content-Disposition: inline
Subject: [Xenomai-core] Re: [Xenomai-help] printk
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

--0__=4EBBFA28DFDD40E58f9e8a93df938690918c4EBBFA28DFDD40E5
Content-type: text/plain; charset=US-ASCII

Philippe Gerum <rpm@xenomai.org> wrote on 16.11.2005 13:58:45:

> ...
>
> Ok, this kind of stuff should always be designed with the brain turned
on. Now
> that I have eventually found the power switch, I'm going to fix the
> printk issue
> in the Adeos core along the following lines. The code below basically
reworks
> your proposal. The construct is still a bit hairy, but
> unfortunately, we cannot
> just go for using a plain atomic compare-and-exchange op in the virq
handler,
> since we need to serialize its activation among all CPUs - sigh...
> We also get rid
> of PPRINTK - which is redundant - in the same move.

Yep, this implementation looks at least sane to me now.


> ...

> --
>
> Philippe.
>

---

Dmitry

--0__=4EBBFA28DFDD40E58f9e8a93df938690918c4EBBFA28DFDD40E5
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>Philippe Gerum &lt;rpm@xenomai.org&gt; wrote on 16.11.2005 13:58:45:<br>
</tt><br>
<tt>&gt; ...</tt><br>
<tt>&gt;<br>
&gt; Ok, this kind of stuff should always be designed with the brain turned on. Now<br>
&gt; that I have eventually found the power switch, I'm going to fix the <br>
&gt; printk issue<br>
&gt; in the Adeos core along the following lines. The code below basically reworks<br>
&gt; your proposal. The construct is still a bit hairy, but <br>
&gt; unfortunately, we cannot<br>
&gt; just go for using a plain atomic compare-and-exchange op in the virq handler,<br>
&gt; since we need to serialize its activation among all CPUs - sigh... <br>
&gt; We also get rid<br>
&gt; of PPRINTK - which is redundant - in the same move.</tt><br>
<br>
<tt>Yep, this implementation looks at least sane to me now.</tt><br>
<br>
<br>
<tt>&gt; ...<br>
</tt><br>
<tt>&gt; -- <br>
&gt; <br>
&gt; Philippe.<br>
&gt; <br>
</tt><br>
<tt>---</tt><br>
<br>
<tt>Dmitry</tt><br>
<tt> <br>
</tt></body></html>
--0__=4EBBFA28DFDD40E58f9e8a93df938690918c4EBBFA28DFDD40E5--


