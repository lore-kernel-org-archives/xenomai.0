From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 11 Dec 2013 09:51:36 -0500
Message-ID: <20131211145136.GL20884@csclub.uwaterloo.ca>
References: <529F1913.4030604@xenomai.org> <529F1974.60900@xenomai.org>
 <529F2BED.2030403@xenomai.org> <529F5254.8060501@xenomai.org>
 <529F69AD.6060003@xenomai.org>
 <CE87D5F4-FE47-4310-A74F-7F8E4CCEC92B@open.ac.uk>
 <52A05ED2.9050003@xenomai.org>
 <E8F821A2-2BD0-440D-BDA1-3751BD443662@open.ac.uk>
 <52A5E155.2040303@xenomai.org>
 <4453D563-1D0B-4C5E-BCF1-3E2E8068B514@open.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4453D563-1D0B-4C5E-BCF1-3E2E8068B514@open.ac.uk>
Subject: Re: [Xenomai] latency spikes under load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kurijn Buys <Kurijn.Buys@open.ac.uk>
Cc: Xenomai@xenomai.org

On Wed, Dec 11, 2013 at 02:23:38PM +0000, Kurijn Buys wrote:
> I enabled APIC, and the latency peaks at 16us only now, and even less with load.
> This also had an effect on my analogy problem, but not completely... I will start a new thread for that...

If your latency drops under loads, it sounds as if your CPU is slowing
down when idle and taking a while to speed back up.  Perhaps changing
the CPU governer to performance or user controlled and setting a fixed
CPU speed would keep the latency low all the time (although at the cost
of more power consumption).

-- 
Len Sorensen

