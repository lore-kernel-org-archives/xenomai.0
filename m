Date: Fri, 10 Apr 2015 17:29:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150410152959.GQ20752@hermes.click-hack.org>
References: <5527DF9B.9020304@galauner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5527DF9B.9020304@galauner.de>
Subject: Re: [Xenomai] Xenomai on Linux 3.18 on Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Galauner <andreas@galauner.de>
Cc: xenomai@xenomai.org

On Fri, Apr 10, 2015 at 04:35:07PM +0200, Andreas Galauner wrote:
> Hi all,
> 
> I'm playing around with Xenomai for a few months now on and off and I
> want to get Xenomai running on the Xilinx 3.18 Kernel to use it on a
> Zynq board. I had it running with 3.14, but I need the Xilinx Video
> Pipeline drivers which only work for me on 3.18.
> 
> Now I've been keeping an eye on the i-pipe 3.18 branch for a while and
> I've been trying to run it on my board, but I keep having massive
> problems during bootup when Xenomai is enabled.
> 
> Most of the time it just freezes at some point in time during bootup.
> Sometimes it boots completely and then freezes afterwards.
> 
> The funniest thing we saw was, that it booted completely, we quickly
> logged in, ran xeno-test which seemed to work fine until Linux processes
> seem to be hanging randomly, but then it recovered after a few seconds,
> ran for a few seconds, hang again etc.
> 
> I tried all kinds of things to find out where this hanging comes
> from.

Maybe you already tried since you tried "all kinds of things", but
better be sure, have you tried enabling Xenomai and I-pipe debugging
options? 

-- 
					    Gilles.

