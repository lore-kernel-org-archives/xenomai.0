Date: Mon, 2 Nov 2015 17:27:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151102162755.GA32103@hermes.click-hack.org>
References: <BLU436-SMTP235B354929DDB6910D2667EF02D0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLU436-SMTP235B354929DDB6910D2667EF02D0@phx.gbl>
Subject: Re: [Xenomai] Support for Raspberry PI 2 B
 (devm_request_threaded_irq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Cc: xenomai@xenomai.org

On Sat, Oct 31, 2015 at 08:58:27PM -0700, Mathieu Rondonneau wrote:
> Hi,
> 
> irq handlers registered with devm_request_threaded_irq does not get 
> triggered when interrupt fires.
> 
> The mmc driver uses this (can not load the rootfs).
> Only the IPIPE patch is enabled.
> the armctrl chipirq is triggering the .ack handler instead so the 
> interrupt is happening.
> 
> Any suggestion on where I should look? how is this supported by the 
> ipipe layer?

Maybe have a look here:
http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/

-- 
					    Gilles.
https://click-hack.org

