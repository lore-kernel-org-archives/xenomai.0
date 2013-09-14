Message-ID: <52347663.90705@xenomai.org>
Date: Sat, 14 Sep 2013 16:44:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEk6gTAZDO7=gKRtBCaSRDMoEAD5ad6_Q7XFx3XoFY0q2OvFhg@mail.gmail.com>
In-Reply-To: <CAEk6gTAZDO7=gKRtBCaSRDMoEAD5ad6_Q7XFx3XoFY0q2OvFhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ARM patch for 3.10 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Drasko DRASKOVIC <drasko.draskovic@gmail.com>
Cc: xenomai@xenomai.org

On 09/14/2013 04:40 PM, Drasko DRASKOVIC wrote:
> Hi all,
> I can see that Adeos ARM patch is latest for 3.8 kernel
> (http://download.gna.org/adeos/patches/v3.x/arm/), and in xenomai-head
> I can find 3.8.13 kernel patch.
> 
> I am wondering how difficult is it to create the patch for 3.10
> kernel, and when is this expected to happen - if there are some
> initiatives.
> 
> Actually, according to this :
> http://www.linuxfoundation.org/news-media/blogs/browse/2013/09/quick-guide-get-ready-ltsi-310,
> 3.10 will be new LTSI kernel released early November, and probably
> find it's way to a lot of CE devices.
> 
> I think that there is a great interest fro Xenomai project to have
> prepared patch for this kernel version.

The I-pipe patch for Linux 3.10 for the ARM and x86 architectures is
already running but not finalized. However, Xenomai 2.6.3 will be
released without this patch, but is "3.10 ready" so that we will not
need another Xenomai release when the patch for 3.10 is finalized.

-- 
                                                                Gilles.

