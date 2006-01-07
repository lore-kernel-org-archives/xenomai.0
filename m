Message-ID: <43BF9945.4030804@domain.hid>
Date: Sat, 07 Jan 2006 12:34:45 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Fix ppc fpu support
References: <43BEBA0D.5090708@domain.hid>
In-Reply-To: <43BEBA0D.5090708@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: xenomai@xenomai.org

Heikki Lindholm kirjoitti:
> Xenomai might preempt linux when linux has cleared a tasks MSR_FP, but 
> not yet set last_task_used_math to NULL. As a result the tasks MSR_FP 
> will get set, although it should be cleared. If the task happens to hit 
> one of the codepaths that save FPU state if MSR_FP is set, the wrong FPU 
> state might be saved to the task. The attached patch should fix this. I 
> couldn't try it on most recent Xenomai trunk, because latency wouldn't 
> build anymore. However, I see no reason it shouldn't work. All thee 
> having trouble with X and Xenomai, give this a shot.

Additionally, there's also a Linux bug, which might cause corruption in 
2.6.14 PREEMPT:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9f232a125bf86b0dae09f8ea4a0553535cf6b658

For solid performance that should also be applied on top of the I-pipe 
patch.

-- Heikki Lindholm

