Message-ID: <217b7eb20809180817p15cb4161o8ef6482fe835f143@domain.hid>
Date: Thu, 18 Sep 2008 20:17:30 +0500
From: Hank <hank007@domain.hid>
In-Reply-To: <48D26F8F.8030401@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_29048_28512284.1221751050164"
References: <mailman.1448.1221743175.22433.adeos-main@gna.org>
	<217b7eb20809180614u28d04ef8vc63fadb0b7db1ae9@domain.hid>
	<48D255E0.7000603@domain.hid>
	<217b7eb20809180722w423f78b2qb4d7db0bfb248953@domain.hid>
	<48D264B6.6080504@domain.hid>
	<217b7eb20809180807j9bf19ecnb43d69355d2e4ff6@domain.hid>
	<48D26F8F.8030401@domain.hid>
Subject: Re: [Adeos-main] adeos-ipipe-2.6.19-arm-1.7-00 on iMX31: init
	doesn't complete!
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

------=_Part_29048_28512284.1221751050164
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 9/18/08, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Hank wrote:
> > Well, some of the tricks helped during initial stages but other don't
> seem
> > to apply now as there is no crash here!
>
> Oh yes ? Are you sure the timer is ticking correctly ?
>
> --
>                                                 Gilles.


Yes. Also, forced it to a soft lockup crash in ret_to_user() and trace
showed timer interrupt ticking and updating process timers all the way up!





-- 
Freedom is everything

------=_Part_29048_28512284.1221751050164
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><span class="gmail_quote">On 9/18/08, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hank wrote:<br>&gt; Well, some of the tricks helped during initial stages but other don&#39;t seem<br>&gt; to apply now as there is no crash here!<br>
<br>Oh yes ? Are you sure the timer is ticking correctly ?<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles.</blockquote>
<div>&nbsp;</div>
<div>Yes. Also, forced it to&nbsp;a soft lockup&nbsp;crash&nbsp;in ret_to_user() and trace showed timer interrupt ticking and updating process timers all the way up!</div><br>&nbsp;</div><br><br clear="all"><br>-- <br>Freedom is everything 

------=_Part_29048_28512284.1221751050164--

