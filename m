Message-ID: <b647ffbd0609051210p26c56690oe7b332190b3b702e@domain.hid>
Date: Tue, 5 Sep 2006 21:10:43 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <44FD9F92.4050802@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_104407_5632698.1157483443647"
References: <44FD7463.7010601@domain.hid> <44FD99E9.6030500@domain.hid>
	<44FD9F92.4050802@domain.hid>
Subject: [Xenomai-core] Re: Move rtdm_irq_enable close to rtdm_irq_request
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

------=_Part_104407_5632698.1157483443647
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 05/09/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
>
> @Dmitry: What happens under CONFIG_XENO_OPT_SHIRQ_LEVEL &&
> !CONFIG_XENO_OPT_SHIRQ_EDGE when someone comes along with
> XN_ISR_SHARED|XN_ISR_EDGE? Looks like the level-triggered shared handler
> gets installed. Should we catch this? At Kconfig or at nucleus level?


Currently XN_ISR_SHARED and XN_ISR_EDGE are unconditionally available for
any configuration. So nothing stops a user from calling rtdm_irq_request(
... , RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE) even when IRQ shared
infrastructure is off.
(the second call gives -EBUSY and a "bug" report is sent. I mean, if the
user has overlooked "shared irq" section on the configure step and consider
it a default behavior).

Probably the clean solution would be to export XN_ISR_SHARED and XN_ISR_EDGE
only when their corresponding CONFIG_* parameters are defined.

Then e.g. rtdm skin should do :

#ifdef XN_ISR_SHARED
#define RTDM_IRQTYPE_SHARED XN_ISR_SHARED
#endif

and let a compiler complain on undefined symbol when a user tries to use
SHARED/EDGE without proper CONFIG options. Although, I'm not sure it would
be clear for all users.

Another approach,

in xnintr.h

#ifdef CONFIG_XENO_OPT_SHIRQ_LAYER
#define XN_ISR_SHARED   1
#else
#define XN_ISR_SHARED    XN_ISR_WARNING
#endif

and then catch all wrong use cases in one place :

int xnintr_attach(xnintr_t *intr, void *cookie)
{
        intr->hits = 0;
        intr->cookie = cookie;

+      if (intr->flags & XN_ISR_WARNING) {
+                   xnlogerr("blablabla...\n");
+                   return -EINVAL;
+      }

#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) ||
defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
        return xnintr_shirq_attach(intr, cookie);
#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
        return xnarch_hook_irq(intr->irq, &xnintr_irq_handler, intr->iack,
                               intr);
#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
}


?

-- 
Best regards,
Dmitry Adamushko

------=_Part_104407_5632698.1157483443647
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 05/09/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>@Dmitry: What happens under CONFIG_XENO_OPT_SHIRQ_LEVEL &amp;&amp;<br>!CONFIG_XENO_OPT_SHIRQ_EDGE when someone comes along with<br>XN_ISR_SHARED|XN_ISR_EDGE? Looks like the level-triggered shared handler<br>gets installed. Should we catch this? At Kconfig or at nucleus level?
</blockquote><div><br>
Currently XN_ISR_SHARED and XN_ISR_EDGE are unconditionally available
for any configuration. So nothing stops a user from calling
rtdm_irq_request( ... , RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE) even
when IRQ shared infrastructure is off.<br>
(the second call gives -EBUSY and a &quot;bug&quot; report is sent. I mean, if
the user has overlooked &quot;shared irq&quot; section on the configure step and
consider it a default behavior).<br>
<br>
Probably the clean solution would be to export XN_ISR_SHARED and
XN_ISR_EDGE only when their corresponding CONFIG_* parameters are
defined.<br>
<br>
Then e.g. rtdm skin should do :<br>
<br>
#ifdef XN_ISR_SHARED<br>
#define RTDM_IRQTYPE_SHARED XN_ISR_SHARED<br>
#endif<br>
<br>
and let a compiler complain on undefined symbol when a user tries to
use SHARED/EDGE without proper CONFIG options. Although, I'm not sure
it would be clear for all users.<br>
<br>
Another approach,<br>
<br>
in xnintr.h<br>
<br>
#ifdef CONFIG_XENO_OPT_SHIRQ_LAYER<br>
#define XN_ISR_SHARED&nbsp;&nbsp; 1<br>
#else<br>
#define XN_ISR_SHARED&nbsp;&nbsp;&nbsp; XN_ISR_WARNING<br>
#endif<br>
<br>
and then catch all wrong use cases in one place :<br>
<br>
int xnintr_attach(xnintr_t *intr, void *cookie)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; intr-&gt;hits = 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; intr-&gt;cookie = cookie;<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (intr-&gt;flags &amp; XN_ISR_WARNING) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
xnlogerr(&quot;blablabla...\n&quot;); <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xnintr_shirq_attach(intr, cookie);<br>
#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL &amp;&amp; !CONFIG_XENO_OPT_SHIRQ_EDGE */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xnarch_hook_irq(intr-&gt;irq, &amp;xnintr_irq_handler, intr-&gt;iack,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
intr);<br>
#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */<br>
}<br>
<br>
<br>
?<br clear="all">
</div></div><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_104407_5632698.1157483443647--

