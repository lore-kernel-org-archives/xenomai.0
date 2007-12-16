From: Paul <paul_c@domain.hid>
Date: Sun, 16 Dec 2007 11:58:20 +0000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cLRZHKrd4+iv2Ta"
Message-Id: <200712161158.20969.paul_c@domain.hid>
Subject: [Adeos-main] [PATCH] ipipe fix for PowerPC & SMP
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

--Boundary-00=_cLRZHKrd4+iv2Ta
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Attached, a trivial patch to fix a compile time error when building an SMP 
kernel for powerpc - I suspect this affects all patches for this 
architecture, not just the current 2.6.21 & 2.6.23 releases.


Regards, Paul.





--Boundary-00=_cLRZHKrd4+iv2Ta
Content-Type: text/x-diff;
  charset="us-ascii";
  name="powerpc-ipipe_ipi_message.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="powerpc-ipipe_ipi_message.diff"

diff --git a/arch/powerpc/kernel/ipipe.c b/arch/powerpc/kernel/ipipe.c
index e08301e..553157d 100644
--- a/arch/powerpc/kernel/ipipe.c
+++ b/arch/powerpc/kernel/ipipe.c
@@ -120,9 +120,9 @@ static void __ipipe_ipi_demux(int irq)
 
 	kstat_cpu(cpu).irqs[irq]++;
 
-	while (per_cpu(ipipe_ipi_message.value, cpu) & IPIPE_MSG_IPI_MASK) {
+	while (per_cpu(ipipe_ipi_message, cpu).value & IPIPE_MSG_IPI_MASK) {
 		for (ipi = IPIPE_MSG_CRITICAL_IPI; ipi <= IPIPE_MSG_SERVICE_IPI4; ++ipi) {
-			if (test_and_clear_bit(ipi, &per_cpu(ipipe_ipi_message.value, cpu))) {
+			if (test_and_clear_bit(ipi, &per_cpu(ipipe_ipi_message, cpu).value)) {
 				mb();
 				__ipipe_handle_irq(ipi + IPIPE_MSG_IPI_OFFSET, NULL);
 			}
@@ -163,7 +163,7 @@ int __ipipe_send_ipi(unsigned ipi, cpumask_t cpumask)
 	ipi -= IPIPE_MSG_IPI_OFFSET;
 	for_each_online_cpu(cpu) {
 		if (cpu_isset(cpu, cpumask))
-			set_bit(ipi, &per_cpu(ipipe_ipi_message.value, cpu));
+			set_bit(ipi, &per_cpu(ipipe_ipi_message, cpu).value);
 	}
 	mb();	 
 	

--Boundary-00=_cLRZHKrd4+iv2Ta--

