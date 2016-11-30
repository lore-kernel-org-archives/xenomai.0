Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <bc0b17815f267a151732.1480498947@devws148.be.alcatel-lucent.com>
Date: Wed, 30 Nov 2016 10:42:27 +0100
From: Ronny Meeus <ronny.meeus@gmail.com>
Subject: [Xenomai] [PATCH] psos: add interface to configure region 0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

In the pSOS interface region 0 can be used by applications to allocate
memory from. It contains 'system' memory and is created by default during
system init. Region 0 is currently not supported by the xenomai psos skin.

This patch adds functionality to configure a 'pseudo 0' region that will
be used if applications allocate memory from region 0.

To enable this, following code needs to be added to the early application
init code to configure region 0 (before applications use rn_getseg(0,...)).

unsigned long rnid,rsize;
unsigned long rn_0_size = 128000;
unsigned long unit_size = 128;

rn_create("_RN0",malloc(rn_0_size),rn_0_size, unit_size, 0, &rnid, &rsize);
set_pseudo_rn0_id(rnid);

diff --git a/include/psos/psos.h b/include/psos/psos.h
--- a/include/psos/psos.h
+++ b/include/psos/psos.h
@@ -253,6 +253,8 @@ u_long q_vbroadcast(u_long qid,
 		    u_long msglen,
 		    u_long *count_r);
 
+void set_pseudo_rn0_id(unsigned long id);
+
 u_long rn_create(const char *name,
 		 void *saddr,
 		 u_long rnsize,
diff --git a/lib/psos/rn.c b/lib/psos/rn.c
--- a/lib/psos/rn.c
+++ b/lib/psos/rn.c
@@ -35,6 +35,12 @@ struct pvcluster psos_rn_table;
 
 static unsigned long anon_rnids;
 
+static unsigned long pseudo_rn0_id = 0;
+void set_pseudo_rn0_id(unsigned long id)
+{
+  pseudo_rn0_id = id;
+}
+
 static struct psos_rn *get_rn_from_id(u_long rnid, int *err_r)
 {
 	struct psos_rn *rn = mainheap_deref(rnid, struct psos_rn);
@@ -226,6 +232,9 @@ u_long rn_getseg(u_long rnid, u_long siz
 	int ret = SUCCESS;
 	void *seg;
 
+	if (rnid == 0)
+		rnid = pseudo_rn0_id;
+
 	rn = get_rn_from_id(rnid, &ret);
 	if (rn == NULL)
 		return ret;
@@ -303,6 +312,9 @@ u_long rn_retseg(u_long rnid, void *sega
 	u_long size;
 	void *seg;
 
+	if (rnid == 0)
+		rnid = pseudo_rn0_id;
+
 	rn = get_rn_from_id(rnid, &ret);
 	if (rn == NULL)
 		return ret;

