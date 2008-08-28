Message-ID: <48B67A99.9050301@domain.hid>
Date: Thu, 28 Aug 2008 12:14:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <131064.26848.qm@domain.hid>
In-Reply-To: <131064.26848.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Kernel 2.6.26 Hung With Xenomai 2.4.5
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: yasser_kashfi@domain.hid
Cc: xenomai@xenomai.org

Yasser Kashfi wrote:
> Hi
> I have a bad problem, please advise me if you have an solution.
> I worked with older xenomai on Linux kernel 2.6.17 from one year ago and do not have any problem. but now, I decide to install xenomai-2.4.5 with Linux kernel 2.6.24 or 2.6.25 or 2.6.26 on SUSE.
> after compile and install all things :), when boot the new kernel, I some times see the cursor stop flashing and kernel hung. another problem, when I run the my program (xenomai user space task ) see kernel oop and kernel panic :( .
> 
> I glad to see your comments.

The usual advices:
 - please provide your .config
 - try to check if the kernel also hangs when only the ipipe patch is
   applied and activated
 - use a serial console to capture any oopses you can get hold of, then
   post them

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

