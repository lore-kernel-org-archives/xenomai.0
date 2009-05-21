From: "Landau, Bracha" <BLandau@domain.hid>
Date: Thu, 21 May 2009 13:00:38 +0300
Message-ID: <065A7D06F7D4E546A18E80E08D066E181189D54CB2@domain.hid>
In-Reply-To: <1242898684.18976.6.camel@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

That's interesting - we had an older version of it (2.2.4) working  on a Li=
nux 2.6.14 platform.

According to http://www.xenomai.org/index.php/FAQs the PQII family is suppo=
rted.

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org]
Sent: Thursday, May 21, 2009 12:38 PM
To: Landau, Bracha
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] xenomai interferes with ethernet, crashes

On Thu, 2009-05-21 at 10:55 +0300, Landau, Bracha wrote:
> I am using a Xenomai-patched kernel on an MPC8272-based board.
>
> When I run the plain kernel without activatine either Xenomai or
> CONFIG_IPIPE, the network interface works fine; I am able to ping
> other nodes on the network.
>
> When I activate Xenomai, I don't get a reponse to ping (though I do
> see transmission of packets on the network), and evenetually the
> kernel crashes with the following (This phenomenon happens even when
> Xenomai is not active, but CONFIG_IPIPE is active)

Xenomai never got ported to that platform, so the interrupt pipeline is lik=
ely not working at all for your board.

--
Philippe.



This e-mail is confidential, the property of NDS Ltd and intended for the a=
ddressee only. Any dissemination, copying or distribution of this message o=
r any attachments by anyone other than the intended recipient is strictly p=
rohibited. If you have received this message in error, please immediately n=
otify the postmaster@domain.hid and destroy the original message. Messages sen=
t to and from NDS may be monitored. NDS cannot guarantee any message delive=
ry method is secure or error-free. Information could be intercepted, corrup=
ted, lost, destroyed, arrive late or incomplete, or contain viruses. We do =
not accept responsibility for any errors or omissions in this message and/o=
r attachment that arise as a result of transmission. You should carry out y=
our own virus checks before opening any attachment. Any views or opinions p=
resented are solely those of the author and do not necessarily represent th=
ose of NDS.

To protect the environment please do not print this e-mail unless necessary=
.

NDS Limited Registered Office: One London Road, Staines,Middlesex TW18 4EX,=
 United Kingdom. A company registered in England and Wales Registered no. 3=
080780 VAT no. GB 603 8808 40-00

