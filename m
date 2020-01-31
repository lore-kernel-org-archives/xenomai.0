From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 8/8] boilerplate: setup: fix infinite loop in CPU list parser
Date: Fri, 31 Jan 2020 16:27:13 +0100
Message-Id: <20200131152713.1811748-9-rpm@xenomai.org>
In-Reply-To: <20200131152713.1811748-1-rpm@xenomai.org>
References: <20200131152713.1811748-1-rpm@xenomai.org>
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

From: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 lib/boilerplate/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index 3214d7f04..5139560e8 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -178,7 +178,7 @@ static int collect_cpu_affinity(const char *cpu_list)
 	s = n = strdup(cpu_list);
 	while ((range = strtok_r(n, ",", &range_p)) != NULL) {
 		if (*range == '\0')
-			continue;
+			goto next;
 		end = -1;
 		if (range[strlen(range)-1] == '-')
 			end = nr_cpus - 1;
@@ -203,6 +203,7 @@ static int collect_cpu_affinity(const char *cpu_list)
 		}
 		for (cpu = start; cpu <= end; cpu++)
 			CPU_SET(cpu, &__base_setup_data.cpu_affinity);
+	next:
 		n = NULL;
 	}
 
-- 
2.24.1


