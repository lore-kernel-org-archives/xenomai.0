Message-ID: <45FFBD3E.5010405@domain.hid>
Date: Tue, 20 Mar 2007 11:53:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai v2.3.1
References: <1174379951.5068.5.camel@domain.hid>
In-Reply-To: <1174379951.5068.5.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
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
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Philippe Gerum wrote:
> Here is the first maintenance release for the v2.3.x branch.  Short
> log follows:
> 	[arm]
> 	* Add support for Atmel AT91-based platforms.
> 	* Update support for IMX21 platforms.
> 	* Upgrade 2.6.14 and 2.6.15 support to I-pipe 1.5 series.
> 	* Upgrade to kernel 2.6.19 (I-pipe 1.6 series).
> 	* Add support for GCC 4.1.

An additional item on ARM: the lockup which occured when setting a too
low period in the latency test is fixed. For this, we owe a big thanks
to Steven Scholz.

-- 
                                                 Gilles Chanteperdrix

