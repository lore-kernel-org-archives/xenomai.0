Message-ID: <41DEB86A.9080706@domain.hid>
Date: Fri, 07 Jan 2005 17:27:22 +0100
From: Andre Tousch <andre.tousch@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Adeos-main] adeos-linux-2.4.22-armnommu-r14.patch / __adeos_switch_domain
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: "Adeos-Main@domain.hid" <adeos-main@gna.org>

Hi,
in the adeos-linux-2.4.22-armnommu-r14.patch (and r12 also) I have met=20
the following issue :   __adeos_switch_domain is linked into the=20
.text.init section.
That is , if free_init_mem() is called at end of boot, the code is=20
overwritten and the system crashes.
However - I don't know why - it depends on the TEXTADDR. Depending on=20
the TEXTADDR, free_init_mem() does'nt overwrite all the init section (If=20
you know why, please tell me :) ).
The error is priduced by the modifications made to entry-armv.S.

Regards,
Andr=E9


