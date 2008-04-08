Message-ID: <a7575bba0804072345r40957042u51c37bb3e79de4a1@domain.hid>
Date: Tue, 8 Apr 2008 14:45:51 +0800
From: "Josh Zhao" <joshsystem@domain.hid>
In-Reply-To: <47F22E76.5020009@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4621_23909254.1207637151858"
References: <a7575bba0804010328v43bbc606oe1d0a26f7ea12be8@domain.hid>
	<47F22E76.5020009@domain.hid>
Subject: Re: [Adeos-main] When do I need to add
	local_irq_disable_hw/local_irq_enable_hw in root domain?
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org

------=_Part_4621_23909254.1207637151858
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks,Philippe Gerum
     Well, I have another question:
      1.  Why I need take over the  linux syscall ,I think that it is only
for linux domain,so it looks no necessary to take over them?
      2. kernel/exit.c        ipipe_exit_notify(tsk);
    When a process exits, why adeos  has to take  over it ?

 This questions are very simply, but I m a beginner on  adeos.

thanks!


2008/4/1, Philippe Gerum <rpm@xenomai.org>:
>
> Josh Zhao wrote:
> > Hi ,
> >     When do I need to add  local_irq_disable_hw/local_irq_enable_hw in
> > root domain?  I think every irq/event should not be disabled in root
> > domain,but  why  i  have seen in some code ?
>
>
> Because some serialization still needs to be enforced, even for the root
> domain,
> particularly for code that may have an impact on the pipeline state.
>
> >    thanks!
> >
> >
> >
> > ------------------------------------------------------------------------
> >
> > _______________________________________________
> > Adeos-main mailing list
> > Adeos-main@domain.hid
> > https://mail.gna.org/listinfo/adeos-main
>
>
> --
>
> Philippe.
>

------=_Part_4621_23909254.1207637151858
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks,<span class="gmail_quote">Philippe Gerum <br>&nbsp;&nbsp;&nbsp;&nbsp; Well, I have another question:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.&nbsp; Why I need take over the&nbsp; linux syscall ,I think that it is only for linux domain,so it looks no necessary to take over them?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. kernel/exit.c &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ipipe_exit_notify(tsk);<br>&nbsp;&nbsp;&nbsp; When a process exits, why adeos&nbsp; has to take&nbsp; over it ?<br><br>&nbsp;This questions are very simply, but I m a beginner on&nbsp; adeos.  <br><br>thanks!<br>&nbsp;<br></span><br>
<div><span class="gmail_quote">2008/4/1, Philippe Gerum &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Josh Zhao wrote:<br> &gt; Hi ,<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; When do I need to add&nbsp;&nbsp;local_irq_disable_hw/local_irq_enable_hw in<br> &gt; root domain?&nbsp;&nbsp;I think every irq/event should not be disabled in root<br> &gt; domain,but&nbsp;&nbsp;why&nbsp;&nbsp;i&nbsp;&nbsp;have seen in some code ?<br>
 <br> <br>Because some serialization still needs to be enforced, even for the root domain,<br> particularly for code that may have an impact on the pipeline state.<br> <br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;thanks!<br> &gt;<br> &gt;<br> &gt;<br> &gt; ------------------------------------------------------------------------<br>
 &gt;<br> &gt; _______________________________________________<br> &gt; Adeos-main mailing list<br> &gt; <a href="mailto:Adeos-main@domain.hid">Adeos-main@domain.hid</a><br> &gt; <a href="https://mail.gna.org/listinfo/adeos-main">https://mail.gna.org/listinfo/adeos-main</a><br>
 <br> <br> --<br> <br>Philippe.<br> </blockquote></div><br>

------=_Part_4621_23909254.1207637151858--

