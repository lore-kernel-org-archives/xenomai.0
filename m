From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 10/11] testsuite/switchtest: Fix help output
Date: Mon, 26 Oct 2020 12:04:56 +0100
Message-Id: <6e44b64889bd4922178276ee3aa13379fbfde1db.1603710297.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1603710297.git.jan.kiszka@siemens.com>
References: <cover.1603710297.git.jan.kiszka@siemens.com>
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
Cc: Fino Meng <fino.meng@linux.intel.com>, Mingliang Hu <mingliang.hu@intel.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

As the Xenomai libs hook into the option parser and hijack --help, we
need to provide application_usage() in order to get the full help
printed.

Needs eventually a better fix, i.e. the removal of the implicit parser
hook.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/switchtest/switchtest.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index 015bde653a..f2a5c1601a 100644
--- a/testsuite/switchtest/switchtest.c
+++ b/testsuite/switchtest/switchtest.c
@@ -1062,6 +1062,11 @@ static void usage(FILE *fd, const char *progname)
 	fprintf(fd, "\n\n");
 }
 
+void application_usage(void)
+{
+	usage(stdout, get_program_name());
+}
+
 static sigjmp_buf jump;
 
 static void illegal_instruction(int sig)
-- 
2.26.2


