Date: Mon, 12 Jan 2015 15:56:35 +0100 (CET)
From: Adrien Canuel <adrien.canuel@telecom-paristech.fr>
Message-ID: <172953270.6511559.1421074595415.JavaMail.zimbra@enst.fr>
In-Reply-To: <20150112104559.GE25855@hermes.click-hack.org>
References: <2065498163.6212085.1421059225559.JavaMail.zimbra@enst.fr>
 <1238789666.6212719.1421059233270.JavaMail.zimbra@enst.fr>
 <20150112104559.GE25855@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Latency test on Zedboard
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

I had to reconfigure the kernel because for some reason Xenomai wasn't work=
ing any more.
Before the kernel was configured to work with only one processor (because o=
ne processor was always blocked during the boot phase), and I got the bindi=
ng error when I tried to launch the latency test.
Now I configure the kernel to work with multiple processor (this time the b=
oot completed without problem), and the latency test runs well.
I just had to add some links in the /dev repertory, because the application=
 needed the /dev/rtdm/memdev-private and /dev/rtdm/memdev-shared devices, a=
nd I have these two devices directly under the /dev directory (not /dev/rtd=
m).

Adrien

----- Mail original -----
De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
=C3=80: "Adrien Canuel" <adrien.canuel@telecom-paristech.fr>
Cc: xenomai@xenomai.org
Envoy=C3=A9: Lundi 12 Janvier 2015 11:45:59
Objet: Re: [Xenomai]  Latency test on Zedboard

On Mon, Jan 12, 2015 at 11:40:33AM +0100, Adrien Canuel wrote:
> Hi,
>=20
> I have successfully booted linux with Xenomai on the Zedboard from Xilinx=
, but when I try to launch the latency test, I get the error :
> "Xenomai/Cobalt: low_init(): binding failed: Function not implemented"
> I use the version 3.14.17 of the linux kernel. Can you help me with this =
?

Either you do not boot a kernel patched with Xenomai, or Xenomai
initialization failed for some reason. So, in fact, you probably
have not successfully booted Linux with Xenomai. Please provide the
boot logs.

--=20
=09=09=09=09=09    Gilles.

