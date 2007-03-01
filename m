Message-ID: <45E70476.2060804@domain.hid>
Date: Thu, 01 Mar 2007 17:51:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <45E494AC.5050603@domain.hid> <45E58DA9.5030907@domain.hid>
	<45E58FA6.6000504@domain.hid>
	<200702280931.46615.jweber@domain.hid>
In-Reply-To: <200702280931.46615.jweber@domain.hid>
Content-Type: multipart/mixed; boundary="------------080104020506060808060507"
Subject: [Xenomai-core] Re: [Xenomai-help] task not being scheduled
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jeff Weber <jweber@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai Core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------080104020506060808060507
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7Bit

Jeff Weber wrote:
> On Wednesday 28 February 2007 08:20, Gilles Chanteperdrix wrote:
> 
>>Jan Kiszka wrote:
>>
>>
>>>Jeff, you have the ultimate test case now. Will you have some time to
>>>run that test on your box so that we can quickly find and resolve the
>>>bug?
> 
> 
> Yes.  I've rebuilt my kernel with the linked list scheduler, but I've saved 
> the previous heap scheduler config.  I will recreate the bug config, and 
> await a patch or instrumentation.
> 
>>Is it possible to get a simplified version of the application you are
>>running with only timer-related events ? Some kind of model that I could
>>quietly run in the simulator ?
> 
> That will be more difficult.  The application requires a custom kernel module, 
> and has many dependencies upon our hardware.  Further, the app is written in 
> C++, which I understand is not compatible with the simulator.
> 
> Let me know if you would like to move this discussion off the xenomai-help 
> list, to xenomai-core, or a private email discussion.
> 
> And again, thanks for taking the time to look at my trace, config and 
> recommend a solution.  It was causing considerable frustration on this end.

Ok. Following up on xenomai-core. Find attached a not too subtle
instrumentation that saves the state of the heap after each elementary
operation. This history is then dumped with printk on xntrace freeze.

-- 
                                                 Gilles Chanteperdrix

--------------080104020506060808060507
Content-Type: text/x-patch;
 name="xeno-trace-bheap.diff"
Content-Disposition: inline;
 filename="xeno-trace-bheap.diff"
Content-Transfer-Encoding: Quoted-Printable

Index: include/nucleus/bheap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/bheap.h	(r=C3=A9vision 2730)
+++ include/nucleus/bheap.h	(copie de travail)
@@ -25,6 +25,12 @@
=20
 /* Priority queue implementation, using a binary heap. */
=20
+typedef enum {
+	BHEAP_INSERT,
+	BHEAP_DELETE,
+	BHEAP_GETHEAD,
+} bheap_op_t;
+=20
 typedef unsigned long long bheap_key_t;
=20
 typedef struct bheaph {
@@ -66,11 +72,18 @@
     __internal_bheap_gethead(_bheap);           \
 })
=20
+void bheap_s_init(void);
+
+void bheap_save_push(bheap_t *q, bheap_op_t op, bheaph_t *elem);
+
+void bheap_ops_dump(void);
+
 static inline bheaph_t *__internal_bheap_gethead(bheap_t *heap)
 {
     if (heap->last =3D=3D 1)
         return NULL;
=20
+    bheap_save_push(heap, BHEAP_GETHEAD, heap->elems[1]);
     return heap->elems[1];
 }
=20
@@ -158,6 +171,7 @@
     bheaph_pos(holder) =3D heap->last;
     ++heap->last;
     bheap_up(heap, holder);
+    bheap_save_push(heap, BHEAP_INSERT, holder);
     return 0;
 }
=20
@@ -182,6 +196,7 @@
         bheaph_pos(lasth) =3D bheaph_pos(holder);
         bheap_down(heap, lasth);
     }
+    bheap_save_push(heap, BHEAP_DELETE, holder);
=20
     return 0;
 }
