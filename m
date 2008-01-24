Message-ID: <4e0b9cb00801240505y77d71956w994e312be382f91b@domain.hid>
Date: Thu, 24 Jan 2008 14:05:06 +0100
From: "Remi Lefevre" <rlefevre@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-core] Some beginner technical questions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi, I try to really understand the Xenomai design & behavior and have
a few technical questions for which I can't find exact answers on
documentations or mailing list :

- What is the overhead of the Adeos/I-Pipe layer on non RT Linux tasks
(including linux kernel) ?
This surely depends on interrupts number, but perhaps some results on
a particular platform exist.

- When using RTnet, I understand that non RT Linux tasks uses a
virtual network device linked to the RTnet one, so what performance
impact does this have on non RT network bandwidth ?

I saw on some introduction slides that an arinc 653 skin would be possible.
Emulating the arinc 653 is certainly possible, but if a real arinc 653
system is considered, this raises a few technical issues.
- Is the nucleus memory space protected from the Linux kernel (at
least in primary mode) ? If not, would this be possible ?
- It seems from what I understand that nucleus implements threads, but
not processes (like others RTOS), does this mean that they all share
the same memory space ?
- Can the nucleus kernel still run if the Linux kernel crashes (which
happens in ring 1 mode on x86 if I'm correct) ?
- Or more generally, what Linux kernel services are used by nucleus
(it seems at least the memory allocation ones) ?
- This is linked to the previous questions, but if we wanted to remove
everything from the Linux kernel that is not used by Xenomai, what
would be necessary to keep ?
- At last, is there a way to guaranty a worst case latency on Xenomai
(even a high one) supposing we know every hardware behavior (hum...) ?

I'm sorry if these questions are stupid or have been answered
previously, guiding me to the references would certainly greatly help
me in this case.

Best regards,
r=E9mi

