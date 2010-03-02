Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <4B8B092E.1070104@domain.hid>
Date: Tue, 2 Mar 2010 10:00:30 -0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F095F5B-0A5E-40D2-AC8E-F99034E9571A@usc.edu>
References: <0C632A1C-3B64-462B-9892-380CB14F6AD8@domain.hid> <4B7DC07C.5@domain.hid>
	<6D7DAD32-5300-47EB-9A04-ECA065395014@domain.hid>
	<4B84634F.4080606@domain.hid> <4B8B092E.1070104@domain.hid>
Subject: Re: [Xenomai-core] Analogy DIO speed
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: Peter Pastor Sampedro <pastorsa@domain.hid>, xenomai@xenomai.org

Hi Alexis,

 we pulled your analogy branch, and now cmd_write works. Great, and =
thanks a lot! Next, I tried to use commands with the digital IO =
subdevice on our board (subdevice #2), but the get an error message:


[ 2482.771913] Analogy: a4l_check_cmddesc: scan_begin_src, trigger =
unsupported


Is there just missing support for the DIO subdevices using commands?

Best wishes,

-Stefan


ps.: feel free to use our machine for debugging -- it now has the latest =
version of your software installed with linux kernel 2.6.29.5.





On Feb 28, 2010, at 16:24, Alexis Berlemont wrote:

> Alexis Berlemont wrote:
>> Hi,
>> Stefan Schaal wrote:
>>> Hi Alexis,
>>>=20
>>> On Feb 18, 2010, at 14:34, Alexis Berlemont wrote:
>>>=20
>>>> I have some problems with
>>>>> implementing commands on my NI6259 so far.
>>>> Could you remind me what was the problem ?
>>>=20
>>> See the print-outs below for the problem we have.
>>>=20
>>> Thanks so much for looking into this!
>>>=20
>>> -Stefan
>>>=20
>>>=20
>>>=20
>>>=20
>>> Using the cmd_write() function that you provide in analogy, we get =
the following problem:
>>>=20
>> I am currently trying to fix this bug, which is not that easy. I just
>> have one question (that I remember I have already asked you in some =
way,
>> but I just want to be sure):
>> Does this bug occur the very first time you launched cmd_write (I =
mean
>> after a reboot) ?
>>=20
> I managed at last to fix the bug you were facing (at least I hope so).
> The problem was located in the trigger callback which waited for a
> bit-status (fifo half full) before going further; however, sometimes =
the
> DMA interrupt already occurred and cleaned everything behind your =
back.
>=20
> I have not made a pull request because the current implementation is =
not
> perfect.
>=20
> If you have some time, could you clone my git repository (branch:
> analogy) and check that a simple call to cmd_write does not trigger =
the
> bug anymore ?
>=20
> Many thanks.
>>> root@domain.hid# ./cmd_write -v
>>> cmd_write: device analogy0 opened (fd=3D0)
>>> cmd_write: basic descriptor retrieved
>>>    subdevices count =3D 14
>>>    read subdevice index =3D 0
>>>    write subdevice index =3D 1
>>> cmd_write: complex descriptor retrieved
>>> cmd_write: channel 0
>>>    ranges count =3D 3
>>>    range's size =3D 16 (bits)
>>> cmd_write: channel 1
>>>    ranges count =3D 3
>>>    range's size =3D 16 (bits)
>>> cmd_write: scan size =3D 4
>>> cmd_write: size to write  =3D 400
>>> cmd_write: command successfully sent
>>> cmd_write: triggering failed (ret=3D-32)
>>>=20
>>> root@domain.hid# dmesg -c
>>> [133345.213865] Analogy: analogy_ni_pcimio: ni_mio_common: =
interrupt: b_status=3D0002 m1_status=3D80a80000
>>> [133345.332719] Analogy: analogy_ni_pcimio: ni_ao_wait_for_dma_load: =
timed out waiting for dma load<3>Analogy: a4l_do_special_insn: execution =
of the instruction failed (err=3D-32)
>>>=20
>>>=20
>>> Another problem we have is with the --mmap option:
>>>=20
>>> root@domain.hid# ./cmd_write -v =
--mmap
>>> cmd_write: device analogy0 opened (fd=3D0)
>>> cmd_write: basic descriptor retrieved
>>>    subdevices count =3D 14
>>>    read subdevice index =3D 0
>>>    write subdevice index =3D 1
>>> cmd_write: complex descriptor retrieved
>>> cmd_write: channel 0
>>>    ranges count =3D 3
>>>    range's size =3D 16 (bits)
>>> cmd_write: channel 1
>>>    ranges count =3D 3
>>>    range's size =3D 16 (bits)
>>> cmd_write: scan size =3D 4
>>> cmd_write: size to write  =3D 400
>>> cmd_write: buffer size =3D 65536 bytes
>>> cmd_write: a4l_mmap() failed (ret=3D-22)
>>>=20
>>>=20
>>> root@domain.hid# dmesg -c
>>> [133408.942998] Analogy: a4l_ioctl_mmap: mmap not allowed on this =
subdevice
>>>=20
>>>=20
>> Alexis.
> Alexis.
>=20


