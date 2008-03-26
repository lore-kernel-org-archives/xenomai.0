Message-ID: <2ff1a98a0803260755x214d6ea6p5e9ee3fbeaba654c@domain.hid>
Date: Wed, 26 Mar 2008 15:55:24 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47EA1FC80200000100192EEC@nwque-vm-gwia.criq.qc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47EA1FC80200000100192EEC@nwque-vm-gwia.criq.qc.ca>
Subject: Re: [Xenomai-help] SMI workaround failed!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hubert Talbot <Hubert.Talbot@domain.hid>
Cc: xenomai@xenomai.org

On Wed, Mar 26, 2008 at 3:04 PM, Hubert Talbot <Hubert.Talbot@domain.hid> wrote:
> Hi,
>
>  Is a machine where "SMI workaround failed!" reliable for realtime tasks?

It depends whether you have some SMI issues on this machine. "SMI
workaround failed" means that the BIOS forbids disabling SMIs. To know
if you have some SMI issues on a machine, run the latency test, and
look for high figures. On a recent machine, something above, say, 40us
is probably abnormal.

-- 
 Gilles

