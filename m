From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5224b3e2-d316-d61b-347f-6a6cac8d6360@siemens.com>
Date: Mon, 2 Jul 2018 15:18:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Cobalt __SIGPOOL_SIZE
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

The comment for __SIGPOOL_SIZE in kernel/cobalt/posix/signal.c suggests
that there can't be many signals in pending state at the same time, but
I think it is wrong: Signal are collected per thread, and each of it can
pile up multiple of them. Even if we assume that typical threads will
not queue those for long and will not wait for many of them, the fact
that the system-wide(!) number of threads is a scaling factor and the
pool is system-wide as well makes me wonder if __SIGPOOL_SIZE shouldn't
become a tunable.

BTW, I think we are leaking pending signals on thread destruction.
Currently writing a test case, and I already have a fix candidate at hand.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

