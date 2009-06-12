Message-ID: <4A3253DB.5040109@domain.hid>
Date: Fri, 12 Jun 2009 15:10:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <634c78ce0906120240t694ded8cpfa7fcd9dfb2c3b8@domain.hid>	<200906121148.37732.smolorz@domain.hid>
	<4A3235BF.5090201@domain.hid> <4A324D3D.9060505@domain.hid>
	<4A325189.5060905@domain.hid>
In-Reply-To: <4A325189.5060905@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Running Xenomai in a virtual machine
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Visser <johan.visser@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> ... You could still use qemu in
> emulation mode, but that is 10..40 times slower than native (but still
> better than nothing if you have to debug the guest kernel - I've done
> this before kvm arrived).

BTW, another advantage of qemu is that you could write a model of your
possibly non-standard I/O hardware and even run your drivers in qemu
against this model. That works both with and without kvm support.

And as we are at it: qemu (in emulation mode) is also capable of
providing a host for ARM, PPC, MIPS, etc. targets. An example: I'm able
to run the unmodified Linux firmware of my ARM-based webradio inside
qemu, and it works as in real life (it just boots faster in qemu than on
real silicon ;)).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

