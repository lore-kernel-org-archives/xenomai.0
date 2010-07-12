Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <5BACCC6E-A481-4953-ABAC-ACE3185E1A9C@usc.edu>
Date: Sun, 11 Jul 2010 23:12:59 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <3712D196-B8B5-430C-A5F5-189C77F76997@domain.hid>
References: <20100605211102.GB8097@domain.hid>
	<20100624224259.GA2800@domain.hid>
	<7FB1B9EA-EB7E-45A2-9C1F-D97916381AF3@domain.hid>
	<20100627103712.GA2565@domain.hid>
	<46F86785-737D-41F4-BC37-5DC5A4462039@domain.hid>
	<20100630134535.GA2849@domain.hid>
	<B09D50F0-3A7A-4501-8E96-C5E67AE11D19@domain.hid>
	<20100705214047.GB2444@domain.hid>
	<20100705220238.GC2444@domain.hid>
	<5A2DB1C3-C660-45BE-9743-716F63C11825@domain.hid>
	<20100709221733.GC10254@domain.hid>
	<5BACCC6E-A481-4953-ABAC-ACE3185E1A9C@usc.edu>
Subject: Re: [Xenomai-core] analogy - experimental branch
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: Peter Pastor Sampedro <pastorsa@domain.hid>, xenomai@xenomai.org

Hi Alexis,

  I guess I slowly understand that my clocking signal connected to =
scan_begin_arg has to come from an external DIO input, if scan_bigin_src =
=3D TRIG_EXT, and that the insn instruction is still needed to trigger =
the entire acquisition.=20

  Alternatively, would it be possible to use the internal clocking =
signals like=20

scan_bigin_src =3D TRIG_FOLLOW

or=20

scan_bigin_src =3D TRIG_TIMER


if I try any of these sources, I get an error -22, and dmesg reports:

[195882.321300] Analogy: a4l_check_cmddesc: scan_begin_src, trigger =
unsupported

Best wishes,

-STefan





On Jul 9, 2010, at 17:10, Stefan Schaal wrote:

> Hi Alexis,
>=20
>  thanks a lot for the clarification. Thus, scan_begin_arg is set to =
the digital line that I would like to use as a trigger. The triggering =
itself has to happen by flipping the bit on this specific digital line, =
e.g., using a4l_sync_dio() on this specific line? I assume that I do not =
need to re-wire anything on my board.
>=20
> In your cmd_bits.c code, you use the "a4l_insn_t insn" structure below =
for triggering, which is what I have to replace with a4l_sync_dio(), I =
guess?
>=20
> Best wishes,
>=20
> -Stefan
>=20
>=20
>=20
> On Jul 9, 2010, at 15:17, Alexis Berlemont wrote:
>=20
>> Stefan Schaal wrote:
>>> Hi Alexis,
>>>=20
>>> I conceptually understand what you are telling us, but I am bit =
confused how to implement your advice:
>>>=20
>>>> So, Stefan, here is a quick solution:
>>>>=20
>>>> if you have access to your board you can choose one of these =
signals
>>>> (in which a regular pulse is occuring) and you can modify =
accordingly
>>>> the field scan_begin_arg of the structure a4l_cmd_t in cmd_bits.c.=20=

