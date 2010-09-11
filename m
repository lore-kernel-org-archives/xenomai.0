Message-ID: <4C8BE5E0.7050808@domain.hid>
Date: Sat, 11 Sep 2010 22:26:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7301cc886b22b37fcbc8cda61c515d07.squirrel@domain.hid>
In-Reply-To: <7301cc886b22b37fcbc8cda61c515d07.squirrel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Bottom half task scheduling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: tstratman@domain.hid
Cc: xenomai@xenomai.org

Travis Stratman wrote:
> Hello,
> 
> I am writing a Xenomai driver with an interrupt that must trigger a
> complex series of hardware accesses that may not be atomic (i.e. waiting
> for DMA to complete). I'd like to move this section to a bottom half. In a
> Linux driver I would use a workqueue but I haven't been able to determine
> what the preferred method would be in Xenomai. All of the task creation
> API that I have considered cannot be called from an interrupt handler as
> they may reschedule.
> 
> Can anyone point me to some documentation or example that covers this? Any
> pointers would be appreciated.

You can use a kernel thread, created with rtdm_task_init:
http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__rtdmtask.html#g44b0701b6c28fa8035711f800fdcd371

-- 
                                                                Gilles.

