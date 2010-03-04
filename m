MIME-Version: 1.0
Sender: alexis.berlemont@domain.hid
In-Reply-To: <7491EDBA-D5BA-4C37-8709-FE4F7B2E3225@domain.hid>
References: <0C632A1C-3B64-462B-9892-380CB14F6AD8@domain.hid> <4B7DC07C.5@domain.hid>
	<6D7DAD32-5300-47EB-9A04-ECA065395014@domain.hid>
	<4B84634F.4080606@domain.hid> <4B8B092E.1070104@domain.hid>
	<4F095F5B-0A5E-40D2-AC8E-F99034E9571A@usc.edu>
	<4B8EF7A3.2080500@domain.hid>
	<7491EDBA-D5BA-4C37-8709-FE4F7B2E3225@domain.hid>
Date: Thu, 4 Mar 2010 09:37:09 +0100
Message-ID: <72cf3fb1003040037p2333b93ai6a2c34a24ccc2c1c@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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

On Thu, Mar 4, 2010 at 1:54 AM, Stefan Schaal <sschaal@domain.hid> wrote:
> Hi Alexis,
>
> =A0thanks a lot or the reply. Just to check: is it possible to use comman=
ds with digital subdevices at all? I am not sure whether I understood your =
comment below correctly. Are your *currently* working to enable commands fo=
r DIO subdevices?
Commands are possible with DIO subdevices. The main problem is my test
application which does not handle all the cases.

>
> Thanks a lot!
>
> -Stefan
>
>
> On Mar 3, 2010, at 15:58, Alexis Berlemont wrote:
>
>> Hi Stefan,
>>
>> Sorry for the late reply, I was unavailable yesterday.
>>
>> Stefan Schaal wrote:
>>> Hi Alexis,
>>> we pulled your analogy branch, and now cmd_write works. Great, and than=
ks a lot! Next, I tried to use commands with the digital IO subdevice on ou=
r board (subdevice #2), but the get an error message:
>>> [ 2482.771913] Analogy: a4l_check_cmddesc: scan_begin_src, trigger unsu=
pported
>> Unfortunately, cmd_write was not designed to work with digital
>> subdevices; the command's fields are not appropriate, I am trying to
>> make it work quite quickly.
>>
>>> Is there just missing support for the DIO subdevices using commands?
>>> Best wishes,
>>> -Stefan
>>> ps.: feel free to use our machine for debugging -- it now has the lates=
t version of your software installed with linux kernel 2.6.29.5.
>>> On Feb 28, 2010, at 16:24, Alexis Berlemont wrote:
>>>> Alexis Berlemont wrote:
>>>>> Hi,
>>>>> Stefan Schaal wrote:
>>>>>> Hi Alexis,
>>>>>>
>>>>>> On Feb 18, 2010, at 14:34, Alexis Berlemont wrote:
>>>>>>
>>>>>>> I have some problems with
>>>>>>>> implementing commands on my NI6259 so far.
>>>>>>> Could you remind me what was the problem ?
>>>>>> See the print-outs below for the problem we have.
>>>>>>
>>>>>> Thanks so much for looking into this!
>>>>>>
>>>>>> -Stefan
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Using the cmd_write() function that you provide in analogy, we get t=
he following problem:
>>>>>>
>>>>> I am currently trying to fix this bug, which is not that easy. I just
>>>>> have one question (that I remember I have already asked you in some w=
ay,
>>>>> but I just want to be sure):
>>>>> Does this bug occur the very first time you launched cmd_write (I mea=
n
>>>>> after a reboot) ?
>>>>>
>>>> I managed at last to fix the bug you were facing (at least I hope so).
>>>> The problem was located in the trigger callback which waited for a
>>>> bit-status (fifo half full) before going further; however, sometimes t=
he
>>>> DMA interrupt already occurred and cleaned everything behind your back=
.
>>>>
>>>> I have not made a pull request because the current implementation is n=
ot
>>>> perfect.
>>>>
>>>> If you have some time, could you clone my git repository (branch:
>>>> analogy) and check that a simple call to cmd_write does not trigger th=
e
>>>> bug anymore ?
>>>>
>>>> Many thanks.
>>>>>> root@domain.hid# ./cmd_write -v
>>>>>> cmd_write: device analogy0 opened (fd=3D0)
>>>>>> cmd_write: basic descriptor retrieved
>>>>>> =A0 subdevices count =3D 14
>>>>>> =A0 read subdevice index =3D 0
>>>>>> =A0 write subdevice index =3D 1
>>>>>> cmd_write: complex descriptor retrieved
>>>>>> cmd_write: channel 0
>>>>>> =A0 ranges count =3D 3
>>>>>> =A0 range's size =3D 16 (bits)
>>>>>> cmd_write: channel 1
>>>>>> =A0 ranges count =3D 3
>>>>>> =A0 range's size =3D 16 (bits)
>>>>>> cmd_write: scan size =3D 4
>>>>>> cmd_write: size to write =A0=3D 400
>>>>>> cmd_write: command successfully sent
>>>>>> cmd_write: triggering failed (ret=3D-32)
>>>>>>
>>>>>> root@domain.hid# dmesg -c
>>>>>> [133345.213865] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt=
: b_status=3D0002 m1_status=3D80a80000
>>>>>> [133345.332719] Analogy: analogy_ni_pcimio: ni_ao_wait_for_dma_load:=
 timed out waiting for dma load<3>Analogy: a4l_do_special_insn: execution o=
f the instruction failed (err=3D-32)
>>>>>>
>>>>>>
>>>>>> Another problem we have is with the --mmap option:
>>>>>>
>>>>>> root@domain.hid# ./cmd_write -v --mm=
ap
>>>>>> cmd_write: device analogy0 opened (fd=3D0)
>>>>>> cmd_write: basic descriptor retrieved
>>>>>> =A0 subdevices count =3D 14
>>>>>> =A0 read subdevice index =3D 0
>>>>>> =A0 write subdevice index =3D 1
>>>>>> cmd_write: complex descriptor retrieved
>>>>>> cmd_write: channel 0
>>>>>> =A0 ranges count =3D 3
>>>>>> =A0 range's size =3D 16 (bits)
>>>>>> cmd_write: channel 1
>>>>>> =A0 ranges count =3D 3
>>>>>> =A0 range's size =3D 16 (bits)
>>>>>> cmd_write: scan size =3D 4
>>>>>> cmd_write: size to write =A0=3D 400
>>>>>> cmd_write: buffer size =3D 65536 bytes
>>>>>> cmd_write: a4l_mmap() failed (ret=3D-22)
>>>>>>
>>>>>>
>>>>>> root@domain.hid# dmesg -c
>>>>>> [133408.942998] Analogy: a4l_ioctl_mmap: mmap not allowed on this su=
bdevice
>>>>>>
>>>>>>
>>>>> Alexis.
>>>> Alexis.
>>>>
>> Alexis.
>>
>
>
>
Alexis.

