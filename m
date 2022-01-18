From: Uladzimir Bely <ubely@ilbers.de>
Subject: [xenomai-images] [PATCH v2 0/2] Upcoming sbuild in Isar support
Date: Tue, 18 Jan 2022 11:51:26 +0100
Message-Id: <20220118105128.3007-1-ubely@ilbers.de>
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
To: xenomai@xenomai.org, ubely@ilbers.de

There is 'sbuild' patchset under development in Isar and it requires
some changes in the downstream.

This patchset makes 'xenomai-images' compatible with it without breaking
compatibility with current 'next' branch of Isar.

Changes since v1:
- Removed bootstrap for xenomai recipe since it's done in debian/rules
- Kernel patching is done in Debian way, so should be compatible with
any build system. Both buildchroot and sbuild were tested.

Uladzimir Bely (2):
  xenomai: remove bootstrap task from dpkg_runbuild_prepend
  linux-xenomai: handle xenomai-kernel patch in Debian way

 recipes-kernel/linux/linux-xenomai.inc | 13 ++++++++-----
 recipes-xenomai/xenomai/xenomai.inc    | 17 -----------------
 2 files changed, 8 insertions(+), 22 deletions(-)

-- 
2.20.1


