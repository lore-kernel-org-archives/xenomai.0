From: =?iso-8859-1?Q?Andr=E9_Tousch?= <andre.tousch@domain.hid>
Date: Tue, 19 Oct 2004 15:10:34 +0200
Message-ID: <008b01c4b5dd$04d20890$7405a8c0@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1097614490.672.6.camel@domain.hid>
Subject: [Adeos-main] __adeos_handle_event
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

Hi,

I'm currently using Adeos 2.4/armnommu to run an RTOS with Linux.=20
It works well but I have a problem with events.
I use __adeos_handle_event(ADEOS_USER_EVENT, &event) to send information
from Linux to the RTOS.
Reciprocally, I use adeos_propagate_irq(IRQ_A) to send information from
the RTOS to Linux.
Now I have the following scenario: Linux sends an event to the RTOS,
which replies from the event handler by propagating an IRQ.=20

1) Linux does __adeos_handle_event(ADEOS_USER_EVENT). Domain switches to
RTOS
2) RTOS handles the event. It adeos_propagate_irq()'s to Linux.
3) RTOS does adeos_suspend_domain(). Domain switches back to Linux.
4) Linux runs from just after the context switch in
__adeos_handle_event(). No __adeos_sync_stage() is made, and the IRQ_A
handler is not called before next hardware IRQ.

Why is there no call to __adeos_sync_stage() in __adeos_handle_event()?=20
Or do I miss something?
Thanks for you support

Regards,
Andr=E9 Tousch


