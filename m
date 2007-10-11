Message-ID: <470E1FD6.2030607@domain.hid>
Date: Thu, 11 Oct 2007 15:06:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090704050702010604040909"
Subject: [Adeos-main] [PATCH 1/4] tracer: cleanup critical paths
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: Philippe Gerum <rpm@xenomai.org>

This is a multi-part message in MIME format.
--------------090704050702010604040909
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

for_each_online_cpu is not free of function calls on SMP, thus causes
false NMI noise in the tracer log (due to tracer recursions). Switch to
some plain loop instead.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------090704050702010604040909
Content-Type: text/x-patch;
 name="cleanup-critical-tracer-paths.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cleanup-critical-tracer-paths.patch"

---
 kernel/ipipe/tracer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.22.9/kernel/ipipe/tracer.c
===================================================================
--- linux-2.6.22.9.orig/kernel/ipipe/tracer.c
+++ linux-2.6.22.9/kernel/ipipe/tracer.c
@@ -252,7 +252,7 @@ __ipipe_trace_freeze(int cpu_id, struct 
 	active = __ipipe_get_free_trace_path(active, cpu_id);
 
 	/* check if this is the first frozen path */
-	for_each_online_cpu(i) {
+	for (i = 0; i < NR_CPUS; i++) {
 		if ((i != cpu_id) &&
 		    (trace_paths[i][frozen_path[i]].end >= 0))
 			tp->end = -1;
@@ -515,7 +515,7 @@ int ipipe_trace_max_reset(void)
 
 	flags = __ipipe_global_path_lock();
 
-	for_each_online_cpu(cpu_id) {
+	for (cpu_id = 0; cpu_id < NR_CPUS; cpu_id++) {
 		path = &trace_paths[cpu_id][max_path[cpu_id]];
 
 		if (path->dump_lock) {


--------------090704050702010604040909--

