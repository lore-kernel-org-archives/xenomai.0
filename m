From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: dovetail: DEBUG_LOCKS_WARN_ON(!lockdep_stage_disabled())
Message-ID: <7bd62ff7-0f90-d881-4a5f-7a80091aa321@siemens.com>
Date: Wed, 9 Jun 2021 14:27:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

currently trying to understand [1]: The check in
lockdep_hardirqs_on_prepare triggers, e.g. over exc_int3 ->
do_int3_user, and then on cond_local_irq_enable().

Where should have the current stage be stalled after exc_int3 so that
lockdep is happy?

Interestingly, I do not get this with my local .config, and I still
didn't find the switches that make the difference.

Jan

[1] https://source.denx.de/Xenomai/xenomai-images/-/jobs/276895#L946

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

