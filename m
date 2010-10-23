Date: Sat, 23 Oct 2010 17:26:24 +0100 (BST)
From: edward.robbins@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1287850862.74211776@domain.hid>
References: <1287845650.32319352@domain.hid> <4CC30152.6060208@domain.hid>
	<1287850862.74211776@domain.hid>
Message-ID: <1287851184.14497074@domain.hid>
Subject: Re: [Xenomai-help] Very high latencies under stress testing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Oh, and I got the SMI-enabled chipset found and SMI workaround enabled mess=
ages this time=0A=0AOn Saturday, 23 October, 2010 5:21pm, edward.robbins@domain.hid=
fordtechnologies.co.uk said:=0A=0A>>> So I guess I should add=0A>>>=0A>>> #=
define PCI_DEVICE_ID_INTEL_ICH9_9        0x2917=0A>>=0A>> The define exists=
 in include/linux/pci_ids.h as PCI_DEVICE_ID_INTEL_ICH9_1=0A>>=0A>> Adding =
it to xenoami/pci_ids.s is only useful if you are using an older=0A>> kerne=
l which has not got this define. 2.6.33 here has it.=0A>>=0A> =0A> Okay, I'=
m using 2.6.32, but it exists here too, don't know how I missed it.=0A> =0A=
> Just finished installing kernel.. booting now, ready to dohell ;)=0A> =0A=
> Edward=0A> =0A> =0A> _______________________________________________=0A> =
Xenomai-help mailing list=0A> Xenomai-help@domain.hid> https://mail.gna.org=
/listinfo/xenomai-help=0A> =0A


