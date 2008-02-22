Message-ID: <7289437c0802212358o23986c36vdc116f0824fd1abb@domain.hid>
Date: Fri, 22 Feb 2008 08:58:32 +0100
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <47BD977C.1040209@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7302_26159286.1203667112341"
References: <7289437c0802210658w29e21207q74f1cfdf36d6e17c@domain.hid>
	<47BD977C.1040209@domain.hid>
Subject: Re: [Xenomai-help] Kernel access of bad area with rtdm_event_wait()
	(MPC8347)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_7302_26159286.1203667112341
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Indeed, I have bad reproduced the problem in the code I suggest to you. But
your remark makes me understand  that I was in secondary mode and I never
switched to primary mode so ....
My issue is understood and solved.
Thanks

On Thu, Feb 21, 2008 at 4:23 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:

> Perrine Martignoni wrote:
> > Hello,
> >
> > I work on a MPC8347 processor and I found out a problem with
> > rtdm_event_wait(). I reproduce the problem with a simple code :
> >
> > *driver.c* :
> > #include <rtdm/rtdm_driver.h>
> >
> > MODULE_AUTHOR("P.Martignoni");
> > MODULE_LICENSE("GPL");
> >
> > #define DEV_FILE_NAME       "DspDev"
> > #define DRV_NAME            "DspDrv"
> >
> > #define DEV_FILE_DSP            "dspdev0"
> >
> > static rtdm_event_t s_ReadEvent;
> >
> > static int Open(struct rtdm_dev_context    *p_Context,
> >                 rtdm_user_info_t           *p_UserInfo,
> >                 int                        Oflags)
> > {
> >     int ret = 0;
> >
> >     rtdm_event_init(&s_ReadEvent,0);
> >
> >     // generates an error : Oops : Kernel access of bad area, sig : 11
> [#1]
> >     rtdm_event_wait(&s_ReadEvent);
>
> General advice: switch on XENO_OPT_DEBUG_RTDM (and IPIPE_DEBUG_CONTEXT)
> to catch service invocations from a wrong context, like here.
>
> Your mistake: calling a blocking Xenomai services from non-rt context
> (see your registration of Open in t_IdspDevice).
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux
>

------=_Part_7302_26159286.1203667112341
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Indeed, I have bad reproduced the problem in the code I suggest to you. But your remark makes me understand&nbsp; that I was in secondary mode and I never switched to primary mode so ....<br>My issue is understood and solved.<br>
Thanks<br><br><div class="gmail_quote">On Thu, Feb 21, 2008 at 4:23 PM, Jan Kiszka &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Perrine Martignoni wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I work on a MPC8347 processor and I found out a problem with<br>
&gt; rtdm_event_wait(). I reproduce the problem with a simple code :<br>
&gt;<br>
&gt; *driver.c* :<br>
&gt; #include &lt;rtdm/rtdm_driver.h&gt;<br>
&gt;<br>
&gt; MODULE_AUTHOR(&quot;P.Martignoni&quot;);<br>
&gt; MODULE_LICENSE(&quot;GPL&quot;);<br>
&gt;<br>
&gt; #define DEV_FILE_NAME &nbsp; &nbsp; &nbsp; &quot;DspDev&quot;<br>
&gt; #define DRV_NAME &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;DspDrv&quot;<br>
&gt;<br>
&gt; #define DEV_FILE_DSP &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;dspdev0&quot;<br>
&gt;<br>
&gt; static rtdm_event_t s_ReadEvent;<br>
&gt;<br>
&gt; static int Open(struct rtdm_dev_context &nbsp; &nbsp;*p_Context,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rtdm_user_info_t &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *p_UserInfo,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Oflags)<br>
&gt; {<br>
&gt; &nbsp; &nbsp; int ret = 0;<br>
&gt;<br>
&gt; &nbsp; &nbsp; rtdm_event_init(&amp;s_ReadEvent,0);<br>
&gt;<br>
&gt; &nbsp; &nbsp; // generates an error : Oops : Kernel access of bad area, sig : 11 [#1]<br>
&gt; &nbsp; &nbsp; rtdm_event_wait(&amp;s_ReadEvent);<br>
<br>
</div>General advice: switch on XENO_OPT_DEBUG_RTDM (and IPIPE_DEBUG_CONTEXT)<br>
to catch service invocations from a wrong context, like here.<br>
<br>
Your mistake: calling a blocking Xenomai services from non-rt context<br>
(see your registration of Open in t_IdspDevice).<br>
<br>
Jan<br>
<font color="#888888"><br>
--<br>
Siemens AG, Corporate Technology, CT SE 2<br>
Corporate Competence Center Embedded Linux<br>
</font></blockquote></div><br>

------=_Part_7302_26159286.1203667112341--

