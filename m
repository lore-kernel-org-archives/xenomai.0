Message-ID: <1312486056.62780.YahooMailClassic@domain.hid>
Date: Thu, 4 Aug 2011 12:27:36 -0700 (PDT)
From: Philip Ha <philwman@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2032251139-1312486056=:62780"
Subject: Re: [Xenomai-help] clock problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

--0-2032251139-1312486056=:62780
Content-Type: text/plain; charset=us-ascii

> Would it be possible for you to send mails formatted correctly?
>
> Then the bug is somewhere in between the serial line and the test
> application, including possibly in the driver.
>
> In order to know where it is, you should compute the latency at each
> point on this path: when receiving the interrupt, when waking up the
> task, etc...
>
> -- 
>                                                                Gilles.



Hi Gilles,

Sorry for the formatting, I am new to mailing lists.

I have looked at the latency in the 16550A driver. The first thing 
the driver does in its ISR is to call rtdm_clock_read and store the 
resulting timestamp in a "struct rtser_event". The code I posted 
grabs this structure. If I use this as my timestamp I get the exact
same timing results.

It seems like the clock used by rtdm_clock_read is fast. I don't
see how I could get a delay according to rtdm_clock_read of 
1000000us between interrupts that I know are being triggered by an 
event coming in at 1000000 us.

Do you have any suggestions on what I can test?

Thanks for all your help.

Philip Ha

--0-2032251139-1312486056=:62780
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;"><pre>&gt; Would it be possible for you to send mails formatted correctly?<br>&gt;<br>&gt; Then the bug is somewhere in between the serial line and the test<br>&gt; application, including possibly in the driver.<br>&gt;<br>&gt; In order to know where it is, you should compute the latency at each<br>&gt; point on this path: when receiving the interrupt, when waking up the<br>&gt; task, etc...<br>&gt;<br>&gt; -- <br>&gt;                                                                Gilles.<br></pre><br><br><br>Hi Gilles,<br><br>Sorry for the formatting, I am new to mailing lists.<br><br>I have looked at the latency in the 16550A driver. The first thing <br>the driver does in its ISR is to call rtdm_clock_read and store the <br>resulting timestamp in a "struct rtser_event". The code I posted <br>grabs this structure. If I use this as my timestamp I get the
 exact<br>same timing results.<br><br>It seems like the clock used by rtdm_clock_read is fast. I don't<br>see how I could get a delay according to rtdm_clock_read of <br>1000000us between interrupts that I know are being triggered by an <br>event coming in at 1000000 us.<br><br>Do you have any suggestions on what I can test?<br><br>Thanks for all your help.<br><br>Philip Ha<br></td></tr></table>
--0-2032251139-1312486056=:62780--

