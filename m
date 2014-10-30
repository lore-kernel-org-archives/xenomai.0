Message-ID: <5451FFA4.5030805@ma-info.de>
Date: Thu, 30 Oct 2014 10:06:44 +0100
From: Frede Florian <florian.frede@ma-info.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] i-Pipi patch 3.14
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I tried to patch the Kernel 3.14.22 and there is two new lines in the 
file fs/exec.c

tsk->mm->vmacache_seqnum = 0;
vmacache_flush(tsk);

I am not sure if the line from the iPipe patch should placed before or 
after this lines...

+    ipipe_mm_switch_unprotect(flags);

Thanks Florian

