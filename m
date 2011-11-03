Date: Thu, 3 Nov 2011 15:00:29 -0400
Message-ID: <20111103190029.GE30117@domain.hid>
References: <20111102201210.GY30117@domain.hid>
	<4EB1B691.9020801@domain.hid>
	<20111103151353.GB30117@domain.hid>
	<4EB2B58F.3070600@domain.hid>
	<20111103161844.GC30117@domain.hid>
	<20111103170042.GD30117@domain.hid>
	<4EB2CB84.3060004@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EB2CB84.3060004@domain.hid>
From: lsorense@domain.hid (Lennart Sorensen)
Subject: Re: [Adeos-main] irq related kernel crash with adeos 3.0.4 powerpc.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

On Thu, Nov 03, 2011 at 06:12:36PM +0100, Philippe Gerum wrote:
> Ok, does this also happen when CONFIG_IPIPE is off?

Well ucc-geth actually does work on some ports.  It only fails on the
ones using our own bitbanged smi interface, so I think its my problem.
The ports using the 8360's real smi port work fine.

So I am quite sure this is not an ipipe problem at all.

I probably just missed something when porting that small driver to 3.0.
We just have it so that xenomai can own the real smi port and linux can
use the bitbanged interface so that the real time code can own a few
ucc's and linux can own a couple and each can manage their own PHYs.

-- 
Len Sorensen

