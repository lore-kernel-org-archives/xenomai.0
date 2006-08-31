Message-ID: <b647ffbd0608310435x4c482c40vbeb9947119e049f5@domain.hid>
Date: Thu, 31 Aug 2006 13:35:12 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <1157016475.4359.23.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_39058_16437427.1157024112868"
References: <b647ffbd0608221412s3167e49fx843da826f870b03c@domain.hid>
	<1156286237.4319.124.camel@domain.hid>
	<b647ffbd0608301436l431b0256k129a9000df7636db@domain.hid>
	<1156976481.28417.43.camel@domain.hid>
	<b647ffbd0608310208m514f5128l7276dd30c18b883@domain.hid>
	<1157016475.4359.23.camel@domain.hid>
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

------=_Part_39058_16437427.1157024112868
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> >         A way to solve this would be to have a transaction identifier
> >         into each
> >         object descriptor, that is incremented each time the object's
> >         internal
> >         state is altered (e.g. removal/insertion of some element
> >         from/to the
> >         pendq and so on).
> >
> > This works as long as the object descriptor itself can _not_ be
> > deleted in the mean time.
> >
> > IOW, "object->current_rev != prev_rev" makes sense only if "object"
> > remains to be valid.
> >
>
> This is the purpose of revalidating the object, step 6a.



arghh.. I missed 6a as I was looking at Jan's code and applied it to other
cases "as is".
And the register  would be a source of information on this step.


This whole discussion makes me think that if we want to go down the path
> of providing a generally safe and latency-aware support for the /proc
> routines, we should definitely define some common mechanisms to
> implement them, typically in the registry code.


Yep. Actually, the register may likely do both 6a and 6b steps. e.g. a
revalidation descriptor is stored in "xnobject" and something like
xnregister_object_changed(handle) should be called when the object's
internal state changes... just the very first idea and maybe not the best
one.


--
> Philippe.
>


-- 
Best regards,
Dmitry Adamushko

------=_Part_39058_16437427.1157024112868
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A way to solve this would be to have a transaction identifier<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; into each
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; object descriptor, that is incremented each time the object's<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; internal<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state is altered (e.g. removal/insertion of some element<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from/to the<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pendq and so on).
<br>&gt;<br>&gt; This works as long as the object descriptor itself can _not_ be<br>&gt; deleted in the mean time.<br>&gt;<br>&gt; IOW, &quot;object-&gt;current_rev != prev_rev&quot; makes sense only if &quot;object&quot;
<br>&gt; remains to be valid.<br>&gt;<br><br>This is the purpose of revalidating the object, step 6a.</blockquote><div><br>
<br>
arghh.. I missed 6a as I was looking at Jan's code and applied it to other cases &quot;as is&quot;.<br>
And the register&nbsp; would be a source of information on this step.<br>
<br>
<br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">This whole discussion makes me think that if we want to go down the path<br>of providing a generally safe and latency-aware support for the /proc
<br>routines, we should definitely define some common mechanisms to<br>implement them, typically in the registry code.</blockquote><div><br>
Yep. Actually, the register may likely do both 6a and 6b steps. e.g. a
revalidation descriptor is stored in &quot;xnobject&quot; and something like
xnregister_object_changed(handle) should be called when the object's
internal state changes... just the very first idea and maybe not the
best one.<br>
</div><div>&nbsp;<br>
<br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">--<br>Philippe.<br></blockquote></div><br>
<br>-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>

------=_Part_39058_16437427.1157024112868--

