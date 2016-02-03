Date: Wed, 3 Feb 2016 16:04:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160203150448.GF32138@hermes.click-hack.org>
References: <20160203145146.GB25464@deathstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160203145146.GB25464@deathstar>
Subject: Re: [Xenomai] RT FEC net driver for IMX6Q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Welling <mwelling@ieee.org>
Cc: xenomai@xenomai.org

On Wed, Feb 03, 2016 at 08:51:46AM -0600, Michael Welling wrote:
> Is there any specific reason why the fec driver is restricted to the PPC
> arcitecture?

In its current state, the driver does not compile for IMX6. A broken
patch has been proposed, my idea is to work on RTnet core before
tackling the drivers, but if a patch fixing the build for imx6 is
proposed, it could be re-enabled.

> 
> The driver appears to have bindings for the IMX ARM controllers.
> 
> Can this driver be used with the IMX6Q processor?
> 
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai

-- 
					    Gilles.
https://click-hack.org

