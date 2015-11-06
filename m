Date: Fri, 6 Nov 2015 11:57:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151106105717.GC1794@hermes.click-hack.org>
References: <OF6134003B.3BB84DA5-ONC1257EF4.002BF1E4-C1257EF4.002EC9DB@zodiacaerospace.com>
 <20151105204655.GA31487@hermes.click-hack.org>
 <OFBFA9BE57.158A3D72-ONC1257EF5.003A424B-C1257EF5.003B7241@zodiacaerospace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFBFA9BE57.158A3D72-ONC1257EF5.003A424B-C1257EF5.003B7241@zodiacaerospace.com>
Subject: Re: [Xenomai] Xenomai on Linux 3.18 on Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe.Corbel@zodiacaerospace.com
Cc: xenomai@xenomai.org

On Fri, Nov 06, 2015 at 11:49:18AM +0100, Philippe.Corbel@zodiacaerospace.com wrote:
> Sorry for the break in thread continuity but as I said I just subscribed 
> to the mailing list and use the archive to find the needed informations... 
> I tried to quote the last message to restart the discussion.
> 
> By the way, I merged the 3.0.1 release in my source tree and generated a 
> new kernel as you requested but I observed the same behaviour with the 3 
> freezes during the boot and random freezes in use...
> 
> For additional information, here are the messages from kernel boot (DEBUG 
> is still enabled for both I-Pipe and Cobalt Core and no related message):
> 
> Booting Linux on physical CPU 0x0
> Linux version 3.18.20-hg38f03e835e7e (corbel@andromeda)

Ok, another valuable test would be to run an unmodified 3.18.20
kernel. Because if you run a modified version, maybe some
modifications need to be modified to interact correctly with the
I-pipe.

> (gcc version 4.8.3 20140131 (prerelease)

Looks like a dangerous version. Only versions 4.8 to 4.8.2 have been
blacklisted, but some versions of 4.8.3 may be problematic. Any
chance to upgrade your toolchain ?

-- 
					    Gilles.
https://click-hack.org

