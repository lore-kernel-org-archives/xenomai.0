Date: Wed, 12 Aug 2015 17:27:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150812152757.GA27862@hermes.click-hack.org>
References: <OF3EB5637C.BE58E83A-ONC1257E9F.0042D131-C1257E9F.0042E65D@marposs.com>
 <20150812122152.GC21595@hermes.click-hack.org>
 <20150812123920.GD21595@hermes.click-hack.org>
 <OF4F6B2713.B0429143-ONC1257E9F.004ABEC3-C1257E9F.004AC655@marposs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF4F6B2713.B0429143-ONC1257E9F.004ABEC3-C1257E9F.004AC655@marposs.com>
Subject: Re: [Xenomai] rt_task_sleep returns -38
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Cristiano.Mantovani@marposs.com
Cc: xenomai@xenomai.org

On Wed, Aug 12, 2015 at 03:36:43PM +0200, Cristiano.Mantovani@marposs.com wrote:
> Thank you very much for your reply!
> 
> I have never used the mainline kernel on i.mx6q, only freescale kernels.
> I have just compiled and I'm testing this new version for me.
> 
> Can I use the ipipe-core-3.10.32-arm-5 provided in Xenomai 2.6.4?
> Is possible it works with kernel 3.10.17?

I am surprised that nobody at marposs.com knows the answer to this
question, given how long we had users from this company subscribed
to this mailing list and how often this question is answered. A
version of Xenomai supports I-pipe patches from any kernel versions
smaller than the latest version it supports. For instance, the
latest version supported by Xenomai 2.6.4 is 3.14 (we do not care
about the third number, it is just a stable release from the 3.14
branch), so Xenomai 2.6.4 supports I-pipe patch for any version of
Linux smaller than 3.14.

-- 
					    Gilles.
https://click-hack.org

