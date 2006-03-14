From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17430.50430.76997.550310@domain.hid>
Date: Tue, 14 Mar 2006 14:28:30 +0100
Subject: Re: [Xenomai-help] interrupt wait problem
In-Reply-To: <44168DA0.3090506@domain.hid>
References: <44168DA0.3090506@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: marcellin <marcellin.fotze@domain.hid>
Cc: xenomai@xenomai.org

marcellin wrote:
 > 
 > 
 > Hi, i'm trying to use the RealTimeClock IRQ 8, with a xenomai real time 
 > task. I configure the RTC to have a periodic interrupt on it with the 
 > linux standard API, and it works. After when i want to catch the IRQ 8 
 > in a xenomai real time task i have a problem a error ( " Operation not 
 > permitted ") with the " rt_intr_wait " fonction. Is there a special 
 > initialisation or configuration to make with the kernel or Xenomai ?

As mentioned by Jan, rt_intr_wait() and generally every service which
block its caller may only be called from a real-time task, i.e. a task
created with rt_task_create() or made real-time with rt_task_shadow().

Also note that Xenomai system timer allow high frequency periodic
tasks without resorting to the RTC, see rt_task_set_periodic() and
rt_task_wait_period() services.

-- 


					    Gilles Chanteperdrix.

