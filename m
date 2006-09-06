Message-ID: <b647ffbd0609061023u7b9aace9i464e9700dee58627@domain.hid>
Date: Wed, 6 Sep 2006 19:23:38 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <44FEEF50.2070407@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_119837_8425120.1157563418452"
References: <44FD7463.7010601@domain.hid> <44FD9F92.4050802@domain.hid>
	<b647ffbd0609051210p26c56690oe7b332190b3b702e@domain.hid>
	<44FE6C55.1030900@domain.hid>
	<b647ffbd0609060159q7677cd30y80208afc58caf17@domain.hid>
	<44FE943F.9000803@domain.hid>
	<b647ffbd0609060527o13a077f4ue1fd1b445b1379c7@domain.hid>
	<44FEE10F.5030208@domain.hid>
	<b647ffbd0609060808y11d7fd8eg99aee190da05a847@domain.hid>
	<44FEEF50.2070407@domain.hid>
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

------=_Part_119837_8425120.1157563418452
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 06/09/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Dmitry Adamushko wrote:




> -menu "Shared interrupts"
> >> +menuconfig XENO_OPT_SHIRQ
> >> +       bool "Shared interrupts"
> >>
> >> config XENO_OPT_SHIRQ_LEVEL
> >>         bool "Level-triggered interrupts"
> >> -       default n
> >> +       depends on XENO_OPT_SHIRQ
> >> +       default y
> >>         help
> >> -
> >> +
> >>         Enables support for shared level-triggered interrupts, so that
> >>         multiple real-time interrupt handlers are allowed to control
> >>         dedicated hardware devices which are configured to share
> >> @@ -369,7 +371,8 @@ config XENO_OPT_SHIRQ_LEVEL
> >>
> >> config XENO_OPT_SHIRQ_EDGE
> >>         bool "Edge-triggered interrupts"
> >> -       default n
> >> +       depends on XENO_OPT_SHIRQ
> >> +       default y
> >>         help
> >
> >
> > So a user may end up with XENO_OPT_SHIRQ being enabled while both LEVEL
> and
> > EDGE are disabled? Maybe it's worth to make LEVEL "y" by default as it's
> > likely to be a required option?
> >
>
> Do you see the "default y" above, no? :)


Arghhh, again... nop, I bet it was not there before! How did you manage to
hack my gmail account? :)


I thought about making only XENO_OPT_SHIRQ_LEVEL default y, but at least
> for poor x86 users on legacy hardware (ISA) sharing takes at least as
> often place with edge-triggered sources.


I thought it's level-triggered indeed. At least, judging by the fact that
linux provides a generic support only for level-triggered case.

e.g. cross-domain IRQ sharing (with you approach) would require only LEVEL
option (I actually wanted to port/rework, taking into account the
improvements we have discussed recently, your patch over some recent e.g.
e1000 driver + Xeno so to have an up-to-date example illustrating the
approach).




Jan
>
>


-- 
Best regards,
Dmitry Adamushko

------=_Part_119837_8425120.1157563418452
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 06/09/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Dmitry Adamushko wrote:</blockquote><div><br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; -menu &quot;Shared interrupts&quot;<br>&gt;&gt; +menuconfig XENO_OPT_SHIRQ<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Shared interrupts&quot;<br>&gt;&gt;<br>&gt;&gt; config XENO_OPT_SHIRQ_LEVEL<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Level-triggered interrupts&quot;<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default n<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on XENO_OPT_SHIRQ
<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<br>&gt;&gt; -<br>&gt;&gt; +<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Enables support for shared level-triggered interrupts, so that<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; multiple real-time interrupt handlers are allowed to control
<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dedicated hardware devices which are configured to share<br>&gt;&gt; @@ -369,7 +371,8 @@ config XENO_OPT_SHIRQ_LEVEL<br>&gt;&gt;<br>&gt;&gt; config XENO_OPT_SHIRQ_EDGE<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Edge-triggered interrupts&quot;
<br>&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default n<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on XENO_OPT_SHIRQ<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<br>&gt;<br>&gt;<br>&gt; So a user may end up with XENO_OPT_SHIRQ being enabled while both LEVEL and
<br>&gt; EDGE are disabled? Maybe it's worth to make LEVEL &quot;y&quot; by default as it's<br>&gt; likely to be a required option?<br>&gt;<br><br>Do you see the &quot;default y&quot; above, no? :)</blockquote><div><br>
Arghhh, again... nop, I bet it was not there before! How did you manage to hack my gmail account? :)<br>
<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I thought about making only XENO_OPT_SHIRQ_LEVEL default y, but at least<br>
for poor x86 users on legacy hardware (ISA) sharing takes at least as<br>often place with edge-triggered sources.</blockquote><div><br>
I thought it's level-triggered indeed. At least, judging by the fact
that linux provides a generic support only for level-triggered case.<br>
<br>
e.g. cross-domain IRQ sharing (with you approach) would require only
LEVEL option (I actually wanted to port/rework, taking into account the
improvements we have discussed recently, your patch over some recent
e.g. e1000 driver + Xeno so to have an up-to-date example illustrating
the approach).<br>
<br>
<br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br></blockquote></div><br><br clear="all"><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_119837_8425120.1157563418452--

