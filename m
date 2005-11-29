Message-ID: <438C5316.70204@domain.hid>
Date: Tue, 29 Nov 2005 14:09:42 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] rt_intr_enable() requierd after rt_intr_create
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

I noticed that when an interrupt object is created using
rt_intr_create(), it is created disabled, and a call to rt_intr_enable()
is necessary for the ISR to be called.

Question is: is this the expected behaviour?. If so, I think this should
be mentioned somewhere in the rt_intr_create documentation. In fact,
from reading the docs one could infer the opposite.

On a related issue, I noticed that the rt_intr_enable() documentation says:

"Enables the hardware interrupt line associated with an interrupt
object. Over Adeos-based systems which mask and acknowledge IRQs upon
receipt, this operation is necessary to revalidate the interrupt channel
so that more interrupts from the same source can be notified."

Is this correct?. I ask because the rt_intr_create() documentation tells
you to just return RT_INTR_ENABLE from the ISR if you want this. It's
confusing.


Nacho.

