Message-ID: <b647ffbd0608211045m24073f66s7fcbf56c5ed78f4f@domain.hid>
Date: Mon, 21 Aug 2006 19:45:21 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [patch,
	minor] xnpipe_recv and xntimer_get_timeout_periodic()
In-Reply-To: <1156153751.4402.28.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_34470_14969792.1156182321367"
References: <b647ffbd0608210136w7ca05265o5ef930c1bee24d65@domain.hid>
	<1156153751.4402.28.camel@domain.hid>
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

------=_Part_34470_14969792.1156182321367
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 21/08/06, Philippe Gerum <rpm@xenomai.org> wrote:
>
> On Mon, 2006-08-21 at 10:36 +0200, Dmitry Adamushko wrote:
>
> > [ timer.c.patch] xnticks_t is unsigned while (as I understand)
> > "xntlholder_date(&timer->plink) - nkpod->jiffies" can be negative.


ok, I somehow missed a check for xntimer_running_p() in
xntimer_get_timeout(). I bet it was not there when I was looking at this
part of code yesterday or maybe I just had too much ummmm wonderful belgium
beer :o)

Actually xntimer_get_timeout() should be called with nklock held + irq off
as it must be atomic. But anyway, this is how it's used in all places and
it's probably not supposed to be used "as is" from any upper layer. So it's
ok.


-- 
Best regards,
Dmitry Adamushko

------=_Part_34470_14969792.1156182321367
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 21/08/06, <b class="gmail_sendername">Philippe Gerum</b> &lt;<a href="mailto:rpm@xenomai.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">rpm@xenomai.org
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Mon, 2006-08-21 at 10:36 +0200, Dmitry Adamushko wrote:<br><br>&gt; [ timer.c.patch] xnticks_t is unsigned while (as I understand)<br>&gt; &quot;xntlholder_date(&amp;timer-&gt;plink) - nkpod-&gt;jiffies&quot; can be negative.
</blockquote><div><br>
ok, I somehow missed a check for xntimer_running_p() in
xntimer_get_timeout(). I bet it was not there when I was looking at
this part of code yesterday or maybe I just had too much ummmm
wonderful belgium beer :o)<br>
<br>
Actually xntimer_get_timeout() should be called with nklock held + irq
off as it must be atomic. But anyway, this is how it's used in all
places and it's probably not supposed to be used &quot;as is&quot; from any upper
layer. So it's ok.<br>
</div></div><br clear="all"><br>-- <br>Best regards,<br>Dmitry Adamushko


------=_Part_34470_14969792.1156182321367--

