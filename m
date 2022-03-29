Message-ID: <fd32e328-0cde-b6db-bb32-3c572efa2ee4@siemens.com>
Date: Tue, 29 Mar 2022 10:11:41 +0200
MIME-Version: 1.0
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: dovetail-5.10: build-breakage on ARM
Content-Type: text/plain; charset="UTF-8"
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

likely by accident: 5.10-dovetail-rebase lost disable_irq_if_pipelined /
enable_irq_if_pipelined macros. 5.16 was affected as well, 5.15 and 5.17
are not.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

