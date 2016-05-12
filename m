From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5734A9F8.10305@siemens.com>
Date: Thu, 12 May 2016 18:06:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] RTDM syscalls & switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Gilles,

regarding commit bec5d0dd42 (rtdm: make syscalls conforming rather than
current) - I remember a discussion on that topic, but I do not find its
traces any more. Do you have a pointer

In any case, I'm confronted with a use case for the old (Xenomai 2),
lazy switching behaviour: lightweight, performance sensitive IOCTL
services that can (and should) be called without any switching from both
domains.

What were the arguments in favour of migrating threads to real-time first?

I currently see the real need only for IOCTLs, but the question is then
if we shouldn't go back to "__xn_exec_current" in all RTDM cases to
avoid unwanted migration costs (which are significantly higher than
syscall restarts).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

