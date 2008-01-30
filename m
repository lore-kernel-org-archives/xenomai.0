Message-ID: <47A06256.9020807@domain.hid>
Date: Wed, 30 Jan 2008 12:41:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2F8EE677D406514ABE53EF9C0934A666042ABE27@domain.hid>
In-Reply-To: <2F8EE677D406514ABE53EF9C0934A666042ABE27@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Understanding rtdm_lock_get
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Laurent.POYART@fr.thalesgroup.com
Cc: xenomai@xenomai.org

Laurent.POYART@fr.thalesgroup.com wrote:
> Hi, 
> 
> Looking at the xenomai documentation, I saw that the rtdm_lock_get function
> can be used in an interrupt service routine. 
> This function seems to be base on spinlocks but in my mind, spinlock under
> linux on the single CPU doesn't do anything (am I right?). Then I don't
> really understand, how the lock mechanism works when there is a race
> condition between the rtdm_lock_get in ISR and the rtdm_lock_get_irqsave
> function used in an ioctl. Would it be possible to explain me briefly what
> is doing rtdm_lock_get on the lock parameter in a single CPU context?

On UP, rtdm_lock_get/put are void (that's in contrast to Linux where
spin_lock also disables local preemption so that you can call it from
interruptible contexts without risking deadlocks).

> 
> Complementary question:
> does rtdm_lock_get_irqsave disables all interrupts?

Yes, it does (for the local CPU, of course).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