Index: ksrc/nucleus/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/timer.c	(r=C3=A9vision 2730)
+++ ksrc/nucleus/timer.c	(copie de travail)
@@ -755,6 +755,9 @@
=20
 void xntimer_set_aperiodic_mode(void)
 {
+#if defined(CONFIG_XENO_OPT_TIMER_HEAP)
+	bheap_s_init();
+#endif
 	nktimer =3D &timer_ops_aperiodic;
 }
=20
@@ -771,3 +774,166 @@
 EXPORT_SYMBOL(xntimer_get_date);
 EXPORT_SYMBOL(xntimer_get_timeout);
 EXPORT_SYMBOL(nktimer);
+
+#if defined(CONFIG_XENO_OPT_TIMER_HEAP)
+typedef struct {
+	unsigned sz;
+	unsigned last;
+	bheaph_t elems[CONFIG_XENO_OPT_TIMER_HEAP_CAPACITY + 1];
+/* indexing starts at 1	*/
+} bheap_save_t;
+
+#define BHEAP_SAVE_SIZE 256
+typedef struct {
+	unsigned head;
+	unsigned tail;
+	struct {
+		bheap_op_t op;
+		unsigned long long ts;
+		bheap_save_t save;
+	} array [BHEAP_SAVE_SIZE];
+} bheap_s_t;
+
+bheap_s_t *_bheap_s[2], *bheap_s;
+
+static void bheap_save(bheap_save_t *save, bheap_t *q)
+{
+	unsigned i;
+	save->sz =3D q->sz;
+	save->last =3D q->last;
+	for (i =3D 1; i < save->last; i++)
+		save->elems[i] =3D *(q->elems[i]);
+}
+
+void bheap_s_init(void)
+{
+	_bheap_s[0] =3D vmalloc(sizeof(bheap_s_t));
+	BUG_ON(!_bheap_s[0]);
+	_bheap_s[0]->head =3D _bheap_s[0]->tail =3D 0;
+	_bheap_s[1] =3D vmalloc(sizeof(bheap_s_t));
+	BUG_ON(!_bheap_s[1]);
+	_bheap_s[1]->head =3D _bheap_s[1]->tail =3D 0;
+	bheap_s =3D _bheap_s[0];
+}
+
+void bheap_save_push(bheap_t *q, bheap_op_t op, bheaph_t *elem)
+{
+	if (bheap_s->tail =3D=3D bheap_s->head + BHEAP_SAVE_SIZE)
+		bheap_s->head++;
+	bheap_s->array[bheap_s->tail % BHEAP_SAVE_SIZE].ts =3D xnarch_get_cpu_t=
sc();
+	bheap_s->array[bheap_s->tail % BHEAP_SAVE_SIZE].op =3D op;
+	bheap_s->array[bheap_s->tail % BHEAP_SAVE_SIZE].save.elems[0]=3D*elem;
+	bheap_save(&bheap_s->array[bheap_s->tail % BHEAP_SAVE_SIZE].save, q);
+	bheap_s->tail++;
+}
+
+static int ts_convert(char *buf, size_t sz, unsigned long long ts)
+{
+	unsigned long long ns =3D xnarch_tsc_to_ns(ts);
+	unsigned hrs, mins, secs, nsecs;
+	nsecs =3D do_div(ns, 1000000000);
+	secs =3D ns;
+	mins =3D secs / 60;
+	secs %=3D 60;
+	hrs =3D mins / 60;
+	mins %=3D 60;
+	return snprintf(buf, sz, "%3u:%02u:%02u.%09u", hrs, mins, secs, nsecs);
+}
+
+static int bheaph_prn(char *buf, size_t sz, const bheaph_t *const holder=
)
+{
+	return ts_convert(buf, sz, holder->key);
+}
+
+static void
+bheap_dumper_visit (bheap_save_t *heap,
+                    bheaph_t *node,
+                    int (*prn)(char *, size_t, const bheaph_t *const),
+                    const char *blank,
+                    unsigned blank_sz,
+                    char *buf,
+                    unsigned indent,
+                    unsigned len)
+{
+	unsigned pos =3D 2 * node->pos + 1;
+
+	if(pos < heap->last) {
+		bheaph_t *child =3D &heap->elems[pos];
+		if(blank_sz >=3D (unsigned) (buf-blank)) {
+			snprintf(buf, len+2, "%*s\n", (int) len+1, "bug!");
+			printk("%s", buf-blank_sz);
+		} else
+			bheap_dumper_visit(heap, child, prn, blank,
+					   blank_sz+indent, buf, indent, len);
+	}
+=09
+	(*prn)(buf, len+1, node);
+	buf[len] =3D '\n';
+	buf[len+1] =3D '\0';
+=09
+	printk("%s", buf-blank_sz);
+
+	--pos;
+	if(pos < heap->last) {
+		bheaph_t *child =3D &heap->elems[pos];
+		if(blank_sz >=3D (unsigned) (buf-blank)) {
+			snprintf(buf, len+2, "%*s\n", (int) len+1, "bug!");
+			printk("%s", buf-blank_sz);
+		} else
+			bheap_dumper_visit(heap, child, prn, blank,
+					   blank_sz+indent, buf, indent, len);
+	}
+}
+
+static void
+bheap_s_dump(bheap_save_t *heap,
+	     int (*prn)(char *, size_t, const bheaph_t *const),
+	     unsigned margin,
+	     unsigned indent,
+	     unsigned len)
+{
+	if (heap->last =3D=3D 1) {
+		printk("%s", "Empty.\n");
+	} else {
+		size_t blank_sz =3D (fls(heap->last - 1) + 1) * indent + margin;
+		char buffer[blank_sz+len+2];
+		memset(buffer, ' ', blank_sz);
+
+		bheap_dumper_visit(heap, &heap->elems[1], prn, buffer, margin,
+				   buffer+blank_sz, indent, len);
+	}
+}
+
+void bheap_ops_dump(void)
+{
+	static const char *ops [] =3D {
+		[BHEAP_INSERT] =3D "insert",
+		[BHEAP_DELETE] =3D "delete",
+		[BHEAP_GETHEAD]=3D "gthead"
+	};
+	bheap_s_t *cur_s;
+	unsigned i;
+	spl_t s;
+
+	xnlock_get_irqsave(&nklock, s);
+	cur_s =3D bheap_s;
+	bheap_s =3D bheap_s =3D=3D _bheap_s[0] ? _bheap_s[1] : _bheap_s[0];
+	xnlock_put_irqrestore(&nklock, s);
+
+	for(i =3D cur_s->head % BHEAP_SAVE_SIZE;
+	    i < cur_s->tail % BHEAP_SAVE_SIZE;
+	    i++) {
+		char bts[20], bkey[20];
+		ts_convert(bts, sizeof(bts), cur_s->array[i].ts);
+		ts_convert(bkey, sizeof(bkey),
+			   cur_s->array[i].save.elems[0].key);
+	=09
+		printk("%s: %s %s\n", bts, ops[cur_s->array[i].op], bkey);
+		bheap_s_dump(&cur_s->array[i].save, bheaph_prn, 8, 4, 19);
+		printk("\n");
+	}
+
+	cur_s->head =3D cur_s->tail =3D 0;
+}
+
+#endif
Index: ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/shadow.c	(r=C3=A9vision 2730)
+++ ksrc/nucleus/shadow.c	(copie de travail)
@@ -1330,6 +1330,9 @@
 		break;
=20
 	case __xntrace_op_user_freeze:
+#if defined(CONFIG_XENO_OPT_TIMER_HEAP)
+		bheap_ops_dump();
+#endif
 		err =3D xnarch_trace_user_freeze(__xn_reg_arg2(regs),
 					       __xn_reg_arg3(regs));
 		break;

--------------080104020506060808060507--

