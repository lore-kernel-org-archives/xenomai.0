From: Johann Obermayr <johann.obermayr@sigmatek.at>
Date: Fri, 10 Nov 2017 10:41:13 +0000
Message-ID: <AM4PR0801MB15872C7EB0DD616419F23F09F5540@AM4PR0801MB1587.eurprd08.prod.outlook.com>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] xeno_imx_uart & bind
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello,

we have a imx6 with Xenomai 2.6.4 (yes, it's old).
We use one imx6 uart for our linux debug console.

Is there a way, that we can bind the xeno_imx_uart to this exist uart ?

Can it be done with "echo something > /sys/bus/platform/drivers/xeno_imx_ua=
rt/bind" ?

Thanks=20
  Johann


