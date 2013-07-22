From: "Kari Kumpulainen" <k_olavi@ovi.com>
References: <CADVgf9kDgO9oHA3juWEGV-1RXBo5vNzzR208Ot3W3318Zryscw@mail.gmail.com>
	<002801ce8708$32059d80$9610d880$@ovi.com>
In-Reply-To: <002801ce8708$32059d80$9610d880$@ovi.com>
Date: Mon, 22 Jul 2013 22:00:57 +0300
Message-ID: <002a01ce870d$ccf3fdf0$66dbf9d0$@ovi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Language: fi
Subject: Re: [Xenomai] Xenomai for Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Matt,

I can't locate "ipipe-core-3.8-arm-3.patch" mentioned in your =
instructions
for 3.8 kernel.=20
Did you mean " ipipe-core-3.8-arm-1.patch", in
http://download.gna.org/adeos/patches/v3.x/arm/ ?

Br, Kari

-----Original Message-----
From: xenomai-bounces@xenomai.org [mailto:xenomai-bounces@xenomai.org] =
On
Behalf Of Kari Kumpulainen
Sent: 22. hein=E4kuuta 2013 21:21
To: xenomai@xenomai.org
Subject: Re: [Xenomai] Xenomai for Zynq

Great, thank you so much!

Br, Kari

-----Original Message-----
From: xenomai-bounces@xenomai.org [mailto:xenomai-bounces@xenomai.org] =
On
Behalf Of Matthew Fornero
Sent: 22. hein=E4kuuta 2013 20:10
To: xenomai@xenomai.org
Subject: Re: [Xenomai] Xenomai for Zynq

On Mon, Jul 22, 2013 at 11:26 AM, Kari Kumpulainen <k_olavi@ovi.com> =
wrote:
> Hello,
>
> Which kernel and Xenomai versions should I use if I want to build=20
> Xenomai support for a Zynq (Xilinx) chip?
> I tried to patch the 3.5 kernel provided by Xilinx, but patching=20
> failed because of conflicts in some files.

There are a couple projects on github which should get you started.
Note that I haven't updated either of these for a while:

3.5 based kernel: https://github.com/mfornero/ipipe This is a merge of =
the
Xilinx 3.5 tree and the ipipe 3.5 tree. Both are now fairly out of date

3.8 based kernel: use the patches and readme found here:
https://github.com/mfornero/xenomai/tree/for-upstream/ksrc/arch/arm/patch=
es

I believe the later will be merged into the Xenomai tree at some point.

Best Regards,

Matt Fornero

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://www.xenomai.org/mailman/listinfo/xenomai


_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://www.xenomai.org/mailman/listinfo/xenomai


