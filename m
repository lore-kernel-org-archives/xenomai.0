Message-ID: <2F8EE677D406514ABE53EF9C0934A666042ABE27@domain.hid>
From: Laurent.POYART@fr.thalesgroup.com
Date: Wed, 30 Jan 2008 11:38:22 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Xenomai-help] Understanding rtdm_lock_get
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi, 

Looking at the xenomai documentation, I saw that the rtdm_lock_get function
can be used in an interrupt service routine. 
This function seems to be base on spinlocks but in my mind, spinlock under
linux on the single CPU doesn't do anything (am I right?). Then I don't
really understand, how the lock mechanism works when there is a race
condition between the rtdm_lock_get in ISR and the rtdm_lock_get_irqsave
function used in an ioctl. Would it be possible to explain me briefly what
is doing rtdm_lock_get on the lock parameter in a single CPU context?

Complementary question:
does rtdm_lock_get_irqsave disables all interrupts?

Thanks in advance.
L.Poyart.

