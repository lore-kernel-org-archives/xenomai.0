From: <romain.perier@scle.fr>
Date: Wed, 22 Apr 2015 08:35:46 +0200
Message-ID: <299A38B133279A4EBA47BCB60993FEAF858030C8A4@xs203433.MELINDA.LOCAL>
References: <CY1PR0201MB0812AF4CAF1C3E3D8CEC186AA2EE0@CY1PR0201MB0812.namprd02.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Support for Xilinx Zynq ZC706
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: kalyan@bluedanube.com, xenomai@xenomai.org

Le 22/04/2015 02:58, Kalyan Subramanian a =E9crit :=0A=
> Is xenomai support available for the Xilinx Zynq ZC706 board with ARM Cor=
tex-A9 dual core SoC? It is not very clear from this web page what you supp=
ort:=0A=
> http://xenomai.org/embedded-hardware/#Supported_SoC=0A=
>=0A=
> says=0A=
> o    Xilinx=0A=
> o    Zynq family=0A=
> [separate-patch]<http://xenomai.org/embedded-hardware/#_footnote_separate=
-patch>=0A=
>=0A=
> Thanks,=0A=
> ---Kalyan=0A=
>=0A=
> _______________________________________________=0A=
> Xenomai mailing list=0A=
> Xenomai@xenomai.org=0A=
> http://www.xenomai.org/mailman/listinfo/xenomai=0A=
>=0A=
Hi,=0A=
=0A=
I tested Xenomai on the Xilinx Zynq ZC702 board, it boots and works fine=0A=
with ipipe 3.16 and ipipe 3.18. However, there are no RTDM drivers,=0A=
which means that all drivers are running in the linux domain.=0A=
If it works for the ZC702, it should probably work for the ZC706.=0A=
=0A=
Regards,=0A=
Romain=0A=
=0A=

