Message-ID: <COL122-W637BE46C7D8B2CB7F79760BDB50@domain.hid>
Content-Type: multipart/alternative;
	boundary="_ba7a600b-e2ea-43f2-b0e0-ae08fd48455c_"
From: krishna m <krishnamurthyjs@domain.hid>
Date: Mon, 21 Mar 2011 18:18:52 +0530
In-Reply-To: <4D81C6AD.8050803@domain.hid>
References: <COL122-W1001B88CC08016B1C1774EBDCE0@domain.hid>
	<4D80BA8B.7050803@domain.hid>,<4D81C6AD.8050803@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] MSI support in Xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: jan.kiszka@domain.hid, gilles.chanteperdrix@xenomai.org, jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

--_ba7a600b-e2ea-43f2-b0e0-ae08fd48455c_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


> Date: Thu=2C 17 Mar 2011 09:30:37 +0100
> From: jan.kiszka@domain.hid
> To: gilles.chanteperdrix@xenomai.org krishnamurthyjs@domain.hid
> CC: xenomai@xenomai.org
> Subject: Re: MSI support in Xenomai
>=20
> On 2011-03-16 14:26=2C Gilles Chanteperdrix wrote:
> > krishna m wrote:
> >> Hi All=2C I wanted to know if the latest Xenomai [Version
> >> xenomai-2.5.6] supports MSI interrupts. I am using the adeos Patch
> >> [version adeos-ipipe-2.6.37-x86-2.9-00] and corresponding Linux
> >> kernel [version: linux-2.6.37]. I have read in the Xenomai FAQ that
> >> MSI is not supported by the ipipe patch just wanted to know if the
> >> latest Xenomai and Ipipe supports MSI.
> >=20
> > No.
>=20
> Strictly spoken=2C but it works in practice. See
>=20
> http://thread.gmane.org/gmane.linux.real-time.xenomai.users/12135
>=20
> Jan
>=20
> --=20
> Siemens AG=2C Corporate Technology=2C CT T DE IT 1
> Corporate Competence Center Embedded Linux
=20
Hi Jan=2C

Thanks for the reply. I got the following info from you post and i had few =
questions related to this post:
=20


>> - MSI[-X] usage for RTDM (ie. RT) drivers is basically fine as long as y=
ou avoid enabling/disabling from RT context (also used for quite a while he=
re=2C no known issues under this restriction)
=20
my question is are you mentioninig here that i must not be doing pci_enable=
_msi() and pci_disable_msi() inside the RTDM driver ? if not then where sho=
uld these calls be done ?=20
=20
Right now i have ported my standerd linux driver for the PCIe card to RTDM =
drvier. This driver uses MSI. I am not enabeling or disabling MSI or IRQ an=
y where in the driver while processing [i.e. in ISR or read/write]. I am en=
abeling MSI in the PCI Probe and disabeling it in the PCI remove functions.=
 The problem i am facing is as soon as i get the First MSI interrupt the ke=
rnel oops and i get the following dump:Mar 21 21:08:34 barch kernel: BUG: u=
nable to handle kernel paging request at 7f45402d
Mar 21 21:08:34 barch kernel: Oops: 0000 [#1] PREEMPT SMP=20

=20
 [note: The normal linux driver works with out any problem].=20
=20
Please let me know your thoughts. Also is there an example PCIe RTDM driver=
 using MSI that i can refer to understand more about this topic ?
=20
thanks=2C
krishna=20


 		 	   		  =

--_ba7a600b-e2ea-43f2-b0e0-ae08fd48455c_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style>
</head>
<body class=3D'hmmessage'>
&gt=3B Date: Thu=2C 17 Mar 2011 09:30:37 +0100<BR>&gt=3B From: jan.kiszka@domain.hid=
iemens.com<BR>&gt=3B To: gilles.chanteperdrix@xenomai.org krishnamurthyj=
s@domain.hid<BR>&gt=3B CC: xenomai@xenomai.org<BR>&gt=3B Subject: Re: MSI=
 support in Xenomai<BR>&gt=3B <BR>&gt=3B On 2011-03-16 14:26=2C Gilles Chan=
teperdrix wrote:<BR>&gt=3B &gt=3B krishna m wrote:<BR>&gt=3B &gt=3B&gt=3B H=
i All=2C I wanted to know if the latest Xenomai [Version<BR>&gt=3B &gt=3B&g=
t=3B xenomai-2.5.6] supports MSI interrupts. I am using the adeos Patch<BR>=
&gt=3B &gt=3B&gt=3B [version adeos-ipipe-2.6.37-x86-2.9-00] and correspondi=
ng Linux<BR>&gt=3B &gt=3B&gt=3B kernel [version: linux-2.6.37]. I have read=
 in the Xenomai FAQ that<BR>&gt=3B &gt=3B&gt=3B MSI is not supported by the=
 ipipe patch just wanted to know if the<BR>&gt=3B &gt=3B&gt=3B latest Xenom=
ai and Ipipe supports MSI.<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B No.<BR>&gt=3B=
 <BR>&gt=3B Strictly spoken=2C but it works in practice. See<BR>&gt=3B <BR>=
&gt=3B http://thread.gmane.org/gmane.linux.real-time.xenomai.users/12135<BR=
>&gt=3B <BR>&gt=3B Jan<BR>&gt=3B <BR>&gt=3B -- <BR>&gt=3B Siemens AG=2C Cor=
porate Technology=2C CT T DE IT 1<BR>&gt=3B Corporate Competence Center Emb=
edded Linux<BR>
&nbsp=3B<BR>
Hi Jan=2C<BR>
<BR>
Thanks for the reply. I got the following info from you post and i had few =
questions related to this post:<BR>
&nbsp=3B<BR>
<BR>
<BR>
&gt=3B&gt=3B - MSI[-X] usage for RTDM (ie. RT) drivers is basically fine as=
 long as you avoid enabling/disabling from RT context (also used for quite =
a while here=2C no known issues under this restriction)<BR>
&nbsp=3B<BR>
my question is are you mentioninig here that i must not be doing pci_enable=
_msi() and pci_disable_msi() inside the RTDM driver ? if not then where sho=
uld these calls be done ? <BR>
&nbsp=3B<BR>
Right now i have ported my standerd linux driver for the PCIe card to RTDM =
drvier. This driver uses&nbsp=3BMSI.&nbsp=3BI am not enabeling or disabling=
 MSI or IRQ any where in the driver while processing [i.e. in ISR or read/w=
rite]. I am enabeling MSI in the PCI Probe and disabeling it in the PCI rem=
ove functions. The problem i am facing is as soon as i get the First MSI in=
terrupt the kernel oops and i get the following dump:<BR><PRE class=3Dvscro=
ll><CODE>Mar 21 21:08:34 barch kernel: BUG: unable to handle kernel paging =
request at 7f45402d
Mar 21 21:08:34 barch kernel: Oops: 0000 [#1] PREEMPT SMP=20
</CODE></PRE>
&nbsp=3B<BR>
&nbsp=3B[note: The normal linux driver works with out any problem]. <BR>
&nbsp=3B<BR>
Please let me know your thoughts. Also is there an example PCIe RTDM driver=
 using MSI that i can refer to understand more about this topic ?<BR>
&nbsp=3B<BR>
thanks=2C<BR>
krishna <BR><BR><BR><BR> 		 	   		  </body>
</html>=

--_ba7a600b-e2ea-43f2-b0e0-ae08fd48455c_--

