Message-ID: <b131c9f0801070330p7cea020au35fca61cbd40cae@domain.hid>
Date: Mon, 7 Jan 2008 13:30:36 +0200
From: "vikesh rambaran" <vikesh.rambaran@domain.hid>
In-Reply-To: <b131c9f0801070235yf142e61rbe18eac9fc53ebf6@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_31810_15334136.1199705436274"
References: <b131c9f0712300411w46996c98i395344b377c6bacf@domain.hid>
	<200801011948.50010.paul_c@domain.hid>
	<b131c9f0801040439m245da94ci2871faf999a9114@domain.hid>
	<200801041626.31245.paul_c@domain.hid>
	<b131c9f0801070235yf142e61rbe18eac9fc53ebf6@domain.hid>
Subject: Re: [Xenomai-help] Large (negative) latency test results and fast
	PC clock
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_31810_15334136.1199705436274
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Correction :

On Jan 7, 2008 12:35 PM, vikesh rambaran <vikesh.rambaran@domain.hid> wrote:

> Hi
> Just some feedback.
>
> Compared config files from my old xenomai 2.3.1, new xenomai 2.4.1installation and Paul's
> - SMP settings were disabled all but my latest installation
>
> Disabling the SMP option in the kernel configuration restores latencies to
> acceptable values.
> Any idea why this is so ?
>

Disabling SMP AND enabling APIC gives acceptable latencies. Without the
APIC, latencies are in the
order of a few milliseconds (< 100ms)

Thanx
Vicki

------=_Part_31810_15334136.1199705436274
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Correction :<br><br><div class="gmail_quote">On Jan 7, 2008 12:35 PM, vikesh rambaran &lt;<a href="mailto:vikesh.rambaran@domain.hid">vikesh.rambaran@domain.hid</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi<br>Just some feedback.<br><br>Compared config files from my old xenomai 2.3.1, new xenomai 2.4.1 installation and Paul&#39;s<br>- SMP settings were disabled all but my latest installation<br><br>Disabling the SMP option in the kernel configuration restores latencies to acceptable values.
<br>Any idea why this is so ?<br></blockquote><div><br>Disabling SMP AND enabling APIC gives acceptable latencies. Without the APIC, latencies are in the <br>order of a few milliseconds (&lt; 100ms)<br><br></div></div>Thanx
<br>Vicki<br>

------=_Part_31810_15334136.1199705436274--

