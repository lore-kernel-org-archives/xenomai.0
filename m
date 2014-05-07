Message-ID: <536A9B5B.4060500@cantastic.org>
Date: Wed, 07 May 2014 22:45:15 +0200
From: Ralf Roesch <xenomai@cantastic.org>
MIME-Version: 1.0
References: <CAP=r9tPMi_paK7iEmeqHt6z_yHJ14xnHqxiLtrxpkSyazyBfDQ@mail.gmail.com>
In-Reply-To: <CAP=r9tPMi_paK7iEmeqHt6z_yHJ14xnHqxiLtrxpkSyazyBfDQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Testing on Freescale i.MX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

schrieb Paul S.:
> Hello there. I'm running Xenomai 2.6.3 on a developer board with imx6q, and
> it seems to work perfectly fine for me. I've used ipipe-gch.git from
> git.xenomai.org, then checked out to ipipe-3.0-imx6q branch, then I've had
> some rough time porting some board-specific code from my 3.0.36 kernel to
> 3.0.43 from that branch, but besides that everything seems to be working.
> I've run LinuxCNC on that, and now I'm stuck writing GPIO driver for
> LinuxCNC, but, again, besides that everything seems to be in order.
>
>
Paul, thanks a lot. What type of developer board do you use?
Which type of electrical interfaces do you provide for controlling CNC
(servo, stepper, field-bus, real-time Ethernet)?
Do you have some results of latency tests available?

Our company is also working in the motion control section for over 20
years now.
We mostly build "intelligent" controller cards (for example
http://www.rw-gmbh.de/gallery/3-mcu3100/detail/4-mcu3100).
Up to now we have built our CNC firmware based on an own built minimal
RTOS with very low latency (some few microseconds).
We currently check the possibility to switch over to an generic
available OS with real-time support.
The i.mx6 series processor has been selected because of scalability,
long term availability and PCIE root complex end endpoint support.
Our plan is to develop an intelligent PCIe card based on the i.mx6S/D/Q
for Linux and Windows hosts and also working as a standalone controller.
--
regards Ralf


