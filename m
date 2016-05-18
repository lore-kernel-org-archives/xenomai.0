Date: Wed, 18 May 2016 23:08:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160518210815.GF13609@hermes.click-hack.org>
References: <2tp93g0j23ghsr5l30as2gwu.1463605197163@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2tp93g0j23ghsr5l30as2gwu.1463605197163@email.android.com>
Subject: Re: [Xenomai] xenomai 3 on the BBB (beaglebone black)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine Rennuit <antoine.rennuit@lesbuilderscompanions.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, May 18, 2016 at 09:00:01PM +0000, Antoine Rennuit wrote:
> 
> 
> 
> Hi all,
> 
> 
> I can find no information on getting xenomai 3 on the BBB, anywhere on the internet. Does it mean it is not possible to install xenomai 3 on the BBB? This is weird, no?

Hi,

we do not provide board-specific installation instructions: the
installation instructions do not depend on the board you use. See
the generic installation instructions here (see, you do not need to
look for them "anywhere on the internet", just on xenomai website):
https://xenomai.org//installing-xenomai-3-x/

The real question being, is the processor used by your board
supported by Xenomai? If you want to use xenomai over preempt_rt,
then the question is whether preempt_rt runs with this processor, we
do not keep track of this on Xenomai website yet, if you want to use
Xenomai over dual kernel, then the question is whether the I-pipe
patch has support for this processor. The answer is here:
https://xenomai.org/embedded-hardware/#Supported_SoC

Regards.

-- 
					    Gilles.
https://click-hack.org

