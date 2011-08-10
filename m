Message-ID: <1312989511.75315.YahooMailClassic@domain.hid>
Date: Wed, 10 Aug 2011 08:18:31 -0700 (PDT)
From: Philip Ha <philwman@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-62630010-1312989511=:75315"
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

--0-62630010-1312989511=:75315
Content-Type: text/plain; charset=us-ascii


> The question remains: are you sure the UART does not introduce the
> delay, have you checked the datasheet?
>
> -- 
                                                                Gilles.
Hi Gilles,

I apologize for the delay in responding the last message.

I measured the latency of the UART by pulsing the DTR pin on the 
serial port as soon as the ISR is called. Using an oscilloscope 
I monitored the DSR input signal from the function generator and 
the DTR signal from the serial port. The time difference between 
signals was 6-9 us. Therefore the latency of the UART is < 10 us 
at all times.

As long as the UART latency is consistent the size of it does not
matter for the test I am performing. An input signal that comes in 
every 1000000 us should result in the 16550 ISR being called every 
1000000 us.

The function generator is accurate to 1us, the UART ISR latency 
jitter is approximately 3 us. Therefore I would not expect to see
100 us of timing measurement inacurracy using OS time stamps. It 
is also strange that this timing measurement inaccuracy changes 
every time the system is rebooted.

Any thoughts? 


Thanks,

Philip Ha

--0-62630010-1312989511=:75315
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;"><pre><br>&gt; The question remains: are you sure the UART does not introduce the<br>&gt; delay, have you checked the datasheet?<br>&gt;<br>&gt; -- <br>                                                                Gilles.<br></pre>Hi Gilles,<br><br>I apologize for the delay in responding the last message.<br><br>I measured the latency of the UART by pulsing the DTR pin on the <br>serial port as soon as the ISR is called. Using an oscilloscope <br>I monitored the DSR input signal from the function generator and <br>the DTR signal from the serial port. The time difference between <br>signals was 6-9 us. Therefore the latency of the UART is &lt; 10 us <br>at all times.<br><br>As long as the UART latency is consistent the size of it does not<br>matter for the test I am performing. An input signal that comes in <br>every 1000000 us should result in the 16550 ISR
 being called every <br>1000000 us.<br><br>The function generator is accurate to 1us, the UART ISR latency <br>jitter is approximately 3 us. Therefore I would not expect to see<br>100 us of timing measurement inacurracy using OS time stamps. It <br>is also strange that this timing measurement inaccuracy changes <br>every time the system is rebooted.<br><br>Any thoughts? <br><br><br>Thanks,<br><br>Philip Ha<br></td></tr></table>
--0-62630010-1312989511=:75315--

