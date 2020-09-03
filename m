From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [PATCH 0/1] Add gitlab-ci to xenomai
Date: Thu,  3 Sep 2020 15:56:59 +0200
Message-Id: <20200903135700.25134-1-Quirin.Gylstorff@siemens.com>
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
To: xenomai@xenomai.org, jan.kiszka@siemens.com

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patch adds a gitlab-ci.yml to support ci builds on gitlab. The
build is derived from .travis.yml and works in a similar way.

Quirin Gylstorff (1):
  ci: Add gitlab-ci.yml

 .gitlab-ci.yml | 254 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 254 insertions(+)
 create mode 100644 .gitlab-ci.yml

-- 
2.20.1


