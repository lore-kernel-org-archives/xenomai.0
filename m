Message-ID: <a7575bba0804110323s4c594e93hdbf65cc9126f196e@domain.hid>
Date: Fri, 11 Apr 2008 18:23:46 +0800
From: "Josh Zhao" <joshsystem@domain.hid>
In-Reply-To: <47FF019B.5070200@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_24136_30248966.1207909426098"
References: <a7575bba0804100325k245d9741mce3d33a360df799e@domain.hid>
	<47FE5B79.9080506@domain.hid>
	<a7575bba0804101814o9bd5a9aobd9ecf4c42d90da9@domain.hid>
	<47FF019B.5070200@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] RTDM without mmap
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

------=_Part_24136_30248966.1207909426098
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Yes,you are right.
      The interrupt handler is taken over by ipipe, but other syscall is
still linux syscall.
   (1)  Does the RTDM implement the mmap feature or similar feature?


   I see that Xenomai can Write device drivers in user space , such as
rt_intr_create(&intr_desc,IRQ_NUMBER,I_AUTOENA);
  (2)  The irqhandler is in user space, how  interrupt (kernel mode)  can
invoke irqhandler(user mode ) ?

  (3) where is the kernel stack of  xenomai "primary" domain ?

   (4)   How to communicate between linux domain and xenomai domain in
inter-processes ?

   Thanks !



2008/4/11, Johan Borkhuis <j.borkhuis@domain.hid>:
>
> Josh Zhao wrote:
>
> > Thanks.
> >   So you mean I have to invoke  ipipe api directly in xenomai?
> >
> >
>
> No, if you look at the driver code you will see that this is a "standard"
> Linux driver, with the regular mmap handling, and not a Xenomai/RTDM driver.
> The only difference with a between this driver and a regular Linux driver is
> the fact that IPIPE is used for interrupt handling.
>
>  2008/4/11, Hannes Mayer <h.mayer@domain.hid>:
> >
> >
> > > Josh Zhao wrote:
> > >
> > >
> > > > Hi all,
> > > >      I want to write mmap driver for spending up to exchange data
> > > > between kernel and user,but i havn't seen the mmap field in RTDM
> > > >
> > > >
> > > structure.
> > >
> > >
> > > http://www.captain.at/adeos-ipipe-device-driver-mmap.php :-)
> > >
> > >
> >
> Regards,
>   Johan
>

------=_Part_24136_30248966.1207909426098
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Yes,you are right.<br>&nbsp; &nbsp; &nbsp; The interrupt handler is taken over by ipipe, but other syscall is still linux syscall.<br>&nbsp;&nbsp; (1)&nbsp; Does the RTDM implement the mmap feature or similar feature?<br><br><br>&nbsp;&nbsp; I see that Xenomai can Write device drivers in user space , such as&nbsp; rt_intr_create(&amp;intr_desc,IRQ_NUMBER,I_AUTOENA);<br>
&nbsp; (2)&nbsp; The irqhandler is in user space, how&nbsp; interrupt (kernel mode)&nbsp; can invoke irqhandler(user mode ) ?<br><br>&nbsp; (3) where is the kernel stack of&nbsp; xenomai "primary" domain ?<br><br>&nbsp;&nbsp; (4)&nbsp;&nbsp; How to communicate between linux domain and xenomai domain in inter-processes ?<br>
&nbsp;&nbsp; <br>&nbsp;&nbsp; Thanks !<br><br><br><br><div><span class="gmail_quote">2008/4/11, Johan Borkhuis &lt;<a href="mailto:j.borkhuis@domain.hid">j.borkhuis@domain.hid</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<span class="q">Josh Zhao wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Thanks.<br>
 &nbsp; So you mean I have to invoke &nbsp;ipipe api directly in xenomai?<br>
 &nbsp;<br>
</blockquote>
<br></span>
No, if you look at the driver code you will see that this is a &quot;standard&quot; Linux driver, with the regular mmap handling, and not a Xenomai/RTDM driver. The only difference with a between this driver and a regular Linux driver is the fact that IPIPE is used for interrupt handling.<span class="q"><br>

<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
2008/4/11, Hannes Mayer &lt;<a href="mailto:h.mayer@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">h.mayer@domain.hid</a>&gt;:<br>
 &nbsp;<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Josh Zhao wrote:<br>
 &nbsp; &nbsp;<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Hi all,<br>
 &nbsp; &nbsp; &nbsp;I want to write mmap driver for spending up to exchange data<br>
between kernel and user,but i havn&#39;t seen the mmap field in RTDM<br>
 &nbsp; &nbsp; &nbsp;<br>
</blockquote>
structure.<br>
<br>
<br>
<a href="http://www.captain.at/adeos-ipipe-device-driver-mmap.php" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://www.captain.at/adeos-ipipe-device-driver-mmap.php</a> :-)<br>
 &nbsp; &nbsp;<br>
</blockquote></blockquote>
<br></span>
Regards,<br><span class="sg">
 &nbsp; Johan<br>
</span></blockquote></div><br>

------=_Part_24136_30248966.1207909426098--

