Message-ID: <3D0F0CA1.C0EC9F50@domain.hid>
Date: Tue, 18 Jun 2002 10:34:09 +0000
From: Karim Yaghmour <karim@domain.hid>
Reply-To: karim@domain.hid
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: My first tests with adeos!!!
References: <20020618071723.91139.qmail@domain.hid> <3D0F0BA2.969434A3@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.mail.freesoftware.fsf.org>
List-Unsubscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.freesoftware.fsf.org/pipermail/adeos-main/>
To: mohan kumar <mohan_knb@domain.hid>, adeos-main@gna.org

Karim Yaghmour wrote:
> Given the code in the interrupt handler,
> however, I think that you should be making the following call if
> you want the interrupts to propagate the next time they occur:
> adeos_control_irq(INT_NUM,IPIPE_PASS_MASK,1);

My mistake. I mixed up the call's API. The original was OK:
adeos_control_irq(INT_NUM, 0 ,IPIPE_PASS_MASK);

The rest of the explanation still holds, however.

Karim

===================================================
                 Karim Yaghmour
               karim@domain.hid
      Embedded and Real-Time Linux Expert
===================================================

