Message-ID: <3D0F0BA2.969434A3@domain.hid>
Date: Tue, 18 Jun 2002 10:29:54 +0000
From: Karim Yaghmour <karim@domain.hid>
Reply-To: karim@domain.hid
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: My first tests with adeos!!!
References: <20020618071723.91139.qmail@domain.hid>
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
To: mohan kumar <mohan_knb@domain.hid>
Cc: adeos-main@gna.org

Hello Mohan,

I've taken a summary look at the code and I think the following is
the problem:

mohan kumar wrote:
> ...
>     case 0:
>             adeos_control_irq(INT_NUM,0,IPIPE_PASS_MASK);
>             break;
> ...

I don't think that adeos_control_irq() will work like this alone.
Have a look at arch/i386/ipipe.c:ipipe_handle_irq(). Notice that
the setting of interrupt flags for the various domains is done
prior to any domain handler being called. By disabling the passing
of the interrupts in domain_entry() as you do, all subsequent
interrupts are not passed on. What you actually do with
adeos_control_irq() in the interrupt handler only influences the
next round of interrupts. Given the code in the interrupt handler,
however, I think that you should be making the following call if
you want the interrupts to propagate the next time they occur:
adeos_control_irq(INT_NUM,IPIPE_PASS_MASK,1);

If you disabled the interrupt passing and would still want to
propagate the IRQ down the ipipe, then have a look at the latest
code in the CVS by Philippe. Particularily, try using
adeos_propagate_irq() in your handler.

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@domain.hid
      Embedded and Real-Time Linux Expert
===================================================

