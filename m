From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Dovetail/x86 still broken /wrt exception fixups
Message-ID: <d38b6799-ed3e-f384-a70e-51c2d5170c73@siemens.com>
Date: Tue, 1 Jun 2021 23:24:51 +0200
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

we are leaking the inband stall state into user land when the kernel
takes a fixable exception in oob. The problem is either
cond_disable_irqs() or its (missing?) counterpart. Where is the stall
bit set in handle_page_fault->cond_disable_irqs supposed to be cleared
again?

I-pipe is fine in that regard, but it took us many years to get it into
that state - and it didn't have to deal with the impact of ca4c6a9858
("x86/traps: Make interrupt enable/disable symmetric in C code") anymore...

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

