Message-ID: <2ff1a98a0804250912x1dfe8ad2jc860f44059f27b5c@domain.hid>
Date: Fri, 25 Apr 2008 18:12:28 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646F36@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>
	<18448.11276.526008.229326@domain.hid>
	<48103103.7020005@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F23@domain.hid>
	<2ff1a98a0804240730w36d69599q8ed98c1657365cb@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F2A@afsexc01.aurora.aero>
	<18448.49233.523862.911803@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F2F@afsexc01.aurora.aero>
	<18449.4281.679002.804576@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F36@domain.hid>
Subject: Re: [Xenomai-help] Geode Latency Problem (Was: serial port overrun
	problem)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Fri, Apr 25, 2008 at 6:04 PM, Karch, Joshua <jkarch@domain.hid> wrote:
>
>
>
> Gilles, Jan,
>
>  we disabled "System Management Mode" in the Geode GX500 (Versalogic Puma)
> bios which disables USB, all Video, ethernet-- everything.  We enabled the
> Getty serial console and boot from serial in Grub, and booted linux off of
> the serial port which we'd eventually like to use for our sensor
> acquisition.  However, upon running latency -t2, our latencies dropped to 40
> usec max.  Amazing!    We used VGA mode 791 in the kernel options before and
> got a reduction by 400 usec.  The thing is-- we still need ethernet, and we
> need our serial port for our RT work.  Also, in order to get out of System
> Management Mode we have to reset the bios by jumper since there is no serial
> menu.  Any ideas?
>
>  We looked through all of the forums and were not able to find any more
> information as to how to selectively disable the unwanted SMI calls that are
> causing the latency.  We definitely would like basic video, though primarily
> we only need ethernet and serial, and then we can ssh in.

The CS5530 geode companion chip seems to offer function-per-function
SMI control bit.
http://alsa.cybermirror.org/datasheets/nsc/CS5530.pdf

-- 
 Gilles

