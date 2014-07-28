Message-ID: <53D66FBE.8090001@xenomai.org>
Date: Mon, 28 Jul 2014 17:43:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b24043adb3d04d7caafb40f3c59e6a85@CVEX13.valentin-carl.de>
In-Reply-To: <b24043adb3d04d7caafb40f3c59e6a85@CVEX13.valentin-carl.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Bug fix suggestion
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Reitinger, Peter" <preitinger@carl-valentin.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/28/2014 02:33 PM, Reitinger, Peter wrote:
> Hi,
> 
> sorry I am ne wand not used tot he protocol of this mailing list. But
> I think in file include/nucleus/seqlock.h (Xenomai Release 2.6.3),
> line 13, SEQCNT must be replaced by the XNSEQCNT which is defined one
> line above. Probably with some configurations it compiles if the an
> old linux/seqlock.h is included before nucleus/seqlock.h which
> defines SEQCNT. But this does not work for linux 3.14.1.

As mentioned in Xenomai 2.6.3 announce it supports Linux up to 3.10.
http://www.xenomai.org/pipermail/xenomai/2013-October/029289.html

If you want to use the I-pipe kernel for Linux 3.14, you have to use
Xenomai 2.6 git, which has a fix for the issue you mention.

http://git.xenomai.org/xenomai-2.6.git/commit/?id=f00d22eca6277e780c19a5d5ecd2ed0e23dabafe

-- 
                                                                Gilles.

