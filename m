Message-ID: <50FEEA8F.4060509@xenomai.org>
Date: Tue, 22 Jan 2013 20:37:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1358809464.75419.YahooMailNeo@web140601.mail.bf1.yahoo.com>
	<1358883137.7479.YahooMailNeo@web140606.mail.bf1.yahoo.com>
In-Reply-To: <1358883137.7479.YahooMailNeo@web140606.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] x86 Linux with xenomai and i915 graphics stall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: A User <t02446@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/22/2013 08:32 PM, A User wrote:

> When we run latency, we still get about 10 usec on a quiet system.
> When we run glxgears and make the window size  600x600 pixels, and we
> use the mouse to drag the glxgears window quickly around on the
> desktop, the max latency goes to about 250 usec (with gnome-3
> fallback and compiz).


That is unusual, a typical latency on x86 is under 50us (and this is a
conservative bound). In order to investigate this, enable the I-pipe
tracer in the kernel configuration and run latency -f. Also set the
number of backtrace points to a large value, say 1000 or 10000 and post
the trace here.

> The option CONFIG_PCI_MSI should be disabled
> 
> """
> 
> 
> We will keep CONFIG_PCI_MSI turned on for now, as Gilles suggests.


The danger with CONFIG_PCI_MSI is that you can not mask/disable the
interrupt in a real-time interrupt handler, but as long as you do not do
that, you should be safe.

-- 
                                                                Gilles.

