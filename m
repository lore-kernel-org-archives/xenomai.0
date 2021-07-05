From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] tests: Limit supported cpus on physical
 multicore targets
Message-ID: <c4c1fda2-4ca0-e3bf-acf2-57cf678c3263@siemens.com>
Date: Mon, 5 Jul 2021 20:02:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This tests xenomai.supported_cpus not covering all available CPUs,
allowing the related smokey test to run and more.

We restrict this to targets with more than 2 cores, which currently
excludes all QEMU targets.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tests/jobs/xenomai-hikey.yml      | 2 ++
 tests/jobs/xenomai-ipc227e.yml    | 2 ++
 tests/jobs/xenomai-x86-64-efi.yml | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
index f6eb4a4..a2cbdaa 100644
--- a/tests/jobs/xenomai-hikey.yml
+++ b/tests/jobs/xenomai-hikey.yml
@@ -70,3 +70,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=0x7f
diff --git a/tests/jobs/xenomai-ipc227e.yml b/tests/jobs/xenomai-ipc227e.yml
index a5a181c..131415a 100644
--- a/tests/jobs/xenomai-ipc227e.yml
+++ b/tests/jobs/xenomai-ipc227e.yml
@@ -72,3 +72,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=0x7
diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
index bc71b75..5a2f533 100644
--- a/tests/jobs/xenomai-x86-64-efi.yml
+++ b/tests/jobs/xenomai-x86-64-efi.yml
@@ -72,3 +72,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=0x7
-- 
2.26.2

