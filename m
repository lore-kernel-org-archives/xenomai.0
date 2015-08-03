Date: Mon, 3 Aug 2015 16:01:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150803140127.GH2538@hermes.click-hack.org>
References: <BAY168-W1231D21CC38789C3EA54E51DC770@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <BAY168-W1231D21CC38789C3EA54E51DC770@phx.gbl>
Subject: Re: [Xenomai]
 =?windows-1252?q?Kernel_hangs_after_=93Starting_kernel_?=
 =?windows-1252?q?=2E=2E=2E=22?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: leejason <woshidahuaidan2011@hotmail.com>
Cc: "xenomia mail l Xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Aug 03, 2015 at 01:53:59PM +0000, leejason wrote:
> hi, background: linux-3.2.21   xenomai2.6.4   soc: ti am335xahead
> of patch  xenomai patch  ,my kernel can run correctly.=20

The I-pipe patch linux 3.2.21 is broken and should not be used.

> after patch pipe-core-3.2.21-arm-4.patch :  Kernel hangs after =93Startin=
g kernel ..."this is my log:
> NAND read: device 0 offset 0x280000, size 0x500000 5242880 bytes read: OK=
## Booting kernel from Legacy Image at 80007fc0 ...   Image Name:   Linux-3=
.2.21   Image Type:   ARM Linux Kernel Image (uncompressed)   Data Size:   =
 2979504 Bytes =3D 2.8 MiB   Load Address: 80008000   Entry Point:  8000800=
0   Verifying Checksum ... OK   XIP Kernel Image ... OKOKStarting kernel ..=
i have disable CONFIG_CPU_FREQ  CONFIG_KGDB  CONFIG_CPU_IDLE and enable CON=
FIG_EARLY_PRINTK.could u help me with that?Regards,jason

In order to enable early printk, see:
https://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/#T=
he_kernel_stops_after_the_message_8220Uncompressing_Linux8230_done_booting_=
the_kernel8221

--=20
					    Gilles.
https://click-hack.org

