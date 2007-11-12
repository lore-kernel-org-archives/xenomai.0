Message-ID: <fd6a47a90711120911q34d2fba5w22683bd06598b150@domain.hid>
Date: Mon, 12 Nov 2007 18:11:10 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
In-Reply-To: <4738839E.8020203@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_24714_31860760.1194887470973"
References: <fd6a47a90711120739n11b803cfy8bc4b8b09a995fef@domain.hid>
	<4738839E.8020203@domain.hid>
Subject: Re: [Xenomai-core] Long execution time inside
	__ipipe_unstall_iret_root()
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
Cc: xenomai-core <xenomai@xenomai.org>

------=_Part_24714_31860760.1194887470973
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> So, unless the IRQ below
> should have been raised much earlier, there is no issue here.


The point is: I actually do have interrupts (not the IPI that is visible
here) that are being withheld (on average 80 us late) during this period. On
this particular setup, I have seen numbers exceeding 300 us. Strangely
enough, the latency test does not show these hiccups. I'm suspecting cache
issues, but I would think these numbers are a bit large for that.

What you say is that between tracepoint 0x27 and 0x29, we may have entered
userland. But where does this happen, given that point 0x28 is not executed
?

I also do understand that, if a cli or sti would still lurk somewhere in
this configuration, I'm going to have a real bad time... Although I doubt
it, since the unexpected latencies always happen at this particular point.

Jeroen.


If there is a real delay, evil user land may have switched off IRQs
> (given root privileges), or there is some hardware related IRQ delivery
> latency. But this cannot be determined via the tracer as it only sees
> kernel land.
>
>

------=_Part_24714_31860760.1194887470973
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">So, unless the IRQ below<br>should have been raised much earlier, there is no issue here.
</blockquote><div><br>The point is: I actually do have interrupts (not the IPI that is visible here) that are being withheld (on average 80 us late) during this period. On this particular setup, I have seen numbers exceeding 300 us. Strangely enough, the latency test does not show these hiccups. I&#39;m suspecting cache issues, but I would think these numbers are a bit large for that.
<br><br>What you say is that between tracepoint 0x27 and 0x29, we may have entered userland. But where does this happen, given that point 0x28 is not executed ?<br><br>I also do understand that, if a cli or sti would still lurk somewhere in this configuration, I&#39;m going to have a real bad time... Although I doubt it, since the unexpected latencies always happen at this particular point.
<br><br>Jeroen.<br><br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">If there is a real delay, evil user land may have switched off IRQs
<br>(given root privileges), or there is some hardware related IRQ delivery<br>latency. But this cannot be determined via the tracer as it only sees<br>kernel land.<br><br></blockquote></div>

------=_Part_24714_31860760.1194887470973--

