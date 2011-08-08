Message-ID: <1312821858.88556.YahooMailClassic@domain.hid>
Date: Mon, 8 Aug 2011 09:44:18 -0700 (PDT)
From: Philip Ha <philwman@domain.hid>
In-Reply-To: <4E3BE7B7.3040505@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1409736971-1312821858=:88556"
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

--0-1409736971-1312821858=:88556
Content-Type: text/plain; charset=us-ascii

> Hi Gilles,
> 
> Sorry for the formatting, I am new to mailing lists.
> 
> I have looked at the latency in the 16550A driver. The first thing 
> the driver does in its ISR is to call rtdm_clock_read and store the 
> resulting timestamp in a "struct rtser_event". The code I posted 
> grabs this structure. If I use this as my timestamp I get the exact
> same timing results.

>> are you sure that the interrupt triggers as soon as you receive a
>> character, and not upon timeout when not receiving characters for some
>> time? After all, 100us is approximately the time to transmit one
>> character at 115200 bauds on the serial line.
>>
>> -- 
>>                                           Gilles.

Hi Gilles,

I am not sending characters, I am sending a pulse from a 
function generator into the DSR pin and looking for the rising
edge event ( RTSER_EVENT_MODEMHI ). Any latency in the system
should be similar for every pulse it receives, therefore the
time between pulses should still be 1000000us.

Thanks,

Philip Ha




--0-1409736971-1312821858=:88556
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;">&gt; Hi Gilles,<br><pre>&gt; <br>&gt; Sorry for the formatting, I am new to mailing lists.<br>&gt; <br>&gt; I have looked at the latency in the 16550A driver. The first thing <br>&gt; the driver does in its ISR is to call rtdm_clock_read and store the <br>&gt; resulting timestamp in a "struct rtser_event". The code I posted <br>&gt; grabs this structure. If I use this as my timestamp I get the exact<br>&gt; same timing results.<br><br>&gt;&gt; are you sure that the interrupt triggers as soon as you receive a<br>&gt;&gt; character, and not upon timeout when not receiving characters for some<br>&gt;&gt; time? After all, 100us is approximately the time to transmit one<br>&gt;&gt; character at 115200 bauds on the serial line.<br>&gt;&gt;<br>&gt;&gt; -- <br>&gt;&gt;                                           Gilles.<br><br>Hi Gilles,<br><br>I am not sending
 characters, I am sending a pulse from a <br>function generator into the DSR pin and looking for the rising<br>edge event ( RTSER_EVENT_MODEMHI ). Any latency in the system<br>should be similar for every pulse it receives, therefore the<br>time between pulses should still be 1000000us.<br><br>Thanks,<br><br>Philip Ha<br><br><br><br></pre></td></tr></table>
--0-1409736971-1312821858=:88556--

