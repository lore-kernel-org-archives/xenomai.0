From: "Benner Bernd (MH/EES)" <B.Benner@domain.hid>
Date: Fri, 20 Jan 2012 16:31:50 +0100
Message-ID: <294B28951EBE8146839AF99A61CB5FCE6C916508C7@domain.hid>
References: <4F167BD2.306@domain.hid> <4F16A454.5010602@domain.hid>
In-Reply-To: <4F16A454.5010602@domain.hid>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] ensuring code running in kernel modules has
 realtime priority
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "rolandtollenaar@domain.hid" <rolandtollenaar@domain.hid>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

Hi Roland,

  i think that there is a commercial ethercat master with a xenomai rtdm in=
terface available
from koenig ( https://koenig-pa.com )

  We are using a open source linux ethercat master ( http://www.etherlab.or=
g/de/ethercat/index.php )
from IGH.

  I have developed a xenomai rtdm realtime interface for this igh ethercat =
master. All sources of this interface are now part of the development tree =
of the IGH- ethercat Master and can be downloaded from the IGH- website.

  My way was to do all initializations and slow non realtime stuff ( SDO et=
c.) with the linux device interface and attach the rtdm driver to the runni=
ng master and port only the "send","receive" and "process domain" ioctrl to=
 rtdm. But this will only work if your master will not use the linux networ=
k layer.

   The IGH master works, because special patched network drivers are part o=
f the project and there is no other linux interfacing in the real time path=
 . ( The Igh Master is designed for RTAI )


Mit freundlichen Gr=FC=DFen / Best Regards
Bernd Benner
MH/SGT3
moehwald
Bosch Group
Moehwald GmbH
Michelinstra=DFe 21
66424 Homburg
GERMANY
www.moehwald.de
Tel.: +49 (0)6841 707-229
b.benner@domain.hid
Moehwald GmbH, Sitz/Registered Office: Homburg/Saar, Zentrales Handelsregis=
ter/Registered Court: Saarbr=FCcken HRB 2812
Gesch=E4ftsf=FChrung/Managing Directors: Christian Artmann, Wolfgang Geenen


-----Urspr=FCngliche Nachricht-----
Von: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] Im =
Auftrag von Gilles Chanteperdrix
Gesendet: Mittwoch, 18. Januar 2012 11:52
An: rolandtollenaar@domain.hid
Cc: RT; Xenomai-help@domain.hid
Betreff: Re: [Xenomai-help] ensuring code running in kernel modules has rea=
ltime priority

On 01/18/2012 08:59 AM, RT wrote:
> Hi all,
>
> we have an interesting situation. We are using a module to do
> communication over a network (ethercat master module) to some remote IO.
>
> The ethercat module is loaded against the kernel in the normal manner.
>
> Now we possibly have overlooked that even though the call to the
> ethercat module (ioctl call) from our real-time application takes
> place in a xenomai real time task, the code of the ethercatmodule may
> be interrupted by other processes running on the machine. Due to the
> fact that the modules code is not running in any real-time prioritized sp=
ace.
>
> If this is indeed the case, what would be the best or easiest manner
> to ensure that the module does not get interrupted, ie. to encapsulate
> it into the xenomai real-time priority sphere?
>
> Hope someone can point us in the right direction here. Its pretty
> urgent because the system is already running live and we are
> intermittently encountering this problem.

If I understand correctly, what you need is to rewrite the ethercat driver =
as a real-time driver using the RTDM skin.

--
                                            Gilles.

_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help

