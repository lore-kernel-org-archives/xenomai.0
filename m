Message-ID: <43BFF955.7010205@domain.hid>
Date: Sat, 07 Jan 2006 19:24:37 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Fix ppc fpu support
References: <43BEBA0D.5090708@domain.hid> <43BFC344.2030907@domain.hid>
In-Reply-To: <43BFC344.2030907@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum kirjoitti:
> Heikki Lindholm wrote:
> 
>> Xenomai might preempt linux when linux has cleared a tasks MSR_FP, but 
>> not yet set last_task_used_math to NULL. As a result the tasks MSR_FP 
>> will get set, although it should be cleared. If the task happens to 
>> hit one of the codepaths that save FPU state if MSR_FP is set, the 
>> wrong FPU state might be saved to the task. The attached patch should 
>> fix this. I couldn't try it on most recent Xenomai trunk, because 
>> latency wouldn't build anymore. However, I see no reason it shouldn't 
>> work. All thee having trouble with X and Xenomai, give this a shot.
>>
> 
> Merged in r383, thanks.

On a related note, how do you think patches to Linux kernel that don't 
fit into I-pipe should be handled? Put into patches directory 
separately? There are now at least two instances for 2.6.14/ppc: the fpu 
bug that I already posted on this thread and the ppc64 UP building bug 
that effectively makes impossible to build I-pipe 2.6.14 for UP on ppc64.

-- Heikki Lindholm

