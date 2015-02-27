Message-ID: <54F0CF9E.1040707@siemens.com>
Date: Fri, 27 Feb 2015 21:12:14 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [RFC] Consolidated exception prologue/epiloge for x86 and
	ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

just pushed a first implementation of the general model that I proposed
for exception handling. You can find it at

http://git.xenomai.org/ipipe-jki.git/log/?h=queues/trap-rework

I can also relay the patches to the list if desired.

Besides the issue that Gilles remarked, I found no further problems
while implementing and testing this approach on both x86-64 and ARMv7.

I also added support for hardware breakpoint handling on ARM at this
chance but I didn't test that particular path yet.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

