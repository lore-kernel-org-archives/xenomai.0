Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <20100714210331.GC3246@domain.hid>
Date: Wed, 14 Jul 2010 17:46:54 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <373BD2C2-B474-4E1F-A46C-0C704E6C318B@usc.edu>
References: <B09D50F0-3A7A-4501-8E96-C5E67AE11D19@domain.hid>
	<20100705214047.GB2444@domain.hid>
	<20100705220238.GC2444@domain.hid>
	<5A2DB1C3-C660-45BE-9743-716F63C11825@domain.hid>
	<20100709221733.GC10254@domain.hid>
	<5BACCC6E-A481-4953-ABAC-ACE3185E1A9C@usc.edu>
	<3712D196-B8B5-430C-A5F5-189C77F76997@domain.hid>
	<20100712222926.GA2463@domain.hid>
	<F730DBD8-DEB8-4C64-BA65-19657D6EFA95@domain.hid>
	<4495E38D-134C-425D-B797-1174E8849E3F@usc.edu>
	<20100714210331.GC3246@domain.hid>
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

  in the Comedi examples =
(http://www.comedi.org/download/comedilib-0.8.1.tar.gz, the =
do_waveform.c example), they suggest to use a general purpose counter as =
clocking input to a cmd-based DIO acquisition. This seems to be the =
signal "kCDO_Update_Source_SelectG0_Out            =3D 28" from the enum =
you found in the NI documentation.

For this purpose, the counter needs to be configured and triggered. Does =
Analogy already have the functionality to do such operations? The Comedi =
libraries have an example for this, too, in gpct_pulse_generator.c, just =
that this example uses a variety of function calls that I cannot =
directly map to the current Analogy functionality.

Or, do you happen to know whether there is another, easier to access, =
clock source?

Best wishes,

-Stefan


On Jul 14, 2010, at 14:03, Alexis Berlemont wrote:

> Stefan Schaal wrote:
>> Hi Alexis,
>>=20
>>  maybe it is more useful to mention what I actually want to achieve =
with DIO on my NI6259.  My DIO communication involves a series of =
interactions with another board to collect sensory data from a robot, =
and to send out commands to this board. For instance, to read one of the =
sensors, a sequence of DIO values need to be written to tell the board =
to send the data. I programmed this initially with synchronous =
instructions using a4l_sync_dio(), but this turns out to be too slow. =
Thus, the hope is to use commands, i.e., fill the FIFO with the sequence =
of values which I need to execute, and then use asynchronous DIO to =
obtain much higher speed of communicating the values in the FIFO.
>>=20
>>   Thus, what I essentially try to do is to put about 10-20 scans in =
the FIFO, and then write the FIFO as fast as possible to my NI6259 DIO =
subdevice.
>>=20
>> Would you have any ideas how to do this fast writing of the scans in =
the FIFO with the current analogy functionality?
>>=20
> Right now, I don't know. I think your idea of using DIO commands may
> be suitable (I don't know your timing constraints). So what not
> proceeding ?
>=20
>> Thanks a lot!
>>=20
>> -Stefan
>>=20
>>=20
>> On Jul 12, 2010, at 22:51, Stefan Schaal wrote:
>>=20
>>> Hi Alexis,
>>>=20
>>> thanks a lot for the explanations. One item I am confused about is =
that you write that TRIG_TIMER is not suitable for DIO, but in =
cmd_write.c in your sample code, it is used for the analog write without =
problems. Wouldn't one be able to just use the same clock source for DIO =
as in analogue I/O?
>>>=20
>>> Best wishes,
>>>=20
>>> -Stefan
>>>=20
>>>=20
>>>=20
>>> On Jul 12, 2010, at 15:29, Alexis Berlemont wrote:
>>>=20
>>>> Hi,
>>>>=20
>>>> Stefan Schaal wrote:
>>>>> Hi Alexis,
>>>>>=20
>>>>> I guess I slowly understand that my clocking signal connected to
>>>>> scan_begin_arg has to come from an external DIO input, if
>>>>> scan_bigin_src =3D TRIG_EXT, and that the insn instruction is =
still
>>>>> needed to trigger the entire acquisition.=20
>>>>=20
>>>> Yes. The trigger instruction is needed so as to start the whole
>>>> acquisition (which is composed of many scans). A periodic external
>>>> signal is needed so as to trigger each scan.
>>>>=20
>>>>>=20
>>>>> Alternatively, would it be possible to use the internal clocking =
signals like=20
>>>>>=20
>>>>> scan_bigin_src =3D TRIG_FOLLOW
>>>>>=20
>>>>> or=20
>>>>>=20
>>>>> scan_bigin_src =3D TRIG_TIMER
>>>>=20
>>>> I think you are right. If the sampling clock comes from another
>>>> subdevice, TRIG_EXT may not be the most appropriate constant. =
However,
>>>> the original comedi driver only expects TRIG_EXT even if... the
>>>> sampling signal is not external.
>>>>=20
>>>> TRIG_TIMER does not seem suitable because it assumes an independant
>>>> sampling clock is available. =20
>>>>=20
>>>> And TRIG_FOLLOW may be the most appropriate one. We should modify =
the
>>>> driver so that TRIG_FOLLOW is used if the analog sampling clock is
>>>> chosen.
>>>>=20
>>>>>=20
>>>>>=20
>>>>> if I try any of these sources, I get an error -22, and dmesg =
reports:
>>>>>=20
>>>>> [195882.321300] Analogy: a4l_check_cmddesc: scan_begin_src, =
trigger unsupported
>>>>>=20
>>>>=20
>>>> For me, the command interface is an empty shell because the various
>>>> parameters (start_src, scan_begin_src, ...) and the values (TRIG_*)
>>>> are imposed. And, on the other side, the driver is fully in charge =
of
>>>> the command structure as it is. So, the comedi command imposes a
>>>> communication method but does not ease the driver's task of =
managing
>>>> it (errors checking, translation, etc.)
>>>>=20
>>>> And, in our case: DIO, we may conclude that this imposed API does =
not
>>>> fit well: in scan_begin_arg, we have to pass an index which is
>>>> supposed to correspond to some sampling clock (which is specific to =
a
>>>> board). Then, we use a generic interface with board-specific
>>>> arguments.
>>>>=20
>>>> So, to sum up, I understand your point: the way we control the =
driver
>>>> may not always be the most appropriate one. But, we inherited from
>>>> comedi both the interface and the drivers.=20
>>>>=20
>>>> On my side, I am working on trying to implement (as a background =
task)
>>>> a generic interface a little bit more based on discovery (query /
>>>> enum) that would render the command interface obsolete. =
Unfortunately,
>>>> I have nothing interesting to show yet.
>>>>=20
>>>>> Best wishes,
>>>>>=20
>>>>> -STefan
>>>>>=20
>>>>>=20
>>>>=20
>>>=20
>>>=20
>>> _______________________________________________
>>> Xenomai-core mailing list
>>> Xenomai-core@domain.hid
>>> https://mail.gna.org/listinfo/xenomai-core
>>=20
>=20
> --=20
> Alexis.


