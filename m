Message-ID: <2ff1a98a0804240730w36d69599q8ed98c1657365cb@domain.hid>
Date: Thu, 24 Apr 2008 16:30:12 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646F23@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>
	<2ff1a98a0804230730t44382de9i813b23d235ece2e3@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F19@domain.hid>
	<18447.31623.723753.421351@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F1D@afsexc01.aurora.aero>
	<18447.43488.713144.166771@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F21@domain.hid>
	<18448.11276.526008.229326@domain.hid>
	<48103103.7020005@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F23@domain.hid>
Subject: Re: [Xenomai-help] serial port overrun problem RT TASK
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

On Thu, Apr 24, 2008 at 4:16 PM, Karch, Joshua <jkarch@domain.hid> wrote:
>  RTD|     -56.153|     -38.553|    1951.085|    2319|     -62.020|
> 2055.847
>
>  Any ideas?

You definitely have a hardware issue. Geode are known for at least two things:
- they may stop their tsc when idle, this is bad since Xenomai relies
on a continuously ticking tsc, AFAIK, this can be worked around by
passing the idle=poll parameter on the kernel command line;
- they may use SMI, fortunately SMIs may be disabled with a few outbs,
as explained in this
https://mail.rtai.org/pipermail/rtai/2005-July/012474.html

ISTR that there are issues with graphic mode, and the workaround may
be to switch to framebuffer mode, but I am not sure.

Look for geode in RTAI mailing list archives to find additional informations.
When this is done, it would be nice if you could create a page about
Geode on Xenomai wiki summarizing your findings.

-- 
 Gilles

