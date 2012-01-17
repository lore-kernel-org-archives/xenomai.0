From: "Terry Fryar" <terry.fryar@domain.hid>
References: <9BF63BF19AC3441EB4E1567EB07B78A0@domain.hid>
	<4F14BF9B.6030706@domain.hid>
In-Reply-To: <4F14BF9B.6030706@domain.hid>
Date: Tue, 17 Jan 2012 10:25:31 -0600
Message-ID: <2F9F10CEA75644AA8CF542029C058C57@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Ok, on a falling edge irq, I'm using an RTDM driver and I'm down to 2.3uS,
which is quite an improvement.  However, it's still not fast enough...I need
to hit a window of about 500nS.  Any other suggestions?

I use the rtdm_irq_request to hook the ISR, and I set up the irq by hand
using mem mapping to directly access the registers on the beagle.  At this
point, I'm not sure where else to try and speed things up?

Thanks!


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
Sent: Monday, January 16, 2012 6:24 PM
To: Terry Fryar
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Xenomai IRQ question

On 01/17/2012 12:36 AM, Terry Fryar wrote:
> Using xenomai irq's in user mode on a beaglexm.  It appears that irq 
> latency is around 44 microseconds from the edge until the isr is 
> executed.  Is there any way to reduce the latency?  Already using 99 
> as the priority for the isr task.

Handle the irq in kernel mode using an RTDM driver.

-- 
                                                                Gilles.


