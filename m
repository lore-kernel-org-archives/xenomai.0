Date: Mon, 27 Dec 2021 19:50:58 +0100 (CET)
From: g.strobbe@telenet.be
Message-ID: <1478129695.36513090.1640631058240.JavaMail.zimbra@telenet.be>
Subject: v5.15-dovetail-rebase compilation fails
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi all,

The compilation of file xenomai/kernel/cobalt/debug.c 
in branch v5.15-dovetail-rebase failed.
The problem is that since kernel vanilla v15.5 
include/linux/mm.h no longer defines VM_DENYWRITE

It is still used in xndebug_trace_relax()

		/*
		 * Hack. Unlike DSOs, executables and interpreters
		 * (e.g. dynamic linkers) are protected against write
		 * attempts. Use this to determine when $pc should be
		 * fixed up by subtracting the mapping base address in
		 * the DSO case.
		 */
		if (!(vma->vm_flags & VM_DENYWRITE))
			pc -= vma->vm_start;

Best regards,

Gino 
			

