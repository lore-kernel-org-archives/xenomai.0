Message-ID: <8B7A6B1DF7564DEE89CE7EEEDA46D421@itd274>
From: "Rajeshkumar R" <rajesh.ramasamy@industeqsite.com>
Date: Fri, 13 Dec 2013 09:26:30 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] PCI-MSI interrupt handling Issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

We are using MPC8641D processor (arch - powerpc) in our module. Our issue i=
s MSI interrupt didn't handled in xenomai.
We have the XMC module, this is the source of the MSI interrupt. This XMC M=
SI interrupt directly given to Processor.=20
We are using the linux kernel (2.6.30) with xenomai patched (adeos-ipipe-2.=
6.70).

For XMC module, we have the separate device driver implemented in xenomai.=
=20
We are registering the ISR using 'rtdm_irq_request'. The ISR is not
invoked when interrupt occurs, but in kernel '__ipipe_grab_irq' function is=
=20
invoked.

If the XMC module device driver is linux ('request_irq' is used to register=
=20
the ISR), then the interrupt is coming, the ISR is invoked.

Please clarify.


Thanks & Regards,
Rajeshkumar.R,
Software Engineer,
Indus Teqsite Pvt Ltd,
Chennai - India.
**************** CAUTION - Disclaimer *****************This email may conta=
in confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention, distribu=
tion or disclosure by others is strictly prohibited. If you are not the int=
ended recipient (or authorized to receive for the recipient), please contac=
t the sender by reply email and delete all copies of this message. Also, em=
ail is susceptible to data corruption, interception, tampering, unauthorize=
d amendment and viruses. We only send and receive emails on the basis that =
we are not liable for any such corruption, interception, tampering, amendme=
nt or viruses or any consequence thereof.=20
*********** End of Disclaimer ***********DataPatterns ITS Group**********

