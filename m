Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <4B300382.6070802@domain.hid>
Date: Mon, 21 Dec 2009 23:02:07 -0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <1A7A1F0B-5F96-4FE8-BBC5-BB98C46493D1@domain.hid>
References: <1B242B31-29DB-4363-8B08-8E77B2928C34@domain.hid>	<4AE9A1DB.1060506@domain.hid>	<67A93E2E-3273-45B0-ACCE-9FC7A104F9A5@domain.hid>	<FF6D4747-95BE-4B18-8B77-864B7DA5EAEF@usc.edu>	<4AE9E5AC.7050401@domain.hid>
	<1F6D4575-0CF0-49E6-A7ED-1A045BE8D5B4@domain.hid>
	<4B300382.6070802@domain.hid>
Subject: Re: [Xenomai-core] digital I/O with analgoy using ni_pcmcia
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: Jonas Buchli <jonas@domain.hid>, Peter Pastor Sampedro <pastorsa@domain.hid>, Ludovic Righetti <ludovic.righetti@domain.hid>, xenomai@xenomai.org

Hi Alexis,

  thanks  a lot for all these suggestions. For my applications, the =
functions you listed below would be entirely sufficient. Essentially, I =
need to be able to put selected channels on the DIO in either read or =
write mode, and then simply read from them or write from them. The =
protocol I use requires 16 data bits, and 3 additional control lines. It =
was originally implemented under vxWorks. Nothing fancy at all.

Thanks a lot for your kind help!

-Stefan



On Dec 21, 2009, at 15:23, Alexis Berlemont wrote:

> Hi,
>=20
> Stefan Schaal wrote:
>> Hi everybody,
>> we have an NI6259 board working xenomai 2.5, using the analogy APIs.
>> Read/write to analog channels is quite straightforward and can be
>> inferred from the cmd_read and cmd_write source code. Now I would =
also
>> like to use the digital I/O of this board (e.g., the 32 digital I/O
>> lines). In Comedi, there are functions to set the DIO lines to
>> input/output mode (comedi_dio_config), and then functions to =
read/write,
>> like comedi_dio_read and comedi_dio_write. Does xenomai/analogy =
already
>> have similar functionality?
>=20
> Many thanks for this question, it is an issue I have been
> keeping on postponing the resolution. Currently, the functions are not =
implemented but it could be quickly done.
>=20
> Here is my understanding of the Comedi DIO features; please, correct
> me if I am wrong.
>=20
> In Comedi, here is the list of functions related with DIO:
> - comedi_dio_read (insn_read or deprecated insn trigger)
> - comedi_dio_write (insn_write or deprecated insn trigger)
> - comedi_dio_config (insn_config or deprecated insn trigger)
> - comedi_dio_get_config (insn_config or deprecated trigger)
> - comedi_dio_bitfield (insn_bits or comedi_dio_read/write)
> - comedi_dio_bitfield2 (insn_bits or comedi_dio_read/write)
>=20
> The instruction insn_bits is a combination of a read operation and a
> write operation (that is why, the function comedi_dio_bitfield* call
> comedi_dio_read and comedi_dio_write if the driver does not provide an
> insn-bits handler).
>=20
> I had a look at many Comedi drivers and most of them register the
> handler "insn_bits" for the DIO subdevice. The instructions insn_read
> and insn_write are not oftenly used in DIO contexts.
>=20
> comedi_dio_bitfield() uses the insn_bits instruction. However, it only
> works with DIO subdevice limited to 32 channels; that was why
> comedi_dio_bitfield2() was introduced, this latter function contains
> one more argument so as to shift the bits.
>=20
> Consequently, we may need a more limited set of functions:
> - a4l_sync_dio(dsc, idx_subd, mask, buf)
> - a4l_sizeof_subd(dsc, idx_subd)
> - a4l_config_subd(dsc, idx_subd, idx_chan, cfg_type, *val)
>=20
> a4l_sync_dio() could work with any DIO subdevice (more or less than 32
> channels). The last argument would be a pointer to a buffer which size
> should be defined thanks to a4l_sizeof_subd() (8, 16, 32, 64 or more
> bits).
>=20
> a4l_config_subd() could be used to configure the polarity of the DIO
> channels. The argument cfg_type could be set to DIO_INPUT, DIO_OUTPUT,
> DIO_QUERY. And, we could even imagine that this function would not be
> limited to DIO subdevice; so, the argument cfg_type could accept more
> values (SERIAL_CLOCK, BIDIRECTIONAL_DATA, SET_CLOCK_SRC,
> GET_CLOCK_SRC, etc.)
>=20
> How do you see this approach ?
>=20
> Do you (or anyone else) have a better solution in mind ?
>=20
> Best regards,
>=20
>> Thanks a lot,
>> -Stefan
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core
> Alexis.
>=20


