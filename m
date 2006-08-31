Message-ID: <b647ffbd0608310208m514f5128l7276dd30c18b883@domain.hid>
Date: Thu, 31 Aug 2006 11:08:29 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <1156976481.28417.43.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_38116_10465086.1157015309834"
References: <b647ffbd0608221412s3167e49fx843da826f870b03c@domain.hid>
	<1156286237.4319.124.camel@domain.hid>
	<b647ffbd0608301436l431b0256k129a9000df7636db@domain.hid>
	<1156976481.28417.43.camel@domain.hid>
Subject: [Xenomai-core] Re: [patch,
	minor] irq proc output + ipipe_unregister_domain()
	vs. ipipe_sync_stage()
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

------=_Part_38116_10465086.1157015309834
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> A way to solve this would be to have a transaction identifier into each
> object descriptor, that is incremented each time the object's internal
> state is altered (e.g. removal/insertion of some element from/to the
> pendq and so on).


This works as long as the object descriptor itself can _not_ be deleted in
the mean time.

IOW, "object->current_rev != prev_rev" makes sense only if "object" remains
to be valid.

So it's not applicable to any native skin's primitives unless you have an
additional mean to  determine that the object was deleted / or guarantee
that it can't be deleted (e.g. reference counting).

In case of Jan's optimization it works as long as "nkpod" object is valid :

see comments below...

...
        /* Take a snapshot element-wise, restart if something changes
           underneath us. */

        while (holder) {
                xnthread_t *thread;
                xnsched_t *sched;
                xnticks_t period;
                int n;

                xnlock_get_irqsave(&nklock, s);          (1)

                if (nkpod->threadq_rev != rev)            (2)
                        goto restart;

                rev = nkpod->threadq_rev;                 (3)
...

btw, (3) doesn't make any sense. You can be there only when
"nkpod->thread_rev == rev".

In fact, nkpod also can be NULL in (2) if xnpod_shutdown() was called (skin
was unloaded) before (1). Although, it has quite low probability.



--
> Philippe.
>
>
-- 
Best regards,
Dmitry Adamushko

------=_Part_38116_10465086.1157015309834
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><div><br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">A way to solve this would be to have a transaction identifier into each<br>object descriptor, that is incremented each time the object's internal
<br>state is altered (e.g. removal/insertion of some element from/to the<br>pendq and so on). </blockquote><div><br>
This works as long as the object descriptor itself can _not_ be deleted in the mean time.<br>
<br>IOW, &quot;object-&gt;current_rev != prev_rev&quot; makes sense only if &quot;object&quot; remains to be valid.<br>
<br>
So it's not applicable to any native skin's primitives unless you have
an additional mean to&nbsp; determine that the object was deleted / or
guarantee that it can't be deleted (e.g. reference counting).<br>
<br>
In case of Jan's optimization it works as long as &quot;nkpod&quot; object is valid :<br>
<br>
see comments below...<br>
<br>
...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Take a snapshot element-wise, restart if something changes<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; underneath us. */<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (holder) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnthread_t *thread;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnsched_t *sched;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnticks_t period;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int n;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
xnlock_get_irqsave(&amp;nklock,
s);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1)<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (nkpod-&gt;threadq_rev !=
rev)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(2)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
goto restart;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rev =
nkpod-&gt;threadq_rev;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(3)<br>
...<br>
<br>
btw, (3) doesn't make any sense. You can be there only when &quot;nkpod-&gt;thread_rev == rev&quot;.<br>
<br>
In fact, nkpod also can be NULL in (2) if xnpod_shutdown() was called
(skin was unloaded) before (1). Although, it has quite low probability.<br>
<br>
<br>
<br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">--<br>Philippe.<br><br></blockquote></div><br>-- <br>Best regards,<br>Dmitry Adamushko


------=_Part_38116_10465086.1157015309834--

