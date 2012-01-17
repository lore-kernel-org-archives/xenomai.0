Message-ID: <4F14BF9B.6030706@domain.hid>
Date: Tue, 17 Jan 2012 01:23:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <9BF63BF19AC3441EB4E1567EB07B78A0@domain.hid>
In-Reply-To: <9BF63BF19AC3441EB4E1567EB07B78A0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai IRQ question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Terry Fryar <terry.fryar@domain.hid>
Cc: xenomai@xenomai.org

On 01/17/2012 12:36 AM, Terry Fryar wrote:
> Using xenomai irq's in user mode on a beaglexm.  It appears that irq latency
> is around 44 microseconds from the edge until the isr is executed.  Is there
> any way to reduce the latency?  Already using 99 as the priority for the isr
> task.

Handle the irq in kernel mode using an RTDM driver.

-- 
                                                                Gilles.

