MIME-Version: 1.0
Sender: alexis.berlemont@domain.hid
In-Reply-To: <39AD6D81-28ED-4F47-91FD-383675569A1E@usc.edu>
References: <36718863-7B28-4FD1-8FE4-1F710EB9E7E4@domain.hid>
	<4B3169C1.7020106@domain.hid>
	<39AD6D81-28ED-4F47-91FD-383675569A1E@usc.edu>
Date: Wed, 23 Dec 2009 09:55:32 +0100
Message-ID: <72cf3fb0912230055u726ec6ccj2bb6c85cf09010d3@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] cmd_write
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: xenomai@xenomai.org

Hi,

On Wed, Dec 23, 2009 at 2:12 AM, Stefan Schaal <sschaal@domain.hid> wrote:
> dmesg:
>
> Analogy: analogy_ni_pcimio: ni_mio_common: interrupt: b_status=3D0002 m1_=
status=3D80a80000
> [15619.322973] Analogy: analogy_ni_pcimio: ni_ao_wait_for_dma_load: timed=
 out waiting for dma load
This bug hapens randomly on a card to which I have a remote access.
The occurences were scarce, that is the reason why this bug is still
at the tail of my todo list.

On your board, I suppose it happens at every try. I will try to fix
this bug as soon as possible.

>
> -Stefan
>
>
> On Dec 22, 2009, at 16:52, Alexis Berlemont wrote:
>
>> Hi,
>>
>> Stefan Schaal wrote:
>>> Hi,
>>> =A0I have been trying to test the functionality of the analogy_ni_pcimi=
o driver on a NI6259 board. I am using a linux kernel 2.6.29.5 with the xen=
omai-head (rc5). Doing an a4l_sync_write to an analog output channel works =
fine. Now I am trying to use the cmd structure for writing to the same anal=
og output channel, as done in the cmd_write progam (whose source I found in=
 <xenomai_root>/src/util/analogy/cmd_write.c .
>>> But I am getting the error as indicated below. Any idea why this happen=
s? My own programming gets the same error.
>>> Thanks a lot!
>>> -Stefan
>>> unix> /usr/xenomai/bin/cmd_write -v -d analogy0 -s 1 -c 0 -S 1
>>> cmd_write: device analogy0 opened (fd=3D0)
>>> cmd_write: basic descriptor retrieved
>>> =A0 =A0 =A0 subdevices count =3D 14
>>> =A0 =A0 =A0 read subdevice index =3D 0
>>> =A0 =A0 =A0 write subdevice index =3D 1
>>> cmd_write: complex descriptor retrieved
>>> cmd_write: channel 0
>>> =A0 =A0 =A0 ranges count =3D 3
>>> =A0 =A0 =A0 range's size =3D 16 (bits)
>>> cmd_write: scan size =3D 2
>>> cmd_write: size to write =A0=3D 2
>>> cmd_write: command successfully sent
>>> cmd_write: triggering failed (ret=3D-32)
>> Is there any kernel error messages ? Could you give us the last few line=
s of `dmesg` ?
>>> _______________________________________________
>>> Xenomai-core mailing list
>>> Xenomai-core@domain.hid
>>> https://mail.gna.org/listinfo/xenomai-core
>> Alexis.
>>
>
>
>
Alexis.

