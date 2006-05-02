Message-ID: <6ee4c8380605012208xf8f9bb6p5eb542d8fb8da567@domain.hid>
Date: Tue, 2 May 2006 01:08:15 -0400
From: "Brian L." <bluczkie@domain.hid>
Sender: zorander@domain.hid
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-help] Xenomai in a VM
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

Has anyone tried running Xenomai inside a virtual machine (i.e. Qemu,
Parallels, VMWare, bochs, simics)? Is there any reason to expect this
to fail? In theory, the virtualization software should appear as a
vanilla x86 to the OS running inside of it, but I'd imagine xenomai
could potentially tweak bits of the cpu/architecture that are not as
supported by the virtualization software .

Of course, I wouldn't expect any real-time characteristics or
performance to speak of. This would be for development/testing only.

Thoughts?

