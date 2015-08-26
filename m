Date: Wed, 26 Aug 2015 14:12:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150826121230.GA13935@hermes.click-hack.org>
References: <loom.20150826T125226-959@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20150826T125226-959@post.gmane.org>
Subject: Re: [Xenomai] unable to patch kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fabian <fabian.hartl@avl.com>
Cc: xenomai@xenomai.org

On Wed, Aug 26, 2015 at 11:03:33AM +0000, Fabian wrote:
> Hi,
> 
> I am trying to patch a beaglebone black debian arm kernel with the xenomai 3
> kernel for dual kernel mode (cobalt).
> 
> I used the debian kernel v3.14.39 and the ipipe-core 3.14.39-arm-9.patch,
> because this seems to be the newest matching combination.

The I-pipe patches are meant for mainline Linux kernels, not for
Linux kernel forks. If you want to apply an I-pipe patch to a Linux
kernel fork, you have to:
- fix the obvious merge conflicts;
- inspect the changes made by the fork which could require further
patching, you can use the following document as a checklist:
http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/

If you are interested in using the latest versions, you should have
a look at the I-pipe download area:
http://xenomai.org/downloads/ipipe/v3.x/arm/

-- 
					    Gilles.
https://click-hack.org

