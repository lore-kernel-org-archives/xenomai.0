Message-ID: <41B974E9.7080801@domain.hid>
Date: Fri, 10 Dec 2004 11:05:29 +0100
From: Andre Tousch <andre.tousch@domain.hid>
MIME-Version: 1.0
References: <008b01c4b5dd$04d20890$7405a8c0@domain.hid>	 <1098196627.666.9.camel@domain.hid> <1098196994.666.11.camel@domain.hid>
In-Reply-To: <1098196994.666.11.camel@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Adeos-main] End of interrupt scheduling
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

I'm currently using an RTOS with Linux/Adeos on ARM. The original=20
behaviour of the RTOS interrupt handler is:

- Lock interrupts
- Call high-level interrupt handler
- Unlock interrupts
- Schedule()

Adeos behaviour on sync_stage is:
- Stall domain
- Call interrupt handler
-  Unstall Domain

If I want to imitate the original RTOS behaviour, I have to schedule=20
(RTOS scheduler) at end of interrupt.
I cannot do that in this domain's interrupt handler, since it would=20
Schedule() with domain stalled, and thus the domain would not receive=20
the interrupts until it gives control back to Adeos by suspending itself.
So the only way I've found to do that was to had a hook in Adeos which=20
would be called at sync_stage, just after interrupt handler call.
Thus the modified Adeos behaviour on sync_stage is:

- Stall domain
- Call interrupt handler
-  Unstall Domain
- Call EndOfInterrupt Handler.

Now I have exactly the behaviour expected from my RTOS.

My question is, was there already a way to obtain this behaviour in Adeos?

Best regards,
Andr=E9

