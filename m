From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <470E1FD6.2030607@domain.hid>
References: <470E1FD6.2030607@domain.hid>
Content-Type: text/plain
Date: Mon, 15 Oct 2007 19:29:32 +0200
Message-Id: <1192469372.6001.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH 1/4] tracer: cleanup critical paths
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

On Thu, 2007-10-11 at 15:06 +0200, Jan Kiszka wrote:
> for_each_online_cpu is not free of function calls on SMP, thus causes
> false NMI noise in the tracer log (due to tracer recursions). Switch to
> some plain loop instead.

This one breaks badly on SMP, where NR_CPUS is likely greater than the
highest numbered CPU from the possible CPU map (at least if you don't
lower the former value at config time), so in the TRACE_VMALLOC case,
you end up dereferencing NULL trace_paths[] pointers.

Since we may not want to mark __next_cpu() and find_next_bit() as
notrace routines, we have to check the boundaries:

diff --git a/kernel/ipipe/tracer.c b/kernel/ipipe/tracer.c
index 2326706..8ecbe1a 100644
--- a/kernel/ipipe/tracer.c
+++ b/kernel/ipipe/tracer.c
@@ -255,7 +255,7 @@ __ipipe_trace_freeze(int cpu_id, struct ipipe_trace_path *tp, int pos)
 	active = __ipipe_get_free_trace_path(active, cpu_id);
 
 	/* check if this is the first frozen path */
-	for (i = 0; i < NR_CPUS; i++) {
+	for (i = 0; i < NR_CPUS && trace_paths[i] != NULL; i++) {
 		if ((i != cpu_id) &&
 		    (trace_paths[i][frozen_path[i]].end >= 0))
 			tp->end = -1;
@@ -520,7 +520,7 @@ int ipipe_trace_max_reset(void)
 
 	flags = __ipipe_global_path_lock();
 
-	for (cpu_id = 0; cpu_id < NR_CPUS; cpu_id++) {
+	for (cpu_id = 0; cpu_id < NR_CPUS && trace_paths[cpu_id] != NULL; cpu_id++) {
 		path = &trace_paths[cpu_id][max_path[cpu_id]];
 
 		if (path->dump_lock) {
-- 
Philippe.



