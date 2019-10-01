From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 4/4] xenomai-beaglebone: remove context
 after update
Date: Tue,  1 Oct 2019 14:52:03 +0200
Message-Id: <20191001125203.10757-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20191001125203.10757-1-Quirin.Gylstorff@siemens.com>
References: <20191001125203.10757-1-Quirin.Gylstorff@siemens.com>
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

After updating  the lava environment to 2019.9 the option baud_rate
in the job context can no longer be overwritten. Remove the context
to ensure the job execution.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 tests/jobs/xenomai-beaglebone.yml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tests/jobs/xenomai-beaglebone.yml b/tests/jobs/xenomai-beaglebone.yml
index 138c8cb..ceb4d0d 100644
--- a/tests/jobs/xenomai-beaglebone.yml
+++ b/tests/jobs/xenomai-beaglebone.yml
@@ -25,9 +25,6 @@ metadata:
   # please change these fields when modifying this job for your own tests.
   docs-source: xenomai-beagleboneblack
   docs-filename: pipeline-xenomai-beagleboneblack
-context:
-  console_device: ttyO
-  baud_rate: 115200
 # ACTION_BLOCK
 actions:
 - deploy:
-- 
2.20.1


