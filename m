From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 0/3] Update for ci 
Date: Tue, 27 Aug 2019 11:07:49 +0200
Message-Id: <20190827090752.13072-1-Quirin.Gylstorff@siemens.com>
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

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add all supported targets to ci and mention the targets in README.
Fix arm64 builds in ci.

Quirin Gylstorff (3):
  README: Add subsection physical targets
  ci: Add new boards to ci
  distro/include: Allow overwrite PREFERRED_VERSION

 .gitlab-ci.yml                          | 18 ++++++++++++++----
 README.md                               |  7 ++++++-
 conf/distro/include/xenomai-version.inc |  2 +-
 3 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.20.1


