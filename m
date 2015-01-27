Date: Tue, 27 Jan 2015 16:54:39 +0100 (CET)
From: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Message-ID: <383897695.12140.1422374079502.JavaMail.zimbra@wandercraft.eu>
In-Reply-To: <20150127153903.GD16502@hermes.click-hack.org>
References: <1942863149.11150.1422371568908.JavaMail.zimbra@wandercraft.eu>
 <20150127153903.GD16502@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Patch rtnet support Intel i217/i218 Ethernet
 Controller
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org



----- Mail original -----
> De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> =C3=80: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
> Cc: xenomai@xenomai.org
> Envoy=C3=A9: Mardi 27 Janvier 2015 16:39:03
> Objet: Re: [Xenomai] Patch rtnet support Intel i217/i218 Ethernet Control=
ler

> On Tue, Jan 27, 2015 at 04:12:48PM +0100, Huy Cong Vu wrote:
>> Hello Xenomai group,
>> I recently run a test of rtnet on xenomai-3-next on my Intel NUC D54250W=
YK with
>> the Intel I218V Ethernet Controller.
>> It is patched on linux 3.14.17. Here I attached the patch to make rtnet =
work
>> with i217/i218 Intel family.
>> Also, I found out that in rtpacket module, the declaration of packet_pro=
to_drv
>> lack of .device_count attribute, which makes the rtpacket & rtcap module=
s
>> unable to loaded ( -EINVAL is returned), so I merge it in my patch too.
>> I test on my system and all the following command is now working:
>> modprobe rtnet
>> modprobe rt_e1000e
>> modprobe rtpacket
>> modprobe rtcap
>> rtifconfig rteth0 up
>> ifconfig rteth0 up
>> ifconfig rteth0-mac up
>> But if I used the rteth0 interface, I can't unload rt_e1000e.
>> Could you take a look and see if anything is wrong, and if you find it u=
seful,
>> merge it in your git repository.
>> Best regards,
>=20
> In Xenomai 3, you need to deconfigure the interface before you try
> to unload it.

If I tried to turn off rteth0 interface after using it, I still can't unloa=
d rt_e1000e.
For now, this work:=20
modprobe rt_e1000e
modprobe rtpacket
rtifconfig rteth0 up
rtifconfig rteth0 down
rmmod rt_e1000e
rmmod rtpacket

This doesn't work:
modprobe rt_e1000e
modprobe rtpacket
rtifconfig rteth0 up
//Send datagram through rteth0 interface=20
rtifconfig rteth0 down
rmmod rt_e1000e

Do I have to do anything special from application level to deconfigure rtet=
h0 too?
>=20
> --
> =09=09=09=09=09    Gilles.

--=20
Huy Cong
Wandercraft SAS

