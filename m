From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] smokey: Close tmp file at end of sigdebug test
Message-ID: <76d23c96-50c4-88b1-fe46-6c11e6b0d880@siemens.com>
Date: Mon, 10 Feb 2020 18:52:19 +0100
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

The rtdm test relies on successively free file descriptors which is
violated by this test when the run after each other.

Reported-by: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/sigdebug/sigdebug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testsuite/smokey/sigdebug/sigdebug.c b/testsuite/smokey/sigdebug/sigdebug.c
index 15f9e4dae3..9cb5162c14 100644
--- a/testsuite/smokey/sigdebug/sigdebug.c
+++ b/testsuite/smokey/sigdebug/sigdebug.c
@@ -292,6 +292,7 @@ static int run_sigdebug(struct smokey_test *t, int argc, char *const argv[])
 	err = sem_destroy(&send_signal);
 	check_no_error("sem_destroy", err);
 
+	close(tmp_fd);
 	if (wd) {
 		fprintf(wd, "%d", wdog_delay);
 		fclose(wd);
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

