Message-ID: <4AEEA9AF.5030302@domain.hid>
Date: Mon, 02 Nov 2009 10:43:11 +0100
From: Alexandre Coffignal <alexandre.coffignal@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] bug found in psos queue
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello all,

I found a bug in xenomai-2.4/src/skins/psos+/queue.c,
in function q_vreceive, struct modifier is not corectly fill with
argument data.

Here the patch to fix this bug

regards,

Alexandre

diff --git a/CREDITS b/CREDITS
index f2ce6ca..6342a8c 100644
--- a/CREDITS
+++ b/CREDITS
@@ -142,3 +142,7 @@ D: Autoconf-related fixes.
 N: Frederic Villeneuve
 E: frederic.villeneuve@domain.hid
 D: udev support for message pipes.
+
+N: Alexandre Coffignal
+E: alexandre.coffignal@domain.hid
+D: psos skin q_vreceive bug fix
diff --git a/src/skins/psos+/queue.c b/src/skins/psos+/queue.c
index 228f5bd..c54f966 100644
--- a/src/skins/psos+/queue.c
+++ b/src/skins/psos+/queue.c
@@ -82,6 +82,10 @@ u_long q_vreceive(u_long qid, u_long flags, u_long
timeout,
                u_long flags;
                u_long timeout;
        } modifiers;    /* Combine to fit into available arg space (i.e.
5) */
+
+       modifiers.flags=flags;
+       modifiers.timeout=timeout;
+
        return XENOMAI_SKINCALL5(__psos_muxid, __psos_q_vreceive,
                                 qid, &modifiers, msgbuf_r, buflen,
msglen_r);
 }


-- 
Alexandre COFFIGNAL, Chef de Projet
Email: alexandre.coffignal[@]cenosys.com
<mailto:alexandre.coffignal@domain.hid>
------------------------------------

10, Rue Xavier Bichat
F-72000 Le MANS
web : http://www.cenosys.com
------------------------------------


