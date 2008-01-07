Message-ID: <b131c9f0801070235yf142e61rbe18eac9fc53ebf6@domain.hid>
Date: Mon, 7 Jan 2008 12:35:55 +0200
From: "vikesh rambaran" <vikesh.rambaran@domain.hid>
In-Reply-To: <200801041626.31245.paul_c@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_31641_3670074.1199702155394"
References: <b131c9f0712300411w46996c98i395344b377c6bacf@domain.hid>
	<200801011948.50010.paul_c@domain.hid>
	<b131c9f0801040439m245da94ci2871faf999a9114@domain.hid>
	<200801041626.31245.paul_c@domain.hid>
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

------=_Part_31641_3670074.1199702155394
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi
Just some feedback.

Compared config files from my old xenomai 2.3.1, new xenomai
2.4.1installation and Paul's
- SMP settings were disabled all but my latest installation

Disabling the SMP option in the kernel configuration restores latencies to
acceptable values.
Any idea why this is so ?

According to the xenomai README.INSTALL the SMP option has a weak binding,
but i tried
compiling xenomai userspace with --enable-smp anyway as a test - did not
help for the
SMP enabled kernel

On Jan 4, 2008 6:26 PM, Paul <paul_c@domain.hid> wrote:

> On Friday 04 January 2008 12:39, vikesh rambaran wrote:
> > Thanx for confirming that. Please let me know when your builds are
> > available,
> > as it helps to have a cross reference to figure out what i'm doing wrong
>
> x86 kernels patched with Xenomai 2.4.1 were uploaded on Wednesday. Will
> probably do a 64bit build over the weekend.
>

Thanx!
There is a xenomai userspace package which goes with the 686  kernel image
Will there be a xenomai package to match the 586 kernel image?
[A separate on is required because of the feature-set differences eg tsc]


>
> Regards, Paul.
>


Keep well
Vicki

------=_Part_31641_3670074.1199702155394
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi<br>Just some feedback.<br><br>Compared config files from my old xenomai 2.3.1, new xenomai 2.4.1 installation and Paul&#39;s<br>- SMP settings were disabled all but my latest installation<br><br>Disabling the SMP option in the kernel configuration restores latencies to acceptable values.
<br>Any idea why this is so ?<br><br>According to the xenomai README.INSTALL the SMP option has a weak binding, but i tried <br>compiling xenomai userspace with --enable-smp anyway as a test - did not help for the <br>SMP enabled kernel
<br><br><div class="gmail_quote">On Jan 4, 2008 6:26 PM, Paul &lt;<a href="mailto:paul_c@domain.hid">paul_c@domain.hid</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Friday 04 January 2008 12:39, vikesh rambaran wrote:<br>&gt; Thanx for confirming that. Please let me know when your builds are<br>&gt; available,<br>&gt; as it helps to have a cross reference to figure out what i&#39;m doing wrong
<br><br></div>x86 kernels patched with Xenomai 2.4.1 were uploaded on Wednesday. Will<br>probably do a 64bit build over the weekend.<br></blockquote><div><br>Thanx! <br>There is a xenomai userspace package which goes with the 686&nbsp;  kernel image
<br>Will there be a xenomai package to match the 586 kernel image? <br>[A separate on is required because of the feature-set differences eg tsc]<br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br><br>Regards, Paul.<br></blockquote></div><br><br>Keep well<br>Vicki<br>

------=_Part_31641_3670074.1199702155394--

