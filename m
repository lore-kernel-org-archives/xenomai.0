From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 7 Nov 2012 17:40:01 -0500
Message-ID: <20121107224001.GB14555@csclub.uwaterloo.ca>
References: <9A40FDD0-65C2-470A-ACB7-AB556CF62501@mah.priv.at>
	<509AB38E.1060802@grandegger.com>
	<39DEC9F1-236E-481A-A685-E3EFE883BCFA@mah.priv.at>
	<509ABA2F.3070507@xenomai.org>
	<79291449-2780-432F-AD58-BED661299EC6@mah.priv.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79291449-2780-432F-AD58-BED661299EC6@mah.priv.at>
Subject: Re: [Xenomai] RTDM API: no CPU binding,
 FPU setting for tasks available?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On Wed, Nov 07, 2012 at 09:17:14PM +0100, Michael Haberler wrote:
> that I wasnt aware of, and it is quite a showstopper for me - I wish I had known before and saved the time. It puts in question any plans to release the kernel mode port of LinuxCNC altogether.
> 
> You _do_ want to add that fact to the Xenomai Roadmap _badly_.
> 
> what would be a realistic 'useful remaing life expectancy' for Xenomai 2.x? 1,2,3 years? 

Well Linux has always been highly anti FPU in kernel mode, and Xenomai
3 seems to drop the idea of doing anything in kernel mode if possible,
so since all your real time code should be in user space anyhow, there
should not be any FPU issues.

There have also been interesting bugs to do with FPU in xenomai 2.x
under certain corner cases that have been entertaining to track down,
although I don't remember if any had to do with user space versus kernel
space or not.

-- 
Len Sorensen

