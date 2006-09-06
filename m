Message-ID: <b647ffbd0609060159q7677cd30y80208afc58caf17@domain.hid>
Date: Wed, 6 Sep 2006 10:59:29 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <44FE6C55.1030900@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_112832_1389329.1157533169103"
References: <44FD7463.7010601@domain.hid> <44FD99E9.6030500@domain.hid>
	<44FD9F92.4050802@domain.hid>
	<b647ffbd0609051210p26c56690oe7b332190b3b702e@domain.hid>
	<44FE6C55.1030900@domain.hid>
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

------=_Part_112832_1389329.1157533169103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sharing itself is no problem: if your request an IRQ with XN_ISR_SHARED
> set but the nucleus is not able to actually assign it to more than one
> driver, the second request will simply fail. I see no need to deny the
> first request or even break the driver build.
>
Problematic is only the handling of edge-triggered shared IRQs with the
>
level-triggered handler (can cause lost IRQs). Probably a runtime check
> is best as we cannot control the configuration of, e.g., external RTDM
> drivers. What about the attached patch?


It's ok with me.

I just thought maybe it's better to break a build and alert a user earlier
(although, it's kind of inderect alert indeed) when the host environment
(Xeno) doesn't support a requested mode (e.g. SHARED_EDGE).

If such a driver (that requires EDGE_SHARED) is a part of the mainline, then
we may use Kconfig features either (1) to make it "selectable" only when
XENO_OPT_SHIRQ_EDGE is on or (2) select XENO_OPT_SHIRQ_EDGE automatically
when the driver has been choosen.




Jan
>
>
>


-- 
Best regards,
Dmitry Adamushko

------=_Part_112832_1389329.1157533169103
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><div>&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Sharing itself is no problem: if your request an IRQ with XN_ISR_SHARED<br>
set but the nucleus is not able to actually assign it to more than one<br>driver, the second request will simply fail. I see no need to deny the<br>first request or even break the driver build.<br>
</blockquote><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Problematic is only the handling of edge-triggered shared IRQs with the<br>
</blockquote><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">level-triggered handler (can cause lost IRQs). Probably a runtime check<br>is best as we cannot control the configuration of, 
e.g., external RTDM<br>drivers. What about the attached patch?</blockquote><div><br>
It's ok with me.<br>
<br>
I just thought maybe it's better to break a build and alert a user
earlier (although, it's kind of inderect alert indeed) when the host
environment (Xeno) doesn't support a requested mode (e.g. SHARED_EDGE).<br>
<br>
If such a driver (that requires EDGE_SHARED) is a part of the mainline,
then we may use Kconfig features either (1) to make it &quot;selectable&quot;
only when XENO_OPT_SHIRQ_EDGE is on or (2) select XENO_OPT_SHIRQ_EDGE
automatically when the driver has been choosen.<br>
<br>
<br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br><br></blockquote></div><br><br clear="all"><br>-- <br>Best regards,<br>
Dmitry Adamushko

------=_Part_112832_1389329.1157533169103--

