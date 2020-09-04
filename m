From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [PATCH v2 0/1] Add gitlab-ci to Xenomai
Date: Fri,  4 Sep 2020 12:32:47 +0200
Message-Id: <20200904103248.31899-1-Quirin.Gylstorff@siemens.com>
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
build is derived from .travis.yml.

An executed pipeline can be found at [1].

Changes V2:
 - adapt git remote ls syntax to git version 2.20 from 2.17

I also look into using the same base for .travis-ci.yml and gitlab-ci.yml.
What we can do is moving the script and before_script parts into a
shell script or something similar. The job description syntax is
not compatible (env instead variables, jobs are under the element
jobs/matrix instead of root). IMHO we need some generator to
use the same job description for Travis and gitlab-ci.

[1]: https://gitlab.com/Quirin.Gy/xenomai/-/pipelines/185711450

Quirin Gylstorff (1):
  ci: Add gitlab-ci.yml

 .gitlab-ci.yml | 253 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 253 insertions(+)
 create mode 100644 .gitlab-ci.yml

-- 
2.20.1


