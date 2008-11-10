Message-ID: <217b7eb20811100631y34475f5dw7842292da26ac0d9@domain.hid>
Date: Mon, 10 Nov 2008 14:31:52 +0000
From: Hank <hank007@domain.hid>
In-Reply-To: <47b5efc54278344fcdfe4fc0e1a2c346.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_95333_16378256.1226327512829"
References: <mailman.10531.1226258953.25037.xenomai@xenomai.org>
	<217b7eb20811091134h77fbd77bm2e880708b21e5b06@domain.hid>
	<47b5efc54278344fcdfe4fc0e1a2c346.squirrel@domain.hid>
Subject: Re: [Xenomai-help] Xenomai skins init errors
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
Cc: xenomai@xenomai.org

------=_Part_95333_16378256.1226327512829
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, Nov 10, 2008 at 11:46 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

>
> Hank wrote:
> > Hi
> >
> > I'm Porting Xenomai to Freescale imx31 platform. Have previously been
> > using
> > ipipe 1.7 + xenomai 2.4.4. Now migrated to ipipe 1.9 and latest Xenomai
> > snapshot. The kernel is 2.6.24. Ipipe seems to OK but getting errors on
> > xenomai skins initialization:
>
> Xenomai 2.4.6 is now released, and should contain a patch to be applied to
> linux 2.6.26 to add support for IMX31, including high resolution timers.
>
> >
> >
> > -----------------------------------------------------------
> > I-pipe: Domain Xenomai registered.
> >
> > Xenomai: hal/arm started.
> >
> > Xenomai: real-time nucleus v2.5-devel (Flying In A Blue Dream) loaded.
> >
> > Xenomai: native skin init failed, code -38.
> >
> > Xenomai: starting POSIX services.
> >
> > Xenomai: POSIX skin init failed, code -38.
> >
> > Xenomai: RTDM skin init failed, code -38.
>
> This looks like you do not pass the correct timer name to
> ipipe_request_tickdev. The patch included with xenomai 2.4.6 should not
> have this issue. See:
>
> http://www.xenomai.org/index.php/I-pipe:ArmPorting#Modifying_Xenomai_headers_to_add_a_new_board
> --
>                     Gilles.
>
>
Thanks Gilles. This indeed was the issue and is resolved.

-Hank

------=_Part_95333_16378256.1226327512829
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, Nov 10, 2008 at 11:46 AM, Gilles Chanteperdrix <span dir="ltr">&lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d"><br>
Hank wrote:<br>
&gt; Hi<br>
&gt;<br>
&gt; I&#39;m Porting Xenomai to Freescale imx31 platform. Have previously been<br>
&gt; using<br>
&gt; ipipe 1.7 + xenomai <a href="http://2.4.4." target="_blank">2.4.4.</a> Now migrated to ipipe 1.9 and latest Xenomai<br>
&gt; snapshot. The kernel is <a href="http://2.6.24." target="_blank">2.6.24.</a> Ipipe seems to OK but getting errors on<br>
&gt; xenomai skins initialization:<br>
<br>
</div>Xenomai 2.4.6 is now released, and should contain a patch to be applied to<br>
linux 2.6.26 to add support for IMX31, including high resolution timers.<br>
<div class="Ih2E3d"><br>
&gt;<br>
&gt;<br>
&gt; -----------------------------------------------------------<br>
&gt; I-pipe: Domain Xenomai registered.<br>
&gt;<br>
&gt; Xenomai: hal/arm started.<br>
&gt;<br>
&gt; Xenomai: real-time nucleus v2.5-devel (Flying In A Blue Dream) loaded.<br>
&gt;<br>
&gt; Xenomai: native skin init failed, code -38.<br>
&gt;<br>
&gt; Xenomai: starting POSIX services.<br>
&gt;<br>
&gt; Xenomai: POSIX skin init failed, code -38.<br>
&gt;<br>
&gt; Xenomai: RTDM skin init failed, code -38.<br>
<br>
</div>This looks like you do not pass the correct timer name to<br>
ipipe_request_tickdev. The patch included with xenomai 2.4.6 should not<br>
have this issue. See:<br>
<a href="http://www.xenomai.org/index.php/I-pipe:ArmPorting#Modifying_Xenomai_headers_to_add_a_new_board" target="_blank">http://www.xenomai.org/index.php/I-pipe:ArmPorting#Modifying_Xenomai_headers_to_add_a_new_board</a><br>

--<br>
<font color="#888888"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Gilles.<br>
<br>
</font></blockquote></div><br>Thanks Gilles. This indeed was the issue and is resolved.<br><br>-Hank<br>

------=_Part_95333_16378256.1226327512829--

