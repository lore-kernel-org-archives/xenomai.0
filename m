Date: Wed, 18 Mar 2015 15:21:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150318142119.GF24525@hermes.click-hack.org>
References: <CACreCVLijm5Wup7aTrRTq=SHBmEUQY5D2pYpXThWXSrGqpcuqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACreCVLijm5Wup7aTrRTq=SHBmEUQY5D2pYpXThWXSrGqpcuqw@mail.gmail.com>
Subject: Re: [Xenomai] Boot failure when CONFIG_XENOMAI is enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Mar 18, 2015 at 10:11:06PM +0800, GP Orcullo wrote:
> Hi,
> 
> I'm trying to port xenomai 2.6.4 on an Amlogic S805 board running  a
> 3.10.33 non-mainlined kernel.
> 
> The kernel boots with CONFIG_IPIPE enabled but without CONFIG_XENOMAI.
> Once CONFIG_XENOMAI is set, the boot fails.
> 
> Attached are the .config and the bootlog files. Turning
> CONFIG_SMP_ON_UP off gives a different result.
> 
> Any pointers on where to start looking?

here:
https://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/

Your diagnostic is not consistent with the kernel messages: the only
difference between CONFIG_XENOMAI and !CONFIG_XENOMAI is when
xenomai starts, however your kernel crashes before xenomai starts.

Your problem is probably, as usual, in the timer handling code, or
tsc emulation.

Other than that, I would disable the usually not recommended kernel
options.

-- 
					    Gilles.

