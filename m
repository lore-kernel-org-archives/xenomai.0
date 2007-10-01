Message-ID: <2ff1a98a0710010525kc7b368ex735a34ee76fcd93f@domain.hid>
Date: Mon, 1 Oct 2007 14:25:13 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200710011212.l91CCO7w006791@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0710010238v47eb1778tfc6779285116c64b@domain.hid>
	<200710011212.l91CCO7w006791@domain.hid>
Subject: Re: [Xenomai-core] ARM compiling error
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On 10/1/07, Patrick <kpa_info@domain.hid> wrote:
>
>
>
>
> Hy,
>
>
>
> I install Xenomai 2.3.4 for ARM on 2.6.20 kernel. The prepare-kernel script
> work well.

Which ARM machine ?
Which version of the ARM patch ?
>From your compilation log, I would say that you are using an I-pipe
patch which is older than Xenomai v2.3.4, so the general advice is to
use the I-pipe patch which comes with the version of Xenomai you use.

-- 
                                               Gilles Chanteperdrix