>>>=20
>>> The data structures in question are:
>>>=20
>>> /* The command to send by default */
>>> a4l_cmd_t cmd =3D {
>>> 	.idx_subd =3D -1,
>>> 	.flags =3D 0,
>>> 	.start_src =3D TRIG_INT,
>>> 	.start_arg =3D 0,
>>> 	.scan_begin_src =3D TRIG_EXT,
>>> 	.scan_begin_arg =3D 0, /* in ns */
>>> 	.convert_src =3D TRIG_NOW,
>>> 	.convert_arg =3D 0, /* in ns */
>>> 	.scan_end_src =3D TRIG_COUNT,
>>> 	.scan_end_arg =3D 4,
>>> 	.stop_src =3D TRIG_NONE,
>>> 	.stop_arg =3D 0,
>>> 	.nb_chan =3D 4,
>>> 	.chan_descs =3D chans,
>>> };
>>>=20
>>> a4l_insn_t insn =3D {
>>> 	.type =3D A4L_INSN_INTTRIG,
>>> 	.idx_subd =3D -1,
>>> 	.data_size =3D 0,
>>> };
>>>=20
>>>=20
>>> Thus, I assume you mean that
>>>=20
>>> scan_begin_src =3D TRIG_EXT
>>>=20
>>> should be modified to one of the enum items below? Are all these
>>> timers automatically running, or do they need to be configured, too?
>>> Sorry, I am a bit at a loss how to proceed.
>>=20
>> Sorry for the delay.
>>=20
>> I was not clear enough. In fact, scan_begin_arg should be
>> modified. scan_begin_src indicates the type of trigger and
>> scan_begin_arg gives an associated argument. In our case, it is the
>> signal number. Sorry for the comment (/* in ns */) which is an
>> inappropriate copy-paste (as a matter of fact, it is the whole =
command
>> interface which is unsuitable but that's another topic).
>>=20
>>>=20
>>> Best wishes,
>>>=20
>>> -Stefan
>>>=20
>>>=20
>>> On Jul 5, 2010, at 15:02, Alexis Berlemont wrote:
>>>=20
>>>> Hi,
>>>>=20
>>>> Alexis Berlemont wrote:
>>>>> Hi,
>>>>>=20
>>>>> Stefan Schaal wrote:
>>>>>> Hi Alexis,
>>>>>>=20
>>>>>> thanks for the feedback. We have 32 bit DIO on subdevice #2, and =
I am not sure that there is anything special to be configured. I will =
check again. Feel free to log into our machine with the pwd I indicated =
to you some time ago. The computer is not used productively.
>>>>>>=20
>>>>>=20
>>>>> Sorry for answering late, I was unavailable.
>>>>>=20
>>>>> My question was: did you ensure that the digital line were =
properly
>>>>> modified after having launched cmd_bits ?=20
>>>>>=20
>>>>> As I said, the digital output system does not consume the data =
(now I
>>>>> am sure). I instrumetented the code and I found out that the mite
>>>>> copied about 8000 bytes from the RAM and filled the digital output
>>>>> FIFO. Then, the DO FIFO status register keeps on indicating the =
FIFO
>>>>> is full. Nothing happens, the digital output system does not =
retrieve
>>>>> data from the FIFO.
>>>>>=20
>>>>> I tried to find out why and I had a close look at the driver: I
>>>>> noticed that no sample clock was configured. The driver only =
proposes
>>>>> to use an external signal (from the digital system, so AI/AO =
clocks,
>>>>> counters, PFI, etc.) as sample clock. Unfortunately, I do not know
>>>>> which value corresponds to which clock source.
>>>>>=20
>>>>> I had a look a the DAQ documentation: unfortunately the M series
>>>>> digital system is different (the DAQ-STC document is not valid for
>>>>> this board). I tried to find the M series developer manual but it =
is
>>>>> unavailable according to the NI support. I found a document named
>>>>> mseries_registermap.doc in:=20
>>>>> http://digital.ni.com/express.nsf/bycode/exyv4w?opendocument
>>>>>=20
>>>>> Unfortunately, it does not tell how to configure the sample clock
>>>>> source (I know which register I have to fill, but I do not know =
which
>>>>> value to put so as to use AI clock, digital counters or PFI...)
>>>>>=20
>>>>> So, I am kind of stuck. I will proceed on looking for the missing
>>>>> pieces of information. Please, if anyone have the info (the =
mapping
>>>>> between the "CDO_Mode register" values and the sample clock =
source),
>>>>> do not hesitate to help us.
>>>>>=20
>>>>=20
>>>> Argh, I found it. I did not see an item in the url displayed above.
>>>>=20
>>>>=20
>>>> Here is an enum found in:
>>>> ftp://ftp.ni.com/support/daq/mhddk/examples/nimseries.zip
>>>>=20
>>>>    // Field Accessors (Compile-time selectable)
>>>>    typedef enum {
>>>>       kCDO_Update_Source_SelectGround            =3D 0,
>>>>       kCDO_Update_Source_SelectPFI0              =3D 1,
>>>>       kCDO_Update_Source_SelectPFI1              =3D 2,
>>>>       kCDO_Update_Source_SelectPFI2              =3D 3,
>>>>       kCDO_Update_Source_SelectPFI3              =3D 4,
>>>>       kCDO_Update_Source_SelectPFI4              =3D 5,
>>>>       kCDO_Update_Source_SelectPFI5              =3D 6,
>>>>       kCDO_Update_Source_SelectPFI6              =3D 7,
>>>>       kCDO_Update_Source_SelectPFI7              =3D 8,
>>>>       kCDO_Update_Source_SelectPFI8              =3D 9,
>>>>       kCDO_Update_Source_SelectPFI9              =3D 10,
>>>>       kCDO_Update_Source_SelectRTSI0             =3D 11,
>>>>       kCDO_Update_Source_SelectRTSI1             =3D 12,
>>>>       kCDO_Update_Source_SelectRTSI2             =3D 13,
>>>>       kCDO_Update_Source_SelectRTSI3             =3D 14,
>>>>       kCDO_Update_Source_SelectRTSI4             =3D 15,
>>>>       kCDO_Update_Source_SelectRTSI5             =3D 16,
>>>>       kCDO_Update_Source_SelectRTSI6             =3D 17,
>>>>       kCDO_Update_Source_SelectAI_Start          =3D 18,
>>>>       kCDO_Update_Source_SelectAI_Convert        =3D 19,
>>>>       kCDO_Update_Source_SelectPXI_Star_Trigger  =3D 20,
>>>>       kCDO_Update_Source_SelectPFI10             =3D 21,
>>>>       kCDO_Update_Source_SelectPFI11             =3D 22,
>>>>       kCDO_Update_Source_SelectPFI12             =3D 23,
>>>>       kCDO_Update_Source_SelectPFI13             =3D 24,
>>>>       kCDO_Update_Source_SelectPFI14             =3D 25,
>>>>       kCDO_Update_Source_SelectPFI15             =3D 26,
>>>>       kCDO_Update_Source_SelectRTSI7             =3D 27,
>>>>       kCDO_Update_Source_SelectG0_Out            =3D 28,
>>>>       kCDO_Update_Source_SelectG1_Out            =3D 29,
>>>>       kCDO_Update_Source_SelectAnalog_Trigger    =3D 30,
>>>>       kCDO_Update_Source_SelectAO_Update         =3D 31,
>>>>       kCDO_Update_Source_SelectFreq_Out          =3D 32,
>>>>       kCDO_Update_Source_SelectDIO_Change_Detect_Irq       =3D 33,
>>>>    } tCDO_Update_Source_Select;
>>>>=20
>>>> So, Stefan, here is a quick solution:
>>>>=20
>>>> if you have access to your board you can choose one of these =
signals
>>>> (in which a regular pulse is occuring) and you can modify =
accordingly
>>>> the field scan_begin_arg of the structure a4l_cmd_t in cmd_bits.c.=20=

>>>>=20
>>>>>=20
>>>>>> Best wishes,
>>>>>>=20
>>>>>> -Stefan
>>>>>>=20
>>>>>>=20
>>>>>> On Jun 30, 2010, at 15:45, Alexis Berlemont wrote:
>>>>>>=20
>>>>>>> Hi,
>>>>>>>=20
>>>>>>> Stefan Schaal wrote:
>>>>>>>> Hi Alexis,
>>>>>>>>=20
>>>>>>>> I did a reboot, ran my modified cmd_bits.c again one time.=20
>>>>>>>>=20
>>>>>>>> cat /proc/xenomai/irq  reports:
>>>>>>>>=20
>>>>>>>> IRQ         CPU0        CPU1        CPU2        CPU3        =
CPU4        CPU5        CPU6        CPU7
>>>>>>>> 56:           0           0           0           0           0 =
          0           0           0         Analogy device
>>>>>>>> 518:           0           1           1           1           =
1           1           1           1         [IPI]
>>>>>>>> 521:      626392      618020      618539      620274      =
617326      625008      622464      626300         [timer]
>>>>>>>> 522:           0           0           0           0           =
0           0           0           0         [critical sync]
>>>>>>>> 546:           0           0           0           0           =
0           0           0           0         [virtual]
>>>>>>>>=20
>>>>>>>=20
>>>>>>> I have not forgotten you. I am still stuck with your bug: The =
mite
>>>>>>> transfers the first 8000 bytes and after does nothing; no =
interrupt is
>>>>>>> generated by the mite so as to finally awake your application.=20=

>>>>>>>=20
>>>>>>> It seems like the data retrieved by the mite are not consumed by =
the
>>>>>>> board. Are you sure the digital output lines correspond to what =
you
>>>>>>> configured with cmd_bits ?=20
>>>>>>>=20
>>>>>>> I think the digital output is misconfigured. I am working on it.
>>>>>>>=20
>>>>>>>>=20
>>>>>>>> -Stefan
>>>>>>>>=20
>>>>>>>> On Jun 27, 2010, at 3:37, Alexis Berlemont wrote:
>>>>>>>>=20
>>>>>>>>> Hi,
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> Stefan Schaal wrote:
>>>>>>>>>> Hi Alexis,
>>>>>>>>>>=20
>>>>>>>>>> thanks so much for the new analogy software. Here are some =
first observations:
>>>>>>>>>>=20
>>>>>>>>>> 1) cmd_bits.c works fine on our NI6250 board
>>>>>>>>>>=20
>>>>>>>>>> 2) however, a slightly modified version hangs -- I appended =
my cmd_bits.c to this email. All what I added is a for loop around the =
a4l_async_write() and a4l_snd_insn() commands, i.e., I wanted to trigger =
a write repeatedly. Look for the "sschaal" comment in my modified =
cmd_bits.c .  After 32 iterations, cmd_bits hangs, no error messages in =
dmesg. Interesting, when I change your "trigger_threshold" variable from =
128 to 256, my loop runs for 16 iterations (other changes of the trigger =
threshold adjust the number of iterations I get in a similar way). Thus, =
it feels like there is a buffer which does not get reset after =
a4l_snd_insn() is called -- does this make sense?
>>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> Could you tell me if the mite triggered an interrupt ? Could =
you send
>>>>>>>>> a dump of cat /proc/xenomai/irq after having made the test =
program
>>>>>>>>> hang ?
>>>>>>>>>=20
>>>>>>>>> Many thanks,
>>>>>>>>>=20
>>>>>>>>>> Best wishes,
>>>>>>>>>>=20
>>>>>>>>>> -Stefan
>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> On Jun 24, 2010, at 15:43, Alexis Berlemont wrote:
>>>>>>>>>>=20
>>>>>>>>>>> Hi,
>>>>>>>>>>>=20
>>>>>>>>>>> Alexis Berlemont wrote:
>>>>>>>>>>>> Hi Stefan,
>>>>>>>>>>>>=20
>>>>>>>>>>>> Stefan Schaal wrote:
>>>>>>>>>>>>> Hi Alexis,
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> I was just wondering whether the new "experimental" branch =
in your git repository is something that can be tried already.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>=20
>>>>>>>>>>>> No. Not yet. This branch is aimed at temporarily holding =
the
>>>>>>>>>>>> corrections I am trying to do for the cmd_bits issue. It =
needs quite a
>>>>>>>>>>>> lot of work and I have not finished yet.=20
>>>>>>>>>>>>=20
>>>>>>>>>>>> If you have a look at the commits in this branch, we will =
see many
>>>>>>>>>>>> "(broken)".
>>>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> I just rebased the experimental branch into the branch =
analogy. So,
>>>>>>>>>>> starting from now, we should be able to properly use =
cmd_bits with a
>>>>>>>>>>> clone of my git repository.
>>>>>>>>>>>=20
>>>>>>>>>>> After having reworked the asynchronous buffer subsystem (and =
having
>>>>>>>>>>> fixed some oops in the NI driver and in the new code), =
cmd_bits can
>>>>>>>>>>> correctly communicate with the DIO subdevice.=20
>>>>>>>>>>>=20
>>>>>>>>>>> A command like "./cmd_bits 0xffff 0xffff" works on my
>>>>>>>>>>> board. Unfortunately, I have not done the necessary to check =
the
>>>>>>>>>>> digital output lines yet.
>>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>>>> Best wishes,
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> -Stefan
>>>>>>>>>>>>=20
>>>>>>>>>>>> --=20
>>>>>>>>>>>> Alexis.
>>>>>>>>>>>=20
>>>>>>>>>>> --=20
>>>>>>>>>>> Alexis.
>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D cmd_bits.c =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> --=20
>>>>>>>>> Alexis.
>>>>>>>>=20
>>>>>>>=20
>>>>>>> --=20
>>>>>>> Alexis.
>>>>>>=20
>>>>>=20
>>>>> --=20
>>>>> Alexis.
>>>>=20
>>>> --=20
>>>> Alexis.
>>>=20
>>=20
>> --=20
>> Alexis.
>=20
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


