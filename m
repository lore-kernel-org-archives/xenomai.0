From: Paul <paul_c@tuxcnc.org>
Date: Sun, 29 Jul 2012 10:44:22 +0100
References: <500FEB0F.9000308@xenomai.org>
	<201207282127.33575.paul_c@tuxcnc.org>
	<50144E93.5050109@xenomai.org>
In-Reply-To: <50144E93.5050109@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201207291044.22418.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] Heads up: I-pipe patch status on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Saturday 28 July 2012, Gilles Chanteperdrix wrote:
> It does not look that bad. However, "dohell 3600" does not do much.
> If you want to improve the latencies, use "-p 100" instead of "-p
> 1000" ;-)

Could try running a 'make j8 Image' in the kernel source tree. That 
would give the system a good run for my money.. However, dohell gives a 
baseline load that others could repeat (my excuse, and I'm sticking to 
it ;-p )

> How do you get the fancy grid with gnuplot? We could add the option
> to scripts/histo.gp. Note that I prefer to draw graphs with a log
> scale, I find they are more meaningful, otherwise, you do not really
> see how the graph ends.

gnuplot> set grid

The next set of plots, I'll use a log scale as you suggest.


Regards, Paul.

