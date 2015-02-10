Date: Tue, 10 Feb 2015 11:46:01 +0100 (CET)
From: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Message-ID: <591131357.26954.1423565161829.JavaMail.zimbra@wandercraft.eu>
In-Reply-To: <1196678867.12503.1422375100449.JavaMail.zimbra@wandercraft.eu>
References: <1942863149.11150.1422371568908.JavaMail.zimbra@wandercraft.eu>
 <20150127153903.GD16502@hermes.click-hack.org>
 <383897695.12140.1422374079502.JavaMail.zimbra@wandercraft.eu>
 <20150127160045.GE16502@hermes.click-hack.org>
 <1196678867.12503.1422375100449.JavaMail.zimbra@wandercraft.eu>
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
> De: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
> =C3=80: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> Cc: xenomai@xenomai.org
> Envoy=C3=A9: Mardi 27 Janvier 2015 17:11:40
> Objet: Re: [Xenomai] Patch rtnet support Intel i217/i218 Ethernet Control=
ler

> ----- Mail original -----
>> De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
>> =C3=80: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
>> Cc: xenomai@xenomai.org
>> Envoy=C3=A9: Mardi 27 Janvier 2015 17:00:45
>> Objet: Re: [Xenomai] Patch rtnet support Intel i217/i218 Ethernet Contro=
ller
>=20
>> On Tue, Jan 27, 2015 at 04:54:39PM +0100, Huy Cong Vu wrote:
>>>=20
>>>=20
>>> ----- Mail original -----
>>> > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
>>> > =C3=80: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
>>> > Cc: xenomai@xenomai.org
>>> > Envoy=C3=A9: Mardi 27 Janvier 2015 16:39:03
>>> > Objet: Re: [Xenomai] Patch rtnet support Intel i217/i218 Ethernet Con=
troller
>>>=20
>>> > On Tue, Jan 27, 2015 at 04:12:48PM +0100, Huy Cong Vu wrote:
>>> >> Hello Xenomai group,
>>> >> I recently run a test of rtnet on xenomai-3-next on my Intel NUC D54=
250WYK with
>>> >> the Intel I218V Ethernet Controller.
>>> >> It is patched on linux 3.14.17. Here I attached the patch to make rt=
net work
>>> >> with i217/i218 Intel family.
>>> >> Also, I found out that in rtpacket module, the declaration of packet=
_proto_drv
>>> >> lack of .device_count attribute, which makes the rtpacket & rtcap mo=
dules
>>> >> unable to loaded ( -EINVAL is returned), so I merge it in my patch t=
oo.
>>> >> I test on my system and all the following command is now working:
>>> >> modprobe rtnet
>>> >> modprobe rt_e1000e
>>> >> modprobe rtpacket
>>> >> modprobe rtcap
>>> >> rtifconfig rteth0 up
>>> >> ifconfig rteth0 up
>>> >> ifconfig rteth0-mac up
>>> >> But if I used the rteth0 interface, I can't unload rt_e1000e.
>>> >> Could you take a look and see if anything is wrong, and if you find =
it useful,
>>> >> merge it in your git repository.
>>> >> Best regards,
>>> >=20
>>> > In Xenomai 3, you need to deconfigure the interface before you try
>>> > to unload it.
>>>=20
>>> If I tried to turn off rteth0 interface after using it, I still can't u=
nload
>>> rt_e1000e.
>>> For now, this work:
>>> modprobe rt_e1000e
>>> modprobe rtpacket
>>> rtifconfig rteth0 up
>>> rtifconfig rteth0 down
>>> rmmod rt_e1000e
>>> rmmod rtpacket
>>>=20
>>> This doesn't work:
>>> modprobe rt_e1000e
>>> modprobe rtpacket
>>> rtifconfig rteth0 up
>>> //Send datagram through rteth0 interface
>>> rtifconfig rteth0 down
>>> rmmod rt_e1000e
>>>=20

This patch helps.=20

diff --git a/kernel/drivers/net/stack/packet/af_packet.c b/kernel/drivers/n=
et/stack/packet/af_packet.c
index dd862fe..6a9f183 100644
--- a/kernel/drivers/net/stack/packet/af_packet.c
+++ b/kernel/drivers/net/stack/packet/af_packet.c
@@ -456,6 +456,7 @@ rt_packet_sendmsg(struct rtdm_fd *fd, const struct msgh=
dr *msg, int msg_flags)
     }
=20
  out:
+    rtdev_dereference(rtdev);
     return ret;
=20
  err:

Now it seems ok to unload all modules for me.

>>> Do I have to do anything special from application level to deconfigure =
rteth0
>>> too?
>>=20
>> No, rtifconfig down should be enough. Note that the module count
>> handling requires some patches in the I-pipe kernel. Since it was
>> reworked, it is entirely possible that there are some glitches with
>> it, or that some necessary change in rt_e1000e.c is missing.
>>=20
>> Also, since the multiple modules system will not fly for building
>> rtnet and its modules into the kernel, this will be reworked.
>>=20
>> Other than that, does rtnet work for you ?
>=20
> Yes, except this problem, my test with rtnet runs fine.
>=20
>>=20
>> --
>> =09=09=09=09=09    Gilles.
>=20
> --
> Huy Cong
> Wandercraft SAS
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

--=20
Huy Cong
Wandercraft SAS

