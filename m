Message-ID: <5241DAB0.8000604@siemens.com>
Date: Tue, 24 Sep 2013 20:32:16 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] libalchemy: failing test case task-5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

I played a bit with the native skin emulation in Xenomai 3. The shipped
test cases in lib/alchemy/testsuite point a problem:
rt_task_set_priority is no longer a pure real-time services. As it calls
libc's pthread_setschedparam internally, it will - at least briefly -
switch the caller to secondary mode. This break the task-5 test which
assumes a different behaviour.

Are there ideas/plans to address this issues? Are there more case known
where the new architecture provides some challenges when trying to
preserve original API semantics?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

