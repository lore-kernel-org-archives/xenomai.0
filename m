Message-ID: <b647ffbd0609150215t30745de9x4e1877fe3e11a43@domain.hid>
Date: Fri, 15 Sep 2006 11:15:08 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <1158308512.5009.35.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_250090_23137203.1158311708748"
References: <58168.129.217.4.64.1158067468.squirrel@domain.hid>
	<1158091876.5020.8.camel@domain.hid>
	<b647ffbd0609121358v5b5bff80o6e4e08c859eb110a@domain.hid>
	<450727D1.6060203@domain.hid> <4507C49A.5070909@domain.hid>
	<b647ffbd0609140055t328fec1fi3b5d86da178d790e@domain.hid>
	<1158223595.5040.16.camel@domain.hid>
	<b647ffbd0609141512t47b1835em49c9873985aa5fb3@domain.hid>
	<1158308512.5009.35.camel@domain.hid>
Subject: [Xenomai-core] Re: [Xenomai-help] Bad EIP kernel-Oops
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

------=_Part_250090_23137203.1158311708748
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 15/09/06, Philippe Gerum <rpm@xenomai.org> wrote:
>
> On Fri, 2006-09-15 at 00:12 +0200, Dmitry Adamushko wrote:
>
> [...]
>
> >
> > And it's not a good idea to get ipipe_catch_event() buzy spinning as
> > (as I understand) ipipe_dispatch_event() may take, in general, an
> > unbounded amount of time.
> >
>
> Actually, this is not an issue, since there is no requirement for
> bounded execution time in ipipe_catch_event(). This call is part of the
> initialization chores, it is not meant as being deterministic.


I meant it's not ok to keep a CPU spinning all this time. But your approach
with schedule_timeout() is really better. And probably, we don't need to try
being more general that it's really required as we need to get synched only
with ipipe_catch_event(..., NULL) from the Linux domain.



--
> Philippe.
>
>


-- 
Best regards,
Dmitry Adamushko

------=_Part_250090_23137203.1158311708748
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 15/09/06, <b class="gmail_sendername">Philippe Gerum</b> &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Fri, 2006-09-15 at 00:12 +0200, Dmitry Adamushko wrote:<br><br>[...]<br><br>&gt;<br>&gt; And it's not a good idea to get ipipe_catch_event() buzy spinning as<br>&gt; (as I understand) ipipe_dispatch_event() may take, in general, an
<br>&gt; unbounded amount of time.<br>&gt;<br><br>Actually, this is not an issue, since there is no requirement for<br>bounded execution time in ipipe_catch_event(). This call is part of the<br>initialization chores, it is not meant as being deterministic.
</blockquote><div><br>
I meant it's not ok to keep a CPU spinning all this time. But your
approach with schedule_timeout() is really better. And probably, we
don't need to try being more general that it's really required as we
need to get synched only with ipipe_catch_event(..., NULL) from the
Linux domain.<br>
&nbsp;<br>
<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">--<br>Philippe.<br><br></blockquote></div><br><br clear="all"><br>-- <br>Best regards,
<br>Dmitry Adamushko

------=_Part_250090_23137203.1158311708748--

