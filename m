Message-ID: <db67beef0709261544q2e6e454wf07ccacd4f77f1e4@domain.hid>
Date: Thu, 27 Sep 2007 00:44:49 +0200
From: bite <anonimo.passante@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_12222_16587649.1190846689822"
Subject: [Xenomai-help] Shared interrupt :(
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

------=_Part_12222_16587649.1190846689822
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, this is my first post, I'm using Xenomai since a few days, I beg your
pardon if my question has already been answered.

My problem is not directly related to Xenomai, but it prevents me from using
Xenomai (as well as any other kind of realtime extension, I think).

The point is: I have a PCI axis control board and with Xenomai I can use it
well on some kind of hardware.

On a different machine, the irq of this board happens to be shared with an
usb irq, and I get lots of problems there. Erratic behaviour, pc hanging and
killed cats.

Things do not change if I include I_PROPAGATE in the interrupt mode flags.

I recompiled the kernel with IO_APIC and LOCAL_APIC set, but what happens
then is just that the conflicting interrupts both move together, hand in
hand, from the same irq 9 to the same irq 18 :) Shame!

Is there any known solution for this embarrassing problem? Somebody
suggested me to put the board in a different PCI slot, but unluckily I
cannot do so because of a geometric constraint.

Thank you in advance for any help or suggestion & best regards,

Bite

------=_Part_12222_16587649.1190846689822
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, this is my first post, I&#39;m using Xenomai since a few days, I beg your pardon if my question has already been answered.<br><br>My problem is not directly related to Xenomai, but it prevents me from using Xenomai (as well as any other kind of realtime extension, I think).
<br><br>The point is: I have a PCI axis control board and with Xenomai I can use it&nbsp; well on some kind of hardware.<br><br>On a different machine, the irq of this board happens to be shared with an usb irq, and I get lots of problems there. Erratic behaviour, pc hanging and killed cats.
<br><br>Things do not change if I include I_PROPAGATE in the interrupt mode flags.<br><br>I recompiled the kernel with IO_APIC and LOCAL_APIC set, but what happens then is just that the conflicting interrupts both move together, hand in hand, from the same irq 9 to the same irq 18 :) Shame!
<br><br>Is there any known solution for this embarrassing problem? Somebody suggested me to put the board in a different PCI slot, but unluckily I cannot do so because of a geometric constraint.<br><br>Thank you in advance for any help or suggestion &amp; best regards,
<br><br>Bite<br>

------=_Part_12222_16587649.1190846689822--

