Date: Sat, 4 Oct 2014 13:17:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141004111706.GA7596@sisyphus.hd.free.fr>
References: <20141004125236.655cdb65@warrawoona.sti>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141004125236.655cdb65@warrawoona.sti>
Subject: Re: [Xenomai] Porting ipipe to vendor specific kernel. Newbie
 question.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alexey Shaposhnikov <canisdirusleidy@yandex.ru>
Cc: Xenomai <xenomai@xenomai.org>

On Sat, Oct 04, 2014 at 12:52:36PM +0600, Alexey Shaposhnikov wrote:
>
> I trying to port Xenomai 2.6 on Cubieboard (Allwinner A10 based), but encounter
> following problems:
>
> 1) How to port core patch on newer (than 3.4.6) kernel? Just run
> genpatches.sh give errors "unknown architecture for driver" and
> incomplete patch.

You have to modify genpatches.sh to add the architecture of the
missing files. This may be easier with versions of genpatches.sh for
newer kernel versions (the last I-pipe version supported is 3.14.17).

> 2) Starting (approximately) from version 3.4.29 linux-sunxi kernel
> have code backported from 3.5 (mainstream) kernel
> (arch/arm/include/asm/mmu_context.h for example), so generated for
> 3.4 kernel core patch can't be applied. Is there a (correct) way
> to backport those parts of ipipe patch without direct patch file
> edit and manual copy-paste hunks?

Work with git, but you will still have to back-port changes from
later kernels, and manually.

As a general advice, you may also want to have a look at:
http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/

Note that I believe someone already did the port to allwinner a10, I
made comments on these patches, new versions never were posted.

--
					    Gilles.

