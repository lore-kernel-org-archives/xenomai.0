Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Kernel-OOps
Date: Tue, 27 Feb 2007 14:51:34 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01B53705@domain.hid>
In-Reply-To: <1172587094.27967.10.camel@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB01B5368C@is-hdq-exchange.marel.net>
	<DD39B5C3F4963040ADC9768BE7E430CB01B536B3@domain.hid>
	<1172587094.27967.10.camel@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
>
> Some usage patterns involving permanent mode switches inside a large
> set of real-time threads that only rarely relinquish the CPU to other
> regular Linux tasks may cause this. This is specific to 2.4 kernels.
> I will raise this value in the next patch update. Thanks,  =20

I think simply increasing this value to some other magic number could
not be enough until somebody stumbles again upon this limit. How about
implementing a kernel configuration option with a default value
(although it is only 2.4 specific) ? This is probably a ipipe patch
specific option ?


Best regards,

Daniel Schnell.

