Subject: Re: [Xenomai-core] Use adeos 1.3 or 1.4 for the buildbot?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200609200706.12834.niklaus.giger@domain.hid>
References: <200609200706.12834.niklaus.giger@domain.hid>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 09:43:47 +0200
Message-Id: <1158738227.5544.18.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

On Wed, 2006-09-20 at 07:06 +0200, Niklaus Giger wrote:
> Hi
> 
> Since a few days we have for i386 2.6.17 and powerpc 2.6.14 kernels two 
> versions of the adeos-ipipe patch in the trunk.
> 
> My buildbot scripts assumed that I find just one of the for a given kernel 
> version. Was this a wrong assumption? For the moment I fixed it to use 1.4. 
> Is this okay?
> 
What was the reason to have to versions at the same time in the repo? 
> Shouldn't at least the reason to choose one of them be documented in the 
> README?
> 

Shipping two patches for the same kernel/arch combo can happen,
particularly when the most recent one introduces significant changes.
Adeos patches are being validated as throroughly as possible on
different platforms before they are released, but still, rainy days
happen. So this is basically a safety measure, allowing users to
downgrade easily, in the event of breakage. We could just point them at
the Adeos download area for the same purpose, but it seems simpler to
make a fallback option immediately available at hand within the Xenomai
distro. The older patch normally disappears from the next release.

> Another question. How should buildbot handle the case when it detects a newer 
> version of the patch? Clean the whole build directory? Or does 
> scripts/prepare_kernel.sh handle this case? This question is only relevant 
> for the quick build, as for a full build I always clean the build directory.
> 

It would be nice if buildbot always used the most recent patch, to
participate in further validation. prepare-kernel.sh always suggests the
most recent patch when the kernel tree needs to be patched. But if the
tree has been previously patched, then it skips this step, regardless of
the Adeos version found, so I guess that a full cleanup is being needed.

> Best regards
> 
-- 
Philippe.



