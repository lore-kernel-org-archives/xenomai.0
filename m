Message-ID: <fd6a47a90711020730m662abcc9q69fcb4f87ad470cc@domain.hid>
Date: Fri, 2 Nov 2007 15:30:48 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
In-Reply-To: <fd6a47a90711020636t73e357d5ub9cbca0675adc1d7@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5294_6943601.1194013849015"
References: <fd6a47a90711020421u6c5a6dadqff4864eec6aa188@domain.hid>
	<472B0EED.40209@domain.hid>
	<fd6a47a90711020549u5630ec9cgda7042c8c6c0f10a@domain.hid>
	<fd6a47a90711020636t73e357d5ub9cbca0675adc1d7@domain.hid>
Subject: Re: [Xenomai-core] Registering MSI interrupt with Xenomai fails
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

------=_Part_5294_6943601.1194013849015
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
>
> Now looking into xnintr_attach().
>

In xnintr_attach(), the crash occurs in xnarch_set_irq_affinity(). If the
call is removed, the driver works as expected (gaining another 3 usec of
latency). Now investigating ipipe_set_irq_affinity.

Jeroen.


>
>
> Jeroen.
>

------=_Part_5294_6943601.1194013849015
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>&nbsp;</div>
<div>Now looking into xnintr_attach().</div></blockquote>
<div>&nbsp;</div>
<div>In xnintr_attach(), the crash occurs in xnarch_set_irq_affinity(). If the call is removed, the driver works as expected (gaining another 3 usec of latency). Now investigating ipipe_set_irq_affinity.</div>
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><span class="sg">
<div>&nbsp;</div>
<p>Jeroen.</p></span></blockquote><br>

------=_Part_5294_6943601.1194013849015--

