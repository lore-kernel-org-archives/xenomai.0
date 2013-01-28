Message-ID: <510695EC.9080407@siemens.com>
Date: Mon, 28 Jan 2013 16:14:52 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <E9605457112439448B6B3ED284E065333175A92A@mbx256-1.adm.swri.edu>
	<E9605457112439448B6B3ED284E065333175B15C@mbx256-1.adm.swri.edu>
In-Reply-To: <E9605457112439448B6B3ED284E065333175B15C@mbx256-1.adm.swri.edu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai RTDM Driver /dev/ Population
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Poole Jr, Donald R." <donald.poole@swri.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-01-28 15:52, Poole Jr, Donald R. wrote:
> Hello All,
>=20
> I'm currently writing a driver using the Xenomai RTDM API, but had a qu=
estion regarding where in the /dev/ hierarchy the driver gets instantiate=
d.  When I do an ls =96l on the /dev/ folder.  I don't see my driver list=
ed  below is my device structure:
>=20
> static struct rtdm_device gpe_device =3D {
>     .struct_version =3D RTDM_DEVICE_STRUCT_VER,
>=20
>     .device_flags =3D RTDM_NAMED_DEVICE,
>     .context_size =3D sizeof(context_t),
>     .device_name =3D DEVICE_NAME,
>=20
>     .open_nrt =3D pwm_rtdm_open_nrt,
>=20
>     .ops =3D {
>         .close_nrt =3D pwm_rtdm_close_nrt,
>         .read_nrt =3D pwm_rtdm_read_nrt,
>         .write_nrt =3D pwm_rtdm_write_nrt,
>     },
>=20
>     .device_class =3D RTDM_CLASS_EXPERIMENTAL,
>     .device_sub_class =3D SOME_SUB_CLASS,
>     .profile_version =3D 1,
>     .driver_name =3D "GPE",
>     .driver_version =3D RTDM_DRIVER_VER(0, 1, 2),
>     .peripheral_name =3D "GPIO PWM Engine (GPE)",
>     .provider_name =3D "Donald R. Poole, Jr.",
>     .proc_name =3D gpe_device.device_name,
> };
>=20
> Could anyone point me in the right direction to see what it is that I m=
ight be doing wrong? Thanks in advance.

RTDM devices aren't registered with the Linux VFS layer. They live in
their own space, managed by Xenomai, addressable via Native's
rt_dev_open or the wrapped POSIX open call. The POSIX skin allows you to
address them as "/dev/mydevice" as well, but it acutally cuts "/dev/"
off before doing the open via RTDM.

Check /proc/xenomai/rtdm/named_devices to see if your device was register=
ed.

Jan

--=20
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

