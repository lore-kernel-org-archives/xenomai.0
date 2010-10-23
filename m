Date: Sat, 23 Oct 2010 17:21:02 +0100 (BST)
From: edward.robbins@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4CC30152.6060208@domain.hid>
References: <1287845650.32319352@domain.hid> <4CC30152.6060208@domain.hid>
Message-ID: <1287850862.74211776@domain.hid>
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

>> So I guess I should add=0A>>=0A>> #define PCI_DEVICE_ID_INTEL_ICH9_9    =
    0x2917=0A> =0A> The define exists in include/linux/pci_ids.h as PCI_DEV=
ICE_ID_INTEL_ICH9_1=0A> =0A> Adding it to xenoami/pci_ids.s is only useful =
if you are using an older=0A> kernel which has not got this define. 2.6.33 =
here has it.=0A> =0A=0AOkay, I'm using 2.6.32, but it exists here too, don'=
t know how I missed it. =0A=0AJust finished installing kernel.. booting now=
, ready to dohell ;)=0A=0AEdward


