MIME-Version: 1.0
Sender: lcasassa@domain.hid
From: Linus Casassa <linus@domain.hid>
Date: Tue, 17 Nov 2009 18:42:33 -0300
Message-ID: <47a3101a0911171342y39faa155r9ed7010f672f4e31@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd29cba23cdd00478980297
Subject: [Xenomai-help] Wifistix kernel 2.6.24
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--000e0cd29cba23cdd00478980297
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

How do I get the wifistix to work on a kernel 2.6.24?

I maneged to compile wifistix-module but I get this error:

root@domain.hid$ modprobe wlan0
FATAL: Error inserting cfio (/lib/modules/2.6.24/extra/cfio.ko): Unknown
symbol in module, or unknown parameter (see dmesg)
WARNING: Error running install command for cfio
FATAL: Error inserting mcf25 (/lib/modules/2.6.24/extra/mcf25.ko): Unknown
symbol in module, or unknown parameter (see dmesg)

root@domain.hid$ dmesg
<4>cfio: Unknown symbol pcmcia_disable_device
<4>cfio: Unknown symbol pcmcia_unregister_driver
<4>cfio: Unknown symbol pccard_get_first_tuple
<4>cfio: Unknown symbol pcmcia_get_configuration_info
<4>cfio: Unknown symbol pcmcia_request_io
<4>cfio: Unknown symbol pcmcia_request_configuration
<4>cfio: Unknown symbol pcmcia_access_configuration_register
<4>cfio: Unknown symbol pccard_get_tuple_data
<4>cfio: Unknown symbol pcmcia_register_driver
<4>cfio: Unknown symbol pccard_parse_tuple
<4>cfio: Unknown symbol pcmcia_request_irq
<4>mcf25: Unknown symbol cfio_read_cfg_reg
<4>mcf25: Unknown symbol pccard_get_first_tuple
<4>mcf25: Unknown symbol cardp
<4>mcf25: Unknown symbol cfio_dev_info
<4>mcf25: Unknown symbol pccard_get_tuple_data
<4>mcf25: Unknown symbol register_cf_driver
<4>mcf25: Unknown symbol pccard_get_next_tuple
<4>mcf25: Unknown symbol unregister_cf_driver
root@domain.hid$

thanks for the help :)

--=20
Linus Casassa
Estudiante Ingenier=EDa Civil Electr=F3nica
Fono: 56-9-97776941

--000e0cd29cba23cdd00478980297
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

How do I get the wifistix to work on a kernel 2.6.24?<br><br>I maneged to c=
ompile wifistix-module but I get this error:<br><br>root@domain.hid=
dex:/lib/modules/2.6.24/extra$ modprobe wlan0 <br>FATAL: Error inserting cf=
io (/lib/modules/2.6.24/extra/cfio.ko): Unknown symbol in module, or unknow=
n parameter (see dmesg)<br>

WARNING: Error running install command for cfio<br>FATAL: Error inserting m=
cf25 (/lib/modules/2.6.24/extra/mcf25.ko): Unknown symbol in module, or unk=
nown parameter (see dmesg)<br><br>root@domain.hid=
.6.24/extra$ dmesg <br>

&lt;4&gt;cfio: Unknown symbol pcmcia_disable_device<br>&lt;4&gt;cfio: Unkno=
wn symbol pcmcia_unregister_driver<br>&lt;4&gt;cfio: Unknown symbol pccard_=
get_first_tuple<br>&lt;4&gt;cfio: Unknown symbol pcmcia_get_configuration_i=
nfo<br>

&lt;4&gt;cfio: Unknown symbol pcmcia_request_io<br>&lt;4&gt;cfio: Unknown s=
ymbol pcmcia_request_configuration<br>&lt;4&gt;cfio: Unknown symbol pcmcia_=
access_configuration_register<br>&lt;4&gt;cfio: Unknown symbol pccard_get_t=
uple_data<br>

&lt;4&gt;cfio: Unknown symbol pcmcia_register_driver<br>&lt;4&gt;cfio: Unkn=
own symbol pccard_parse_tuple<br>&lt;4&gt;cfio: Unknown symbol pcmcia_reque=
st_irq<br>&lt;4&gt;mcf25: Unknown symbol cfio_read_cfg_reg<br>&lt;4&gt;mcf2=
5: Unknown symbol pccard_get_first_tuple<br>

&lt;4&gt;mcf25: Unknown symbol cardp<br>&lt;4&gt;mcf25: Unknown symbol cfio=
_dev_info<br>&lt;4&gt;mcf25: Unknown symbol pccard_get_tuple_data<br>&lt;4&=
gt;mcf25: Unknown symbol register_cf_driver<br>&lt;4&gt;mcf25: Unknown symb=
ol pccard_get_next_tuple<br>

&lt;4&gt;mcf25: Unknown symbol unregister_cf_driver<br>root@domain.hid=
verdex:/lib/modules/2.6.24/extra$ <br><br>thanks for the help :)<br><br>-- =
<br>Linus Casassa<br>Estudiante Ingenier=EDa Civil Electr=F3nica<br>Fono: 5=
6-9-97776941<br>



--000e0cd29cba23cdd00478980297--

