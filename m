Message-ID: <4FB57899.7080704@domain.hid>
Date: Fri, 18 May 2012 00:15:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E2AB2206BF591546A1931EA4E7A9FBC841502023@domain.hid>
In-Reply-To: <E2AB2206BF591546A1931EA4E7A9FBC841502023@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai Periodic Latency Spikes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Wolz, Troy" <Troy.Wolz@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/17/2012 09:12 PM, Wolz, Troy wrote:
> Hello,
> 
> When running the latency program provided in the Xenomai source, my
> latency numbers for 'max latency' is consistently over 30 us. I have
> installed Xenomai 2.6.0 using Linux kernel 2.6.38.8. I have attached
> my config for my linux kernel. SMI is disabled, legacy USB support is
> disabled in the BIOS, and the other obvious latency killers provided
> in the troubleshooting guide have been checked.

Oly CONFIG_ACPI_PROCESSOR should be turned off. It is recommended to
keep CONFIG_ACPI on.

CONFIG_XENO_OPT_DEBUG_XNLOCK has some impact on latencies, if you want
to reduce latencies, you should turn it off.

-- 
                                                                Gilles.

