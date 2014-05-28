From: Peter Howard <phoward@gme.net.au>
Date: Wed, 28 May 2014 00:35:57 +0000
Message-ID: <B2415EB1697ACE44AE82CBBFA957DEED48B146@EXCH01.gme.net.au>
References: <1401236892.2728.11.camel@nswph.gme.net.au>
In-Reply-To: <1401236892.2728.11.camel@nswph.gme.net.au>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] [PATCH 1/2] Fix to Ti EDMA code - refer
 http://www.spinics.net/lists/linux-omap/msg10462
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

---
 drivers/dma/edma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index cd8da45..bf5ad0f 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -182,11 +182,13 @@ static void edma_execute(struct edma_chan *echan)
 =09=09=09=09  echan->ecc->dummy_slot);
 =09}
=20
-=09edma_resume(echan->ch_num);
-
 =09if (edesc->processed <=3D MAX_NR_SG) {
 =09=09dev_dbg(dev, "first transfer starting %d\n", echan->ch_num);
 =09=09edma_start(echan->ch_num);
+=09} else {
+=09=09dev_dbg(dev, "chan: %d: completed %d elements, resuming\n",
+=09=09=09echan->ch_num, edesc->processed);
+=09=09edma_resume(echan->ch_num);
 =09}
=20
 =09/*
--=20
1.9.3

______________________________________________________________________
This email has been scanned by the Symantec Email Security.cloud service.
For more information please visit http://www.symanteccloud.com
______________________________________________________________________

