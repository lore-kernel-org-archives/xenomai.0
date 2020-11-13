From: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Subject: [PATCH 0/3] Make offered kernel features accessible during
Date: Fri, 13 Nov 2020 11:59:59 +0000
Message-ID: <20201113115932.276959-1-florian.bezdeka@siemens.com>
References: <1229be33-848d-ab5b-d6dd-1b7ae38d36f9@siemens.com>
In-Reply-To: <1229be33-848d-ab5b-d6dd-1b7ae38d36f9@siemens.com>
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, "chensong@tj.kylinos.cn" <chensong@tj.kylinos.cn>

From: Florian Bezdeka <florian.bezdeka@siemens.com>

Hi all,

while reviewing the settime64 syscall patches I noticed that we do not
have any infrastructure that allows us to check which features are
offered by the currently running kernel.

With this patch series I try to fix this gap. Everything is compile
time tested only so far. I'm currently trying to bring my test
infrastructure up and running.

Comments welcome...

Florian Bezdeka (3):
  cobalt uapi: Introducing new feature flag for settime64 availability
  lib/cobalt: Rename cobalt_check_features to cobalt_arch_check_features
  lib/cobalt: Introduce generic feature initialization and check API

 include/cobalt/uapi/asm-generic/features.h |  6 +++-
 lib/cobalt/arch/arm/features.c             |  2 +-
 lib/cobalt/arch/arm64/features.c           |  2 +-
 lib/cobalt/arch/powerpc/features.c         |  2 +-
 lib/cobalt/arch/x86/features.c             |  2 +-
 lib/cobalt/init.c                          |  2 +-
 lib/cobalt/internal.c                      | 10 ++++++
 lib/cobalt/internal.h                      | 39 +++++++++++++++++++---
 8 files changed, 55 insertions(+), 10 deletions(-)

--=20
2.26.2

