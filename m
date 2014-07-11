Message-ID: <53BF7A2A.7020302@siemens.com>
Date: Fri, 11 Jul 2014 07:46:18 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Inconsistent traced Linux IRQ state on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Gilles,

we see an warning about an inconsistency of the Linux IRQ state on ARM
with CONFIG_PROVE_LOCKING and, thus, CONFIG_TRACE_IRQFLAGS. I just
browsed code and history and stumbled over 11a959bf53 ("ipipe/arm:
disable calls to trace_hardirqs_(on|off) from assembly", ipipe-3.4.6),
the only obvious related delta between vanilla and the ipipe kernel. Can
you comment on both why you disabled it and if you think it could
explain our observation?

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

