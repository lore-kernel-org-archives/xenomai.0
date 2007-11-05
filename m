Message-ID: <fd6a47a90711051114i2ee37cf1p565f81542cfa570a@domain.hid>
Date: Mon, 5 Nov 2007 20:14:07 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
In-Reply-To: <fd6a47a90711031236g7415be6fn3a6d838846e082ef@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_10576_12056519.1194290047178"
References: <fd6a47a90711020421u6c5a6dadqff4864eec6aa188@domain.hid>
	<472B0EED.40209@domain.hid>
	<fd6a47a90711020549u5630ec9cgda7042c8c6c0f10a@domain.hid>
	<fd6a47a90711020636t73e357d5ub9cbca0675adc1d7@domain.hid>
	<fd6a47a90711020730m662abcc9q69fcb4f87ad470cc@domain.hid>
	<472B3B5C.9010002@domain.hid>
	<fd6a47a90711031042j568938fev22c3b5a6f99d8e17@domain.hid>
	<472CBBAC.7030403@domain.hid>
	<fd6a47a90711031236g7415be6fn3a6d838846e082ef@domain.hid>
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

------=_Part_10576_12056519.1194290047178
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> Could there be any reason why e.g. a pci_config_read_dword() call would
> fail in Xenomai context (because when still in the module probe code, I
> can perform the call correctly - in both cases I checked the
> dev->bus->ops->read/write pointers and they are identical) ?
>

Today I moved the Xenomai ISR registration (rtdm_request_irq)) from the RTDM
open method (rtdm_dev_open) to the module probe code (dev_probe). Then the
registration works, but not always. Upon frequent insmod- and rmmodding, I
still can make the machine freeze.

I'm now more or less lost and open to any ideas...


Jeroen.


BTW: In the process of removing all instrumentation, I inadvertently
upgraded to SVN head (3149), after which no Xenomai process could be run
anymore (Binding failed. Bad address.). I solved that temporarily by
reverting to my original 3146.


>
>
> Jeroen.
>

------=_Part_10576_12056519.1194290047178
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>Could there be any reason why&nbsp;e.g. a pci_config_read_dword()&nbsp;call would fail in Xenomai context&nbsp;(because when still in the module probe code, I can&nbsp;perform the call correctly - in both cases I checked the dev-&gt;bus-&gt;ops-&gt;read/write pointers and they are identical) ? 
</div></blockquote>
<div>&nbsp;</div>
<div>Today I moved the Xenomai ISR registration (rtdm_request_irq)) from&nbsp;the RTDM open method (rtdm_dev_open) to the module probe code&nbsp;(dev_probe). Then the registration works, but not always. Upon frequent insmod- and rmmodding, I still can make the machine freeze.
</div>
<div>&nbsp;</div>
<div>I&#39;m now more or less lost and open to any ideas...</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>BTW: In the process of removing all instrumentation, I&nbsp;inadvertently upgraded to SVN head (3149), after which no Xenomai process could be run anymore (Binding failed. Bad address.). I solved that temporarily by reverting to my original 3146.
</div>
<div>&nbsp;</div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div><span class="sg">&nbsp;</span></div>
<div>&nbsp;</div>
<div>Jeroen.</div></div></blockquote></div><br>

------=_Part_10576_12056519.1194290047178--

