Message-ID: <4AF85A5F.2030203@domain.hid>
Date: Mon, 09 Nov 2009 19:07:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Unchecked ipipe_test_pipeline_from
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Hi Philippe,

just noticed: The __ipipe_check_percpu_access of __ipipe_get_cpu_var,
added in 2.6.29, makes ipipe_test_pipeline_from unusable for debugging
purposes. It now triggers a false positive warning if the caller did not
disabled interrupts or stalled its pipeline. One such user under Xenomai
is rthal_local_irq_disabled, and that is used to check RTDM driver
handlers /wrt leaking IRQ masks.

Introduce a debug-free ipipe_check_pipeline_from for
rthal_local_irq_disabled?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

