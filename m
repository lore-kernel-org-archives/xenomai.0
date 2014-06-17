Message-ID: <539FFD87.2030302@xenomai.org>
Date: Tue, 17 Jun 2014 10:34:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <539CCDDC.7000809@konstantin-schauwecker.de>
 <539D96FB.5040300@xenomai.org>
 <647F5D52-A9A5-4B6E-B608-E143A94BFBB0@konstantin-schauwecker.de>
In-Reply-To: <647F5D52-A9A5-4B6E-B608-E143A94BFBB0@konstantin-schauwecker.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Missing patch for Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Konstantin Schauwecker <hi@konstantin-schauwecker.de>, xenomai@xenomai.org

On 06/15/2014 04:31 PM, Konstantin Schauwecker wrote:
> Yes, that is what I was referring to. The mentioned patch 
> ipipe-core-3.8.13-arm-1.patch
> does not exist in the xenomai 2.6.3 release, or in earlier releases. There is a different patch, labelled
> ipipe-core-3.8.13-arm-3.patch
> which does however not match the Xilinx kernel.
> 
> I think its ok now. I manually merged the changes that couldn’t be applied automatically, which was a bit of work. It does compile and I hope that I didn’t make a mistake.

The I-pipe patches you can find in the Adeos project download area or 
in Xenomai sources are patches for the mainline kernel. For people who 
do not work with the mainline kernel, but with vendor forks, these 
patches do not apply. You get conflicts because the I-pipe patch and 
the vendor fork modified the same files.

Releasing an I-pipe patch adapted to each of these vendor forks would 
mean that we would need to regenerate these patches when the I-pipe 
patch evolves, or that the patches for vendor forks would bitrot 
rapidly.

Instead, we use pre and post patches. The -pre patch restores the 
conflicting files to the state of the mainline kernel, so that the 
I-pipe patch applies. The -post patch merges correctly the mainline 
changes with the vendor fork changes, and adds the support specific to 
the vendor fork (in the case of Zynq, that would be the support for the 
Zynq processor).

The advantage of -pre and -post patches is that in theory, we can 
update the I-pipe patch without changing them.

Anyway, the main problem with the installation procedure documented in 
the ksrc/arch/arm/README file is not the patch name, the problem is 
that the commit given in the documentation 
(6a0bedad60e2bca8d9b50bf81b9895e29e31a6d7) is based on a 3.8.0 kernel, 
whereas the I-pipe patch is for Linux 3.8.13. However, the following 
procedure seems to work without conflicts:

git clone git://github.com/Xilinx/linux-xlnx.git
cd linux-xlnx
git checkout 6a0bedad60e2bca8d9b50bf81b9895e29e31a6d7
git remote add stable git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
git fetch stable
git merge v3.8.13 
(accept the merge commit)
patch -p1 < ../xenomai-2.6.3/ksrc/arch/arm/patches/zynq/ipipe-core-3.8-zynq-pre.patch
patch -p1 < ../xenomai-2.6.3/ksrc/arch/arm/patches/ipipe-core-3.8.13-arm-3.patch 
patch -p1 < ../xenomai-2.6.3/ksrc/arch/arm/patches/zynq/ipipe-core-3.8-zynq-post.patch


-- 
                                                                Gilles.

