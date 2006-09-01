Message-ID: <b647ffbd0609010023h5de6aa9bx6db265832aecb6f1@domain.hid>
Date: Fri, 1 Sep 2006 09:23:44 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] IRQ Enable/Disable
In-Reply-To: <44F72F35.4070109@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_53952_9855038.1157095424055"
References: <44F6E774.2000701@domain.hid> <44F72F35.4070109@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

------=_Part_53952_9855038.1157095424055
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[...]

Dmitry, Philippe, what's the reason for the split up in the core? Does
> any skin require this?


Can be so if some original interface requires it. e.g. does RTAI enable the
irq line on rt_request_irq() ?
Although, RTAI skin bypasses the nucleus layer and calls rthal_irq_request()
directly.

In general I would say that this approach is more flexible as long as shared
IRQ mechanism is not involved. And then it makes things more complicated (at
least less nicer), e.g. the implementation of nested IRQ enable/disable
calls.

I have found some related discussion (actually, with a draft patch for
nested IRQ enable/disable support)

https://mail.gna.org/public/xenomai-core/2006-04/msg00103.html


Jan
>
>
-- 
Best regards,
Dmitry Adamushko

------=_Part_53952_9855038.1157095424055
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><div><br>
[...]&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Dmitry, Philippe, what's the reason for the split up in the core? Does<br>any skin require this?
</blockquote><div><br>
Can be so if some original interface requires it. e.g. does RTAI enable the irq line on rt_request_irq() ?<br>
Although, RTAI skin bypasses the nucleus layer and calls rthal_irq_request() directly.<br>
<br>
In general I would say that this approach is more flexible as long as
shared IRQ mechanism is not involved. And then it makes things more
complicated (at least less nicer), e.g. the implementation of nested
IRQ enable/disable calls.<br>
<br>
I have found some related discussion (actually, with a draft patch for nested IRQ enable/disable support)<br>
<br>
<a href="https://mail.gna.org/public/xenomai-core/2006-04/msg00103.html">https://mail.gna.org/public/xenomai-core/2006-04/msg00103.html</a><br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br></blockquote></div><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_53952_9855038.1157095424055--

