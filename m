Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B7DC07C.5@domain.hid>
Date: Thu, 18 Feb 2010 23:34:36 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <0C632A1C-3B64-462B-9892-380CB14F6AD8@domain.hid>
In-Reply-To: <0C632A1C-3B64-462B-9892-380CB14F6AD8@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] Analogy DIO speed
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: Peter Pastor Sampedro <pastorsa@domain.hid>, xenomai@xenomai.org

Hi,

Stefan Schaal wrote:
> Thanks to Alexis's Analogy development, digital I/O is possible with Xeno=
mai using National Instrument DAQs. While the basic DIO functionality works=
 in the most current xenomai-head, I am  wondering how to achieve maximal I=
/O speed with the 32 bit digital I/O sub-device on my NI6259 card.=20
>=20
> The options are
>=20
> 1) single acquisition with a4l_sync_dio()
> 2) instructions and instruction lists using a4l_snd_insnlist() and a4l_sn=
d_insn()
> 3) streaming acquisition with commands (e.g., a4l_snd_command() and relat=
ed functions)
>=20
> My question concerns how many 32-bit DIO instructions per second I
> should be able to achieve with the various options.
>=20
> For instance, option 1) seems to take about 5000 nanoseconds on my
> Ubuntu 8 core i386 computer (3Ghz processors).
> Is this normal? Or should it be faster?
>=20
> Option 2) seems to give me about 50% speed up, i.e., roughly 3500
> nanoseconds per DIO.

With a4l_sync_dio and/or instructions, you perform one ioctl for each
acquisition.

With instruction lists, you perform less syscalls but the count of
copies (user <-> kernel space) is the same.

So 3.5 =B5s for:
- switching from user to kernel space
- copying a little structure from user space
- calling the suitable insn_bits handler
- performing PCI I/O
- copying data back (few bytes) to user space
- switching back to user space
It is not that bad, no ? Does anybody have an accurate idea on the
duration of a common ioctl on such a powerful machine ?

Wasting 1.5 more =B5s in a4l_sync_dio() is annoying. You already have
noticed that a4l_sync_dio() is a wrapper function which
relies on the instruction ioctl. This function does not make any more
ioctl, it just computes some pointers.

>=20
> Would option 3) give me a massive speed up and get me closer to the
> 20Mhz processing power of the NI 6259 board?=20
Yes. Instead of making one syscall per acquisition, you would get a far
more sensible ratio. With a4l_mmap, you would even be able to save
copies from kernel space: instead of using a4l_async_read, your user
process would get direct access on the kernel buffer where PCI DMA shots
arrive.

I have some problems with
> implementing commands on my NI6259 so far.
Could you remind me what was the problem ?

>=20
> Thanks a lot for any help!
>=20
> -Stefan
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>=20
Alexis.

