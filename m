From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3319d6fa-2541-67bf-f03b-15b440a1b8a6@siemens.com>
Date: Mon, 9 Jul 2018 19:48:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Eager FPU vs. recent kernels
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>, Henning Schild <henning.schild@siemens.com>

Hi,

the x86 FPU changes that so far only affected 4.14 and delayed its ipipe
progress on that arch. However, CVE-2018-3665 is not making it a topic
for every ipipe kernel (that should be kept up to date): lazy FPU is
history, now also for security reasons (before that only for performance
reasons).

That raises the question how much the Xenomai 3 core depends on lazy FPU
state switching. Philippe, can you describe the general flow of context
switching /wrt the FPU state so far? Can we overcome lazy by just
replacing the current FPU functions in kernel/cobalt/arch/x86/thread.c
with eager ones, maybe depending on some CONFIG_IPIPE_X86_HAS_EAGER_FPU
compile-time dependency?

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

