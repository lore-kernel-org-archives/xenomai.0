Message-ID: <51090B3D.6030909@siemens.com>
Date: Wed, 30 Jan 2013 12:59:57 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] x86-64 FPU saving/restoring
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

can someone explain to me why we have to worry that fxsave64 or
fxrstor64 can fault on x86-64 (and i386's fxsave/fxrstor not)? And why
we ignore such faults then? git doesn't explain why that change was once
done. To my understanding, the target/source memory for the save/restore
is not located in user space. The kernel seems to carefully save/restore
only when pushing to/pulling from user space, e.g. during signal
handling or on ptrace.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

