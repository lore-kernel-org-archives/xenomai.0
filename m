Message-ID: <534B8AA0.50203@xenomai.org>
Date: Mon, 14 Apr 2014 09:13:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKJ14NdsfwK4Vj=UpYb6p9bvFE=1ZoQb6ss--9f-WqXOXGDn2g@mail.gmail.com>
In-Reply-To: <CAKJ14NdsfwK4Vj=UpYb6p9bvFE=1ZoQb6ss--9f-WqXOXGDn2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Command line freeze during xeno-regression-test on
 omap4460
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Glatz <andi.glatz@gmail.com>
Cc: xenomai@xenomai.org

On 01/06/2014 04:30 PM, Andreas Glatz wrote:
> Hi,
> 
> I managed to produce a kernel (v3.8.13) with xenomai 2.6.3 ipipe patch and
> rootfs (debian wheezy) with xenomai 2.6.3 libraries for my Pandaboard ES
> (omap4460). The simple regression test, which only calls dd during the
> switchtest, works fine. However the regression test with the linux test
> project (ltp-full-20130904) scripts causes some sort of system lock up.
> After that I only can ctrl-c xeno-regression-test (i.e. switchtest), which,
> however, doesn't help to regain console access (neigher over ethernet nor
> serial).

Hi,

I finally ran some tests with SD card: I booted my pandaboard using NFS
as usual, but ran the xeno-test script passing the mount point of the SD
card to dohell's -m option. And I could not reproduce any issue. The
kernel I used is 3.14, the configuration is omap2plus_defconfig.

Regards.

-- 
                                                                Gilles.

