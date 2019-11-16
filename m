From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] lib/cobalt: Fix help for --print-sync-delay
Message-ID: <f4ccbc37-42d1-e683-aa26-8eadb4428470@siemens.com>
Date: Sat, 16 Nov 2019 09:53:55 +0100
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
Cc: Steve Freyder <steve@freyder.net>, Jeff Webb <w1@codecraftsmen.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Misnamed by the original commit f42334abc373.

While at it, also fix indention style.

Reported-by: Steve Freyder <steve@freyder.net>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Seems like I missed this because it wasn't presented as patch.
Will go to stable as well.

 lib/cobalt/init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
index 02a99c569c..9b506d872d 100644
--- a/lib/cobalt/init.c
+++ b/lib/cobalt/init.c
@@ -353,10 +353,10 @@ static int cobalt_parse_option(int optnum, const char *optarg)
 
 static void cobalt_help(void)
 {
-        fprintf(stderr, "--main-prio=<prio>		main thread priority\n");
-        fprintf(stderr, "--print-buffer-size=<bytes>	size of a print relay buffer (16k)\n");
-        fprintf(stderr, "--print-buffer-count=<num>	number of print relay buffers (4)\n");
-        fprintf(stderr, "--print-buffer-syncdelay=<ms>	max delay of output synchronization (100 ms)\n");
+	fprintf(stderr, "--main-prio=<prio>		main thread priority\n");
+	fprintf(stderr, "--print-buffer-size=<bytes>	size of a print relay buffer (16k)\n");
+	fprintf(stderr, "--print-buffer-count=<num>	number of print relay buffers (4)\n");
+	fprintf(stderr, "--print-sync-delay=<ms>	max delay of output synchronization (100 ms)\n");
 }
 
 static struct setup_descriptor cobalt_interface = {
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

