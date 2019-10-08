From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 0/3] ci build
Date: Tue,  8 Oct 2019 15:14:39 +0200
Message-Id: <20191008131442.21295-1-Quirin.Gylstorff@siemens.com>
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

- Speed up and timeouts of arm64 qemu build
- fix url replacement
- allow empty build options

Quirin Gylstorff (3):
  ci: Speedup arm64 build
  ci: Allow empty Build options
  ci: fix url replacement in jobs.

 .gitlab-ci.yml                    | 14 +++++++-------
 scripts/run-lava-tests.sh         |  2 +-
 tests/jobs/xenomai-qemu-arm64.yml | 25 +++++++++++--------------
 3 files changed, 19 insertions(+), 22 deletions(-)

-- 
2.20.1


