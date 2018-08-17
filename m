From: =?utf-8?Q?St=C3=A9phane_Reichert?= <sreichert@sepro-group.com>
References: <004e01d43564$4970d4c0$dc527e40$@sepro-group.com>
 <f5ec79d7-be26-3d87-8d1b-8714d4f3a14a@xenomai.org> 
In-Reply-To: 
Date: Fri, 17 Aug 2018 13:39:50 +0200 (CEST)
Message-ID: <007001d4361f$01d02010$05706030$@sepro-group.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] TR: RTNet - how to setup rt_fec on IMX6Q (Xenomai 3.0.7)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello Philippe,

I have noticed in the file fec.c that the function fec_enet_ioctl did not=
=20
match the prototype of do_ioctl (it looks like "request" and "arg"=20
parameters are switched). Is it a mistake ?

(I tried to switch these parameters but it didn't solved my problem as=20
well).

Stephane


-----Message d'origine-----
De : Philippe Gerum [mailto:rpm@xenomai.org] Envoy=C3=A9 : vendredi 17 ao=
=C3=BBt 2018=20
10:28 =C3=80 : St=C3=A9phane Reichert; xenomai@xenomai.org Objet : Re: [X=
enomai]=20
RTNet - how to setup rt_fec on IMX6Q (Xenomai 3.0.7)

On 08/16/2018 03:23 PM, St=C3=A9phane Reichert wrote:
> Hello,
>
>
>
> We are trying to use the rt_fec driver for RTNet on a iMX6Q board.
>
>
>
> I have patched the KConfig to add this driver on buildroot and it
> compiles perfectly.
>
>
>
> But now, I am not able to use it on our board (it works when I =E2=80=9C=
rtping=E2=80=9D
> the loopback,
>
> but it doesn=E2=80=99t work if I try to ping an external board).

The fec driver does not seem to tell the stack about the carrier enable=20
state. If so, you may want to try the following patch:

diff --git a/kernel/drivers/net/drivers/fec.c
b/kernel/drivers/net/drivers/fec.c
index 36870ba16..d94ec690f 100644
--- a/kernel/drivers/net/drivers/fec.c
+++ b/kernel/drivers/net/drivers/fec.c
@@ -1323,6 +1323,7 @@ fec_enet_open(struct rtnet_device *ndev)
 		return ret;
 	}
 	phy_start(fep->phy_dev);
+	rtnetif_carrier_on(ndev);
 	rtnetif_start_queue(ndev);
 	fep->opened =3D 1;
 	return 0;

--
Philippe.

