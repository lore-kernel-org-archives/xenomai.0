From: Henning Schild <henning.schild@siemens.com>
Date: Tue, 13 Feb 2018 13:38:18 +0100
Message-Id: <cover.1518525088.git.henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 0/3] debian/ realted changes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The first one actually fixes a regression where debian packages can not
be generated anymore. And the remaining two fix minor issues.

Henning Schild (3):
  debian: drop prebuild docs from packages
  debian: add mssing build dependency
  debian: increase debian compat level

 debian/compat                  |  2 +-
 debian/control                 | 25 ++++---------------------
 debian/xenomai-doc.install     |  1 -
 debian/xenomai-runtime.install |  1 -
 4 files changed, 5 insertions(+), 24 deletions(-)
 delete mode 100644 debian/xenomai-doc.install

-- 
2.13.6


