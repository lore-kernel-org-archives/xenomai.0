Message-ID: <6132061f0807091038s38aad988w5493bd8f4b53adab@domain.hid>
Date: Wed, 9 Jul 2008 14:38:19 -0300
From: "Breno Carneiro Pinheiro" <brenodee@domain.hid>
In-Reply-To: <4861F67F.7090805@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1003_11935377.1215625100675"
References: <838862596@domain.hid> <4861F67F.7090805@domain.hid>
Subject: Re: [Xenomai-help] latency in kernel mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Joachim Meyer <Jogi95@domain.hid>

------=_Part_1003_11935377.1215625100675
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi guys, I wonder do the same test as described below on my system. Where's
the timerbench driver? I was looking for this option but I couldn't find it
on my .conifg.
Is it necessary to do what Joachim said at previous email?:

" I enabled the timerbench module, and installed it with the other modules
(IRQ Benchmark and Context Switch).
The Switchtest test works, so I think the modules are correct installed and
the tests are able to load them...."

Thanks,

Breno

2008/6/25 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:

> Joachim Meyer wrote:
> > bash-3.00# ./run -- -t1
> > *
> > *
> > * Type ^C to stop this application.
> > *
> > *
> > == Sampling period: 100 us
> > == Test mode: in-kernel periodic task
> > == All results in microseconds
> > latency: failed to start in-kernel timer benchmark, code -25
> >
> ---|------------|------------|------------|--------|-------------------------
> > RTS|  267928.028|  805352.732|      32.768|       0|    00:00:10/00:00:10
> > bash-3.00#
> >
> ----------------------------------------------------------------------------------------------
> >
> > Thanks for your help and patience.
>
> Enable the timerbench driver in kernel configuration. If you want to
> enable several testing drivers and everything to work "out of thebox",
> enable them as module, and do not load the modules by yourself, let the
> run script load the apropriate module. Otherwise, specify the correct
> testing driver index to the test you run.
>
> --
>
>
>                                            Gilles.
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

------=_Part_1003_11935377.1215625100675
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi guys, I wonder do the same test as described below on my system. Where&#39;s the timerbench driver? I was looking for this option but I couldn&#39;t find it on my .conifg.<br>Is it necessary to do what Joachim said at previous email?:<br>
&nbsp;<br>&quot; I enabled the timerbench module, and installed it with the other modules (IRQ Benchmark and Context Switch).<br>
The Switchtest test works, so I think the modules are correct installed and the tests are able to load them....&quot;<br><br>Thanks,<br><br>Breno<br><br><div class="gmail_quote">2008/6/25 Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">Joachim Meyer wrote:<br>
&gt; bash-3.00# ./run -- -t1<br>
&gt; *<br>
&gt; *<br>
&gt; * Type ^C to stop this application.<br>
&gt; *<br>
&gt; *<br>
&gt; == Sampling period: 100 us<br>
&gt; == Test mode: in-kernel periodic task<br>
&gt; == All results in microseconds<br>
&gt; latency: failed to start in-kernel timer benchmark, code -25<br>
&gt; ---|------------|------------|------------|--------|-------------------------<br>
&gt; RTS| &nbsp;267928.028| &nbsp;805352.732| &nbsp; &nbsp; &nbsp;32.768| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp;00:00:10/00:00:10<br>
&gt; bash-3.00#<br>
&gt; ----------------------------------------------------------------------------------------------<br>
&gt;<br>
&gt; Thanks for your help and patience.<br>
<br>
</div>Enable the timerbench driver in kernel configuration. If you want to<br>
enable several testing drivers and everything to work &quot;out of thebox&quot;,<br>
enable them as module, and do not load the modules by yourself, let the<br>
run script load the apropriate module. Otherwise, specify the correct<br>
testing driver index to the test you run.<br>
<br>
--<br>
<font color="#888888"><br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Gilles.<br>
</font><div><div></div><div class="Wj3C7c"><br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href="https://mail.gna.org/listinfo/xenomai-help" target="_blank">https://mail.gna.org/listinfo/xenomai-help</a><br>
</div></div></blockquote></div><br>

------=_Part_1003_11935377.1215625100675--

