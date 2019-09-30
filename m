From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v3 0/2] ci: Documentation and stabilization 
Date: Mon, 30 Sep 2019 16:05:32 +0200
Message-Id: <20190930140534.25731-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <901ed017-ab67-f975-b471-8753adbb4e97@siemens.com>
References: <901ed017-ab67-f975-b471-8753adbb4e97@siemens.com>
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

Add check if ssh connection is up.

Rename ci variables and add documentation for ci variables.


Changes:
 V3:
  add documentation and variable naming scheme
 V2:
  add 1 minute timeout

Quirin Gylstorff (2):
  scripts/run-lava-tests: Wait until ssh connection is open
  ci: Clarify ci variables

 .gitlab-ci.yml                | 15 +++++++--------
 scripts/deploy_for_testing.sh | 20 +++++++++++---------
 scripts/run-lava-tests.sh     | 25 ++++++++++++++++++++-----
 tests/README.md               | 22 ++++++++++++++++++++--
 4 files changed, 58 insertions(+), 24 deletions(-)

--
2.20.1


