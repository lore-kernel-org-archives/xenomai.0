References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
 <55E5E453.1080400@xenomai.org>
 <CAPuu0=jX6ig5L7SJrmPVOhCmOm=gwxEmTafTpOqzE85hOji8CA@mail.gmail.com>
 <55E5F849.1070708@xenomai.org> <55E5FB89.3080604@xenomai.org>
 <55E60743.30600@xenomai.org>
 <CAJqUr7zP85A6V7n9O=++iC4tJK8LCG5JC8xtO9Xd+u3sQW4G1A@mail.gmail.com>
From: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Message-ID: <5604517A.2000602@mperpetuo.com>
Date: Thu, 24 Sep 2015 12:39:38 -0700
MIME-Version: 1.0
In-Reply-To: <CAJqUr7zP85A6V7n9O=++iC4tJK8LCG5JC8xtO9Xd+u3sQW4G1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I've added some basic FPU support. It does not do lazy switching, since 
this is not supported in the arm64 kernel yet. I've tested it 
successfully with switchtest. Below is a pull request if you guys are 
interested in picking this up.

-Dmitriy

The following changes since commit 17095784c6d3d44dc7f1512ffab9bb957e298466:

   cobalt/arm64: leave mm tracking to the pipeline (2015-09-17 15:08:34 
+0200)

are available in the git repository at:

   http://gitlab.mperpetuo.com/it/xenomai-3.git arm64-fp

for you to fetch changes up to 4825d1c170b773e82f90dd15409dde489447301e:

   cobalt/arm64: add basic FPU support (2015-09-24 12:04:42 -0700)

----------------------------------------------------------------
Dmitriy Cherkasov (1):
       cobalt/arm64: add basic FPU support

  kernel/cobalt/arch/arm64/Kconfig                   |   2 +-
  .../cobalt/arch/arm64/include/asm/xenomai/fptest.h |  10 +-
  .../cobalt/arch/arm64/include/asm/xenomai/thread.h |  17 +-
  .../arch/arm64/include/asm/xenomai/uapi/fptest.h   |  80 +++--
  kernel/cobalt/arch/arm64/thread.c                  | 329 
++++++---------------
  lib/cobalt/arch/arm64/features.c                   |  22 +-
  6 files changed, 146 insertions(+), 314 deletions(-)

