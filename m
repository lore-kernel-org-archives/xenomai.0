From: "Reitinger, Peter" <preitinger@carl-valentin.de>
Date: Wed, 27 Aug 2014 07:48:39 +0000
Message-ID: <860f4c66b4b34363a35ca81ac139eaba@CVEX13.valentin-carl.de>
References: <mailman.981.1409108395.5713.xenomai@xenomai.org>
In-Reply-To: <mailman.981.1409108395.5713.xenomai@xenomai.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] SPI tx underflow interrupt not available
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/26/2014 04:24 PM, Reitinger, Peter wrote:=0A=
> Dear Xenomai people,=0A=
>=0A=
>=0A=
> I am currently trying to write an SPI slave rtdm driver with fifo and dma=
 support. I would like to receive an interrupt if there is an underflow in =
the tx fifo.=0A=
>=0A=
> Therefore I try to request the related hardware interrupt (which is irq 1=
25 at my emtrion board which has EDMA and 2 McSPI interfaces where I am try=
ing McSPI1).=0A=
=0A=
Are you sure the irq number is 125? If 125 is a "physical" irq number,=0A=
it is almost probably not the number you should pass to=0A=
rtdm_irq_request. Have you tried requesting it as a Linux interrupt?=0A=
=0A=
=0A=
=0A=
>=0A=
> Unfortunately it seems that interrupt 125 is reserved by another linux=0A=
driver because a list of /proc/irq/125 shows:=0A=
>=0A=
> root@dimm-am335x:/proc# ls /proc/irq/125=0A=
> 53100000.sham  spurious=0A=
=0A=
Have you tried grepping "sham" in the kernel sources?=0A=
=0A=
No, I am absolutely unsure if 125 is the right number because I am relative=
ly new in programming interrupts in the kernel. So I feel I have to read a =
lot about interrupts in linux? So I have to combine original linux kernel f=
unction calls and xenomai function calls to get interrupts working? Sorry t=
hat I have so few experience there... If you have a quick help in mind even=
 though it is not directly related to Xenomai, you would help me a lot... :=
-/=0A=
=0A=
Thx, I will try to grep for sham. I am afraid there might be a lot of hits.=
..=0A=
=0A=
Kind Regards,=0A=
Peter Reitinger=

