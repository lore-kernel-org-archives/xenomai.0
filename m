Message-ID: <b131c9f0801040439m245da94ci2871faf999a9114@domain.hid>
Date: Fri, 4 Jan 2008 14:39:58 +0200
From: "vikesh rambaran" <vikesh.rambaran@domain.hid>
In-Reply-To: <200801011948.50010.paul_c@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_26410_14182249.1199450398737"
References: <b131c9f0712300411w46996c98i395344b377c6bacf@domain.hid>
	<200712311654.51903.paul_c@domain.hid>
	<b131c9f0801010817l2f36aea3h7d521d7be8b7255@domain.hid>
	<200801011948.50010.paul_c@domain.hid>
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

------=_Part_26410_14182249.1199450398737
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi

Sorry for taking a long time to reply. (Had to do some windpump maintenance
on a farm !)

On Jan 1, 2008 9:48 PM, Paul <paul_c@domain.hid> wrote:

> On Tuesday 01 January 2008 16:17, vikesh rambaran wrote:
> > The kernel .config file for the "Linux 2.6.23 image on
> > 586/K5/5x86/6x86/6x86MX (patched with Xenomai)"
> > package has the following set
> >
> > CONFIG_X86_GOOD_APIC=y
> > # CONFIG_X86_UP_APIC is not set
> > # CONFIG_M586TSC is not set
> > CONFIG_X86_TSC=y
> > # CONFIG_M586 is not set
> > CONFIG_M686=y
> >
> > This does not seem to correspond to your comment above. Is there
> something
> > i've missed ?
>
> /me curses.. Some of the basic 586 options appear to have been overrriden
> by
> options for the 686 flavour. With the release of Xenomai-2.4.1 anounced,
> I'll
> rebuild everything overnight and try to resolve the APIC/TSC issue.
>
>
> Regards, Paul.
>


Thanx for confirming that. Please let me know when your builds are
available,
as it helps to have a cross reference to figure out what i'm doing wrong

In the mean time, i will also do a build with 2.4.1 to see if it helps any

Keep well
Vicki

------=_Part_26410_14182249.1199450398737
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi<br><br>Sorry for taking a long time to reply. (Had to do some windpump maintenance on a farm !)<br><br><div class="gmail_quote">On Jan 1, 2008 9:48 PM, Paul &lt;<a href="mailto:paul_c@domain.hid">paul_c@domain.hid</a>&gt; wrote:
<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">On Tuesday 01 January 2008 16:17, vikesh rambaran wrote:<br>&gt; The kernel .config file for the &quot;Linux 
2.6.23 image on<br>&gt; 586/K5/5x86/6x86/6x86MX (patched with Xenomai)&quot;<br>&gt; package has the following set<br>&gt;<br>&gt; CONFIG_X86_GOOD_APIC=y<br>&gt; # CONFIG_X86_UP_APIC is not set<br>&gt; # CONFIG_M586TSC is not set
<br>&gt; CONFIG_X86_TSC=y<br>&gt; # CONFIG_M586 is not set<br>&gt; CONFIG_M686=y<br>&gt;<br>&gt; This does not seem to correspond to your comment above. Is there something<br>&gt; i&#39;ve missed ?<br><br></div>/me curses.. Some of the basic 586 options appear to have been overrriden by
<br>options for the 686 flavour. With the release of Xenomai-2.4.1 anounced, I&#39;ll<br>rebuild everything overnight and try to resolve the APIC/TSC issue.<br><br><br>Regards, Paul.<br></blockquote></div><br><br>Thanx for confirming that. Please let me know when your builds are available, 
<br>as it helps to have a cross reference to figure out what i&#39;m doing wrong<br><br>In the mean time, i will also do a build with 2.4.1 to see if it helps any<br><br>Keep well<br>Vicki<br><br>

------=_Part_26410_14182249.1199450398737--

