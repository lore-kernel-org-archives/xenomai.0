MIME-Version: 1.0
Message-ID: <OF0F1E860F.DB83F5D7-ONC125716A.003692C5-C125716A.0039A20F@wavecom.fr>
From: Yann.LEPROVOST@wavecom.fr
Date: Wed, 10 May 2006 12:23:35 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 0039A20CC125716A_="
Subject: [Xenomai-core] Adeos timer interrupt  handling
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

Message en plusieurs parties au format MIME
--=_alternative 0039A20CC125716A_=
Content-Type: text/plain; charset="US-ASCII"

Hi all,

As I understand about adeos timer interrupt handling for the arch ARM 
integrator :
- the timer is acknowledged (clearing timer interrupt bit) if there is 
only one domain
- when many domains, timer interrupt bit is not cleared (I supposed to let 
other domains being aware of the timer interrupt)

Concerning the AT91RM9200 target, timer interrupt works in a slightly 
different way:
- the interrupt line is shared between all core peripherals (this include 
system timer but also memory controller, power management...)
- to detect if the IRQ comes really from the timer, I need to read the 
timer status register

The problem is that reading the timer status register automatically resets 
it, clearing any interrupt bit.
Whereas the timer interrupt bit is manually controlled in the integrator 
architecture, it seems that I can't do the same on the AT91RM9200 
architecture.

Can anybody confirm my understanding of the adeos timer interrupt handling 
?
If I'm right, then is there any other way to deal with the timer interrupt 
for the AT91RM9200 ?
Last question, where can I find documentation about adeos internal 
(description of functions, global variables, IRQ handling and so on) ?

Best regards

Yann Leprovost

--=_alternative 0039A20CC125716A_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi all,</font>
<br>
<br><font size=2 face="sans-serif">As I understand about adeos timer interrupt
handling for the arch ARM integrator :</font>
<br><font size=2 face="sans-serif">- the timer is acknowledged (clearing
timer interrupt bit) if there is only one domain</font>
<br><font size=2 face="sans-serif">- when many domains, timer interrupt
bit is not cleared (I supposed to let other domains being aware of the
timer interrupt)</font>
<br>
<br><font size=2 face="sans-serif">Concerning the AT91RM9200 target, timer
interrupt works in a slightly different way:</font>
<br><font size=2 face="sans-serif">- the interrupt line is shared between
all core peripherals (this include system timer but also memory controller,
power management...)</font>
<br><font size=2 face="sans-serif">- to detect if the IRQ comes really
from the timer, I need to read the timer status register</font>
<br>
<br><font size=2 face="sans-serif">The problem is that reading the timer
status register automatically resets it, clearing any interrupt bit.</font>
<br><font size=2 face="sans-serif">Whereas the timer interrupt bit is manually
controlled in the integrator architecture, it seems that I can't do the
same on the AT91RM9200 architecture.</font>
<br>
<br><font size=2 face="sans-serif">Can anybody confirm my understanding
of the adeos timer interrupt handling ?</font>
<br><font size=2 face="sans-serif">If I'm right, then is there any other
way to deal with the timer interrupt for the AT91RM9200 ?</font>
<br><font size=2 face="sans-serif">Last question, where can I find documentation
about adeos internal (description of functions, global variables, IRQ handling
and so on) ?</font>
<br>
<br><font size=2 face="sans-serif">Best regards</font>
<br>
<br><font size=2 face="sans-serif">Yann Leprovost</font>
<br>
--=_alternative 0039A20CC125716A_=--

