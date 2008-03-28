Message-ID: <2ff1a98a0803280818l658f4086ha9fa967cea82cfca@domain.hid>
Date: Fri, 28 Mar 2008 16:18:02 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2ff1a98a0803280811n702cf80ble01c121959bbcf21@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47ECBCAA.50701@domain.hid>
	<2ff1a98a0803280811n702cf80ble01c121959bbcf21@domain.hid>
Subject: Re: [Xenomai-core] Porting Ipipe/Adeos patch to new arm9 board
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Neil Armstrong <narmstrong@domain.hid>
Cc: xenomai@xenomai.org

On Fri, Mar 28, 2008 at 4:11 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Fri, Mar 28, 2008 at 10:38 AM, Neil Armstrong <narmstrong@domain.hid> wrote:
>  > Hi,
>  >
>  >  I need to port the actual ipipe 2.6.24 patch for a new arm926ej-s based
>  >  board for my company.
>  >  I followed the wiki's howto and helped myself with the integrator and
>  >  the s3c24xx patches.
>  >  The Soc has 3 decrementers, the arm core is running at 144MHz and the
>  >  timers has a 256 ticks prescaler (we need 563 ticks to get 1ms).

I am not sure it makes sense to set the timer auto-reload mode when
the timer is used in one-shot mode: imagine that the timer is
programmed in one-shot mode, it will tick several time before the
interrupt handler is called.

-- 
 Gilles

