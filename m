From: "Merckx, Sebastiaan (Nokia - BE/Antwerp)" <sebastiaan.merckx@nokia.com>
Subject: Alchemy API queue size issue
Date: Tue, 17 Mar 2020 10:26:39 +0000
Message-ID: <AM0PR07MB54107060F24921876BC65F77E6F60@AM0PR07MB5410.eurprd07.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

We noticed a bug in the alchemy API of xenomai library. The allocated memor=
y for queues seemed too big.
I assume that below is the fix (and we are using the patch internally).
Let me know if you need more info or if this would not be correct.

Best Regards,
Sebastiaan Merckx

diff --git a/lib/alchemy/queue.c b/lib/alchemy/queue.c
--- a/lib/alchemy/queue.c
+++ b/lib/alchemy/queue.c
@@ -261,7 +261,7 @@ int rt_queue_create(RT_QUEUE *queue, con
                                   poolsize + (poolsize * 5 / 100));
        else
                ret =3D heapobj_init_array(&qcb->hobj, qcb->name,
-                                        (poolsize / qlimit) *
+                                        (poolsize / qlimit) +
                                         sizeof(struct alchemy_queue_msg),
                                         qlimit);
        if (ret)
