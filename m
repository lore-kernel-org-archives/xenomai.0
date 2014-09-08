Message-ID: <540D4E9A.4090203@siemens.com>
Date: Mon, 08 Sep 2014 08:37:14 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Flexcan driver build broken since 3.11 - also in upstream?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi all,

just noticed a build breakage in Xenomai 2: ksrc/drivers/can/flexcan.c
is looking for linux/can/platform/flexcan.h which was removed in
baffd2e8d9. But both the Xenomai driver and upstream's flexcan.c still
use the flexcan_platform_data structure which I do not find anywhere in
the kernel. Does anyone know what happened there?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

