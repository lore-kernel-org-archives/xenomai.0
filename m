Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <4B3169C1.7020106@domain.hid>
Date: Tue, 22 Dec 2009 17:12:58 -0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <39AD6D81-28ED-4F47-91FD-383675569A1E@usc.edu>
References: <36718863-7B28-4FD1-8FE4-1F710EB9E7E4@domain.hid>
	<4B3169C1.7020106@domain.hid>
Subject: Re: [Xenomai-core] cmd_write
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai@xenomai.org

dmesg:

Analogy: analogy_ni_pcimio: ni_mio_common: interrupt: b_status=3D0002 =
m1_status=3D80a80000
[15619.322973] Analogy: analogy_ni_pcimio: ni_ao_wait_for_dma_load: =
timed out waiting for dma load

-Stefan


On Dec 22, 2009, at 16:52, Alexis Berlemont wrote:

> Hi,
>=20
> Stefan Schaal wrote:
>> Hi,
>>  I have been trying to test the functionality of the =
analogy_ni_pcimio driver on a NI6259 board. I am using a linux kernel =
2.6.29.5 with the xenomai-head (rc5). Doing an a4l_sync_write to an =
analog output channel works fine. Now I am trying to use the cmd =
structure for writing to the same analog output channel, as done in the =
cmd_write progam (whose source I found in =
<xenomai_root>/src/util/analogy/cmd_write.c .
>> But I am getting the error as indicated below. Any idea why this =
happens? My own programming gets the same error.
>> Thanks a lot!
>> -Stefan
>> unix> /usr/xenomai/bin/cmd_write -v -d analogy0 -s 1 -c 0 -S 1
>> cmd_write: device analogy0 opened (fd=3D0)
>> cmd_write: basic descriptor retrieved
>> 	 subdevices count =3D 14
>> 	 read subdevice index =3D 0
>> 	 write subdevice index =3D 1
>> cmd_write: complex descriptor retrieved
>> cmd_write: channel 0
>> 	 ranges count =3D 3
>> 	 range's size =3D 16 (bits)
>> cmd_write: scan size =3D 2
>> cmd_write: size to write  =3D 2
>> cmd_write: command successfully sent
>> cmd_write: triggering failed (ret=3D-32)
> Is there any kernel error messages ? Could you give us the last few =
lines of `dmesg` ?
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core
> Alexis.
>=20


