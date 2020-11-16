From: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Subject: [PATCH v2 0/3] Make offered kernel features accessible during
Date: Mon, 16 Nov 2020 14:07:10 +0000
Message-ID: <20201116140641.72027-1-florian.bezdeka@siemens.com>
References: <157dbba3-5d17-7f84-6319-9ea9eae35854@tj.kylinos.cn>+EDAFE494B95437A7>
In-Reply-To: <157dbba3-5d17-7f84-6319-9ea9eae35854@tj.kylinos.cn>+EDAFE494B95437A7>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, song <chensong@tj.kylinos.cn>

From: Florian Bezdeka <florian.bezdeka@siemens.com>

Hi all,                                                                    =
        =20
                                                                           =
        =20
while reviewing the settime64 syscall patches I noticed that we do not
have any infrastructure that allows us to check which features are
offered by the currently running kernel.
                                                                           =
        =20
With this patch series I try to fix this gap. Everything is compile
time tested only so far. I'm currently trying to bring my test
infrastructure up and running.

The first two patches are not related to the time64 topic, so they might be
applied to 'next' already. The third patch should make its way into the=20
time64 patch queue maintained by Chengson.

Changes from v1:
 - reordered patches
 - cobalt_features_available is now returning a bool value instead of an
   integer
 - cobalt_features_available is now marked as "inline static" instead of=20
   inline only
 - Renamed feature flag from '__xn_feat_settime64' to '__xn_feat_time64'
 - The third patch now includes some "TODO"s that should remind us to
   remove the feature flag when the next ABI revision dump is done

Florian Bezdeka (3):
  lib/cobalt: Rename cobalt_check_features to cobalt_arch_check_features
  lib/cobalt: Introduce generic feature initialization and check API
  cobalt uapi: Introducing new feature flag for time64 availability

 include/cobalt/uapi/asm-generic/features.h    |  6 ++-
 .../arm64/include/asm/xenomai/uapi/features.h |  1 +
 .../include/asm/xenomai/uapi/features.h       |  1 +
 .../x86/include/asm/xenomai/uapi/features.h   |  1 +
 lib/cobalt/arch/arm/features.c                |  2 +-
 lib/cobalt/arch/arm64/features.c              |  2 +-
 lib/cobalt/arch/powerpc/features.c            |  2 +-
 lib/cobalt/arch/x86/features.c                |  2 +-
 lib/cobalt/init.c                             |  2 +-
 lib/cobalt/internal.c                         | 10 +++++
 lib/cobalt/internal.h                         | 39 +++++++++++++++++--
 11 files changed, 58 insertions(+), 10 deletions(-)

--=20
2.26.2

