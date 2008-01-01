From: Paul <paul_c@domain.hid>
Date: Tue, 1 Jan 2008 19:48:49 +0000
References: <b131c9f0712300411w46996c98i395344b377c6bacf@domain.hid>
	<200712311654.51903.paul_c@domain.hid>
	<b131c9f0801010817l2f36aea3h7d521d7be8b7255@domain.hid>
In-Reply-To: <b131c9f0801010817l2f36aea3h7d521d7be8b7255@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200801011948.50010.paul_c@domain.hid>
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
To: vikesh rambaran <vikesh.rambaran@domain.hid>
Cc: xenomai@xenomai.org

On Tuesday 01 January 2008 16:17, vikesh rambaran wrote:
> The kernel .config file for the "Linux 2.6.23 image on
> 586/K5/5x86/6x86/6x86MX (patched with Xenomai)"
> package has the following set
>
> CONFIG_X86_GOOD_APIC=y
> # CONFIG_X86_UP_APIC is not set
> # CONFIG_M586TSC is not set
> CONFIG_X86_TSC=y
> # CONFIG_M586 is not set
> CONFIG_M686=y
>
> This does not seem to correspond to your comment above. Is there something
> i've missed ?

/me curses.. Some of the basic 586 options appear to have been overrriden by 
options for the 686 flavour. With the release of Xenomai-2.4.1 anounced, I'll 
rebuild everything overnight and try to resolve the APIC/TSC issue.


Regards, Paul.

