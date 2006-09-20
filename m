From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Wed, 20 Sep 2006 07:06:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609200706.12834.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Use adeos 1.3 or 1.4 for the buildbot?
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi

Since a few days we have for i386 2.6.17 and powerpc 2.6.14 kernels two 
versions of the adeos-ipipe patch in the trunk.

My buildbot scripts assumed that I find just one of the for a given kernel 
version. Was this a wrong assumption? For the moment I fixed it to use 1.4. 
Is this okay?

What was the reason to have to versions at the same time in the repo? 
Shouldn't at least the reason to choose one of them be documented in the 
README?

Another question. How should buildbot handle the case when it detects a newer 
version of the patch? Clean the whole build directory? Or does 
scripts/prepare_kernel.sh handle this case? This question is only relevant 
for the quick build, as for a full build I always clean the build directory.

Best regards

-- 
Niklaus Giger

