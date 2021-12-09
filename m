From: Uladzimir Bely <ubely@ilbers.de>
Subject: [xenomai-images] [PATCH 0/1] Upcoming sbuild in Isar support
Date: Thu,  9 Dec 2021 08:36:18 +0100
Message-Id: <20211209073619.17698-1-ubely@ilbers.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

There is 'sbuild' patchset under development in Isar and it requires
some changes in downstream.

This makes 'xenomai-images' compatible with it, but breaks compatibility
with current 'next' branch.

So, this patch is only for applying in the future, when 'sbuild' is
merged in Isar.

Kas container used for build should also consider changes described
here: https://github.com/siemens/meta-iot2050/pull/229 (using external
volume for schroot overlay and sbuild-compatible docker image).

Uladzimir Bely (1):
  Changes to support sbuild-based Isar

 recipes-kernel/linux/linux-xenomai.inc | 14 ++++++++------
 recipes-xenomai/xenomai/xenomai.inc    |  4 +---
 2 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.20.1


