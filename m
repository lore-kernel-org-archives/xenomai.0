From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: resume_oob_task & not actually resuming
Message-ID: <558c11ab-794c-29f6-be73-6045a0b90198@siemens.com>
Date: Wed, 30 Jun 2021 17:56:03 +0200
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
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

Hi Philippe,

need you guidance here to fix the "thread ... switched to non-rt CPU,
aborted" issue:

For some reason, I-pipe is fine and kicks the migrating non-rt task
again when ipipe_migration_hook() does not resume the target thread due
to failing cobalt_affinity_ok() check. Over dovetail, this is not
working, and the thread is stuck in nirvana, i.e. suspended as hardened
from Linux POV but not resumed on the Xenomai side. Looking at how
finalize_oob_transition() is called in the dovetail kernel, it does not
seem like it is prepared for not being in oob after that call
(finish_task_switch is not called - not sure if that makes the difference).

So, either the point of checking and failing the migration in Xenomai is
wrong for dovetail, or we need some extension of the latter to account
for that case. What was the intended design?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

