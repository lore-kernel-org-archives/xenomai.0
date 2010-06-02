From: "Katsuhiko Isono" <k-isono@domain.hid>
Date: Thu, 3 Jun 2010 08:31:52 +0900
Message-ID: <6D556AFBBAD7426CBD7EDECBA8A2A361@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] "arm: fix mm switching" patch effective also for
	2.4.10 ?
Reply-To: k-isono@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I use linux-2.6.26 + xenomai-2.4.10 with custom arm(i.mx31) board.

When realtime application was executed on my environment,
application caused the SIGSEGV fault about once every several hours.

However, when I applied "arm: fix mm switching" patch of xenomai-2.5 to 
my environment, SIGSEGV fault did not happen.

There is a following question.
 - Is this patch effective also for 2.4.10 ?
 - What trouble is corrected with this patch ?

Best regards,

K.Isono



