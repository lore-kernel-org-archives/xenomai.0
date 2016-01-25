Date: Mon, 25 Jan 2016 09:28:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160125082808.GD1814@hermes.click-hack.org>
References: <CACBbF4Xxk9YNn3rbyZArwj5Fmf0sRPT=SMGKWne_qh0GHuzAmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACBbF4Xxk9YNn3rbyZArwj5Fmf0sRPT=SMGKWne_qh0GHuzAmg@mail.gmail.com>
Subject: Re: [Xenomai] [PATCH] kernel/drivers/net/drivers/fec: fix
 compile-time errors
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "LOYAU, Florian" <florian.loyau@edu.esiee.fr>
Cc: xenomai@xenomai.org

On Mon, Jan 25, 2016 at 08:50:39AM +0100, LOYAU, Florian wrote:
> As requested by Gilles, here's a patch fixing minor build issues with the
> FEC RTnet driver for i.MX platforms. This doesn't alter Kconfig, so doesn't
> reenable building it, since I believe you guys will want to make sure
> everything works right before then.

Your MUA broke the patch, and the patch adds dead code. Also, for
what version of Linux did you modify the driver? 3.10, 3.14, 3.18 or
4.1? All versions?


> 
> Be aware that as i mentionned in the earlier mail, it doesn't seem to fully
> work, as the device rx rtskb pool seems to run out after some time. However
> we observed the same issues with different drivers, and they might just
> have been fixed since then.

Well, no. loopback has been fixed in the current stable and next
branches of xenomai 3 repository, but no other driver needed fixing
as far as I can tell. Also, a testsuite for RTnet UDP, raw packet
and "cooked" packet was added recently, you can use it to check if
all the drivers you need are working. To use it you will need to
enable rtcfg, run the program named "smokey_net_server" on one
machine, and smokey on the tested machine, for instance using the
UDP test. Use the rtnet_driver, rtnet_interface, rtnet_rate
and rtnet_duration parameters to specify the test parameters.

-- 
					    Gilles.
https://click-hack.org

