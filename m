Message-ID: <43BF9A0A.9090003@domain.hid>
Date: Sat, 07 Jan 2006 12:38:02 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Fix ppc fpu support
References: <43BEBA0D.5090708@domain.hid> <43BEBDC4.3020905@domain.hid>
In-Reply-To: <43BEBDC4.3020905@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka kirjoitti:
> Heikki Lindholm wrote:
> 
>>Xenomai might preempt linux when linux has cleared a tasks MSR_FP, but
>>not yet set last_task_used_math to NULL. As a result the tasks MSR_FP
>>will get set, although it should be cleared. If the task happens to hit
>>one of the codepaths that save FPU state if MSR_FP is set, the wrong FPU
>>state might be saved to the task. The attached patch should fix this. I
>>couldn't try it on most recent Xenomai trunk, because latency wouldn't
>>build anymore. However, I see no reason it shouldn't work. All thee
> 
> 
> Is it still broken with latest revision 376? Philippe had merged the fix
> for my mess, and it worked at least for 2.6 on my box again.

Just tried. At least svn r380 compiled and worked fine for me.

-- Heikki Lindholm

