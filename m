From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <065A7D06F7D4E546A18E80E08D066E181189D54CB2@domain.hid>
References: <065A7D06F7D4E546A18E80E08D066E181189D54CB2@domain.hid>
Content-Type: text/plain
Date: Thu, 21 May 2009 12:25:47 +0200
Message-Id: <1242901547.22988.19.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai interferes with ethernet, crashes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, 2009-05-21 at 13:00 +0300, Landau, Bracha wrote:
> That's interesting - we had an older version of it (2.2.4) working  on a Linux 2.6.14 platform.
> 

Changes happen between kernel versions. The only 82xx-based system I
ever ported Xenomai to was Freescale's mpc8240 Sandpoint, and I don't
recall that anyone has ever contributed anything else in that area.

> According to http://www.xenomai.org/index.php/FAQs the PQII family is supported.


PQII Pro - mpc83xx

> 
> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: Thursday, May 21, 2009 12:38 PM
> To: Landau, Bracha
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] xenomai interferes with ethernet, crashes
> 
> On Thu, 2009-05-21 at 10:55 +0300, Landau, Bracha wrote:
> > I am using a Xenomai-patched kernel on an MPC8272-based board.
> >
> > When I run the plain kernel without activatine either Xenomai or
> > CONFIG_IPIPE, the network interface works fine; I am able to ping
> > other nodes on the network.
> >
> > When I activate Xenomai, I don't get a reponse to ping (though I do
> > see transmission of packets on the network), and evenetually the
> > kernel crashes with the following (This phenomenon happens even when
> > Xenomai is not active, but CONFIG_IPIPE is active)
> 
> Xenomai never got ported to that platform, so the interrupt pipeline is likely not working at all for your board.
> 
> --
> Philippe.
> 
> 
> 
> This e-mail is confidential, the property of NDS Ltd and intended for the addressee only. Any dissemination, copying or distribution of this message or any attachments by anyone other than the intended recipient is strictly prohibited. If you have received this message in error, please immediately notify the postmaster@domain.hid and destroy the original message. Messages sent to and from NDS may be monitored. NDS cannot guarantee any message delivery method is secure or error-free. Information could be intercepted, corrupted, lost, destroyed, arrive late or incomplete, or contain viruses. We do not accept responsibility for any errors or omissions in this message and/or attachment that arise as a result of transmission. You should carry out your own virus checks before opening any attachment. Any views or opinions presented are solely those of the author and do not necessarily represent those of NDS.
> 
> To protect the environment please do not print this e-mail unless necessary.
> 
> NDS Limited Registered Office: One London Road, Staines,Middlesex TW18 4EX, United Kingdom. A company registered in England and Wales Registered no. 3080780 VAT no. GB 603 8808 40-00
-- 
Philippe.



