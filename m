Date: Wed, 2 Mar 2011 16:34:11 +0100
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110302153411.GB14557@domain.hid>
References: <20110302151603.GA14557@domain.hid>
	<4D6E61B6.906@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D6E61B6.906@domain.hid>
Subject: Re: [Xenomai-help] Stuck MSI in normal Linux driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Mar 02, 2011 at 04:26:46PM +0100, Gilles Chanteperdrix wrote:
> Richard Cochran wrote:
> > If so, where/how can I start to get working on fixing it?
> > 
> > (I don't need the MSI in a rtdm or adeos context.)
> 
> Given that the problem is that the interrupt controller ack/mask
> functions (if I recall correctly) need, on x86, to use some Linux
> primitives which can not be called from Xenomai domain, I am not sure it
> is easy to fix. And the fact that you do not need the MSI in Xenomai
> domain does not change anything, since ack/mask routines are called
> ahead of the pipeline anyway.

Okay, but how about on PowerPC, can I get to work there?

Thanks,

Richard



