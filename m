From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <55AE3AAB.5070403@siemens.com>
Date: Tue, 21 Jul 2015 14:27:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai 3: comapt issues with RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

just a heads up, I'll try to address this later:

I received a report that include/rtdm/uapi/rtdm.h contains some data
structures that are used between the kernel and the userspace library
(so not directly by applications) and are not compatible with
32-on-64-bit (compat) scenarios. We should probably promote anything
that is longer on 64-bit to that size, unconditionally. As this affects
the ABI, it should be fixed before 3.0 release, ideally.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

