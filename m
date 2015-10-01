References: <55E5FB89.3080604@xenomai.org> <55E60743.30600@xenomai.org>
 <CAJqUr7zP85A6V7n9O=++iC4tJK8LCG5JC8xtO9Xd+u3sQW4G1A@mail.gmail.com>
 <5604517A.2000602@mperpetuo.com>
 <20150925150248.GE1332@hermes.click-hack.org>
 <560580E6.6070208@mperpetuo.com>
 <20150925180137.GF1332@hermes.click-hack.org>
 <20150926112419.GH1332@hermes.click-hack.org>
 <CAPuu0=hEDw3g4pkJfWsAy-LkgwL=SrGyb1xPuU7a3-5LKYuHZg@mail.gmail.com>
 <20150929141439.GS15616@csclub.uwaterloo.ca>
 <20150929204945.GD18188@hermes.click-hack.org>
From: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Message-ID: <560DC717.9050902@mperpetuo.com>
Date: Thu, 1 Oct 2015 16:51:51 -0700
MIME-Version: 1.0
In-Reply-To: <20150929204945.GD18188@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

The following changes since commit 17095784c6d3d44dc7f1512ffab9bb957e298466:

   cobalt/arm64: leave mm tracking to the pipeline (2015-09-17 15:08:34 
+0200)

are available in the git repository at:

   http://gitlab.mperpetuo.com/it/xenomai-3.git arm64-fp

for you to fetch changes up to ef3ddd26d4ceb2ceec22e0df996e1215ea9935d5:

   cobalt/arm64: add lazy FPU switching (2015-10-01 16:42:56 -0700)

----------------------------------------------------------------
Dmitriy Cherkasov (3):
       cobalt/arm64: add basic FPU support
       cobalt/arm64: fix fpu exception names
       cobalt/arm64: add lazy FPU switching

  kernel/cobalt/arch/arm64/Kconfig                           |   2 +-
  kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h      |  11 ++-----
  kernel/cobalt/arch/arm64/include/asm/xenomai/thread.h      |  17 
+++--------
  kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/fptest.h |  83 
+++++++++++++++++++++++++++++++++++----------------
  kernel/cobalt/arch/arm64/machine.c                         |   4 +--
  kernel/cobalt/arch/arm64/thread.c                          | 344 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------------------------------------------------------------------------------------------
  lib/cobalt/arch/arm64/features.c                           |   4 +--
  7 files changed, 183 insertions(+), 282 deletions(-)


