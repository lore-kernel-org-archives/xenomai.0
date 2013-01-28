From: "Poole Jr, Donald R." <donald.poole@swri.org>
Date: Mon, 28 Jan 2013 14:52:07 +0000
Message-ID: <E9605457112439448B6B3ED284E065333175B15C@mbx256-1.adm.swri.edu>
In-Reply-To: <E9605457112439448B6B3ED284E065333175A92A@mbx256-1.adm.swri.edu>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xenomai RTDM Driver /dev/ Population
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello All,

I'm currently writing a driver using the Xenomai RTDM API, but had a questi=
on regarding where in the /dev/ hierarchy the driver gets instantiated.  Wh=
en I do an ls =96l on the /dev/ folder.  I don't see my driver listed  belo=
w is my device structure:

static struct rtdm_device gpe_device =3D {
    .struct_version =3D RTDM_DEVICE_STRUCT_VER,

    .device_flags =3D RTDM_NAMED_DEVICE,
    .context_size =3D sizeof(context_t),
    .device_name =3D DEVICE_NAME,

    .open_nrt =3D pwm_rtdm_open_nrt,

    .ops =3D {
        .close_nrt =3D pwm_rtdm_close_nrt,
        .read_nrt =3D pwm_rtdm_read_nrt,
        .write_nrt =3D pwm_rtdm_write_nrt,
    },

    .device_class =3D RTDM_CLASS_EXPERIMENTAL,
    .device_sub_class =3D SOME_SUB_CLASS,
    .profile_version =3D 1,
    .driver_name =3D "GPE",
    .driver_version =3D RTDM_DRIVER_VER(0, 1, 2),
    .peripheral_name =3D "GPIO PWM Engine (GPE)",
    .provider_name =3D "Donald R. Poole, Jr.",
    .proc_name =3D gpe_device.device_name,
};

Could anyone point me in the right direction to see what it is that I might=
 be doing wrong? Thanks in advance.

Thanks,
Donald R. Poole, Jr.
Research Engineer
Voice: 210.522.3131 | Fax: 210.522.4931
Tactical Networks & Communications (tacticalnetworks.swri.org)
Southwest Research Institute (SwRI)
