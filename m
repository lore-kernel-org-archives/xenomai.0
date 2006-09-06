Message-ID: <b647ffbd0609060808y11d7fd8eg99aee190da05a847@domain.hid>
Date: Wed, 6 Sep 2006 17:08:51 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <44FEE10F.5030208@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_117585_3967655.1157555331444"
References: <44FD7463.7010601@domain.hid> <44FD99E9.6030500@domain.hid>
	<44FD9F92.4050802@domain.hid>
	<b647ffbd0609051210p26c56690oe7b332190b3b702e@domain.hid>
	<44FE6C55.1030900@domain.hid>
	<b647ffbd0609060159q7677cd30y80208afc58caf17@domain.hid>
	<44FE943F.9000803@domain.hid>
	<b647ffbd0609060527o13a077f4ue1fd1b445b1379c7@domain.hid>
	<44FEE10F.5030208@domain.hid>
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

------=_Part_117585_3967655.1157555331444
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 06/09/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> See attached patch: XENO_OPT_SHIRQ would just be a menu-enabler without
> any affect outside kconfig. You could enabled it and leave the rest off
> (makes no sense of course) - as long as there are no edge-triggered
> users around.




-menu "Shared interrupts"
> +menuconfig XENO_OPT_SHIRQ
> +       bool "Shared interrupts"
>
> config XENO_OPT_SHIRQ_LEVEL
>         bool "Level-triggered interrupts"
> -       default n
> +       depends on XENO_OPT_SHIRQ
> +       default y
>         help
> -
> +
>         Enables support for shared level-triggered interrupts, so that
>         multiple real-time interrupt handlers are allowed to control
>         dedicated hardware devices which are configured to share
> @@ -369,7 +371,8 @@ config XENO_OPT_SHIRQ_LEVEL
>
> config XENO_OPT_SHIRQ_EDGE
>         bool "Edge-triggered interrupts"
> -       default n
> +       depends on XENO_OPT_SHIRQ
> +       default y
>         help


So a user may end up with XENO_OPT_SHIRQ being enabled while both LEVEL and
EDGE are disabled? Maybe it's worth to make LEVEL "y" by default as it's
likely to be a required option?




-- 
Best regards,
Dmitry Adamushko

------=_Part_117585_3967655.1157555331444
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><span class="gmail_quote">On 06/09/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
See attached patch: XENO_OPT_SHIRQ would just be a menu-enabler without<br>any affect outside kconfig. You could enabled it and leave the rest off<br>(makes no sense of course) - as long as there are no edge-triggered<br>
users around.</blockquote><div><br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">-menu &quot;Shared interrupts&quot;<br>+menuconfig XENO_OPT_SHIRQ<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Shared interrupts&quot;
<br><br> config XENO_OPT_SHIRQ_LEVEL<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bool &quot;Level-triggered interrupts&quot;<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default n<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on XENO_OPT_SHIRQ<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;help<br>-<br>+<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Enables support for shared level-triggered interrupts, so that
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;multiple real-time interrupt handlers are allowed to control<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dedicated hardware devices which are configured to share<br>@@ -369,7 +371,8 @@ config XENO_OPT_SHIRQ_LEVEL<br><br> config XENO_OPT_SHIRQ_EDGE
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bool &quot;Edge-triggered interrupts&quot;<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default n<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on XENO_OPT_SHIRQ<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;help</blockquote><div><br>
So a user may end up with XENO_OPT_SHIRQ being enabled while both LEVEL
and EDGE are disabled? Maybe it's worth to make LEVEL &quot;y&quot; by default as
it's likely to be a required option?<br>
<br>
&nbsp;</div></div><br clear="all"><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_117585_3967655.1157555331444--

