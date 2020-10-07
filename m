From: Steffen Diehl <Steffen.Diehl@itk-engineering.de>
Subject: Cycle duration peaks due to non-real-time processes
Date: Wed, 7 Oct 2020 13:24:35 +0000
Message-ID: <774839f147524c299dd2d207b9e3942f@itk-engineering.de>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: Tobias Gassner <Tobias.Gassner@itk-engineering.de>, Tobias Luksch <Tobias.Luksch@itk-engineering.de>, Ricardo Tauro <Ricardo.Tauro@itk-engineering.de>

Dear all,

for a medical device we have a real time application which runs at cpu core=
s 1,2,3 (they are isolated and used only by the application as shown in Dyn=
amic Boot Parameters).
A cyclic and high prioritized xenomai thread of the application runs at cpu=
 core 1. The cycle duration of the thread is monitored by the SW itself and=
 can be saved to disk for later analysis.

If there is no extra load, the cycle duration is about 0.55...0.6 ms, but i=
f a ssh login, a scp from/to the system is executed or a file copy on disk =
(e.g. via dd) happens, the cycle duration increases sharply, as shown in th=
e figure bellow.
A high cpu load like "sha1sum /dev/zero" produces no peak of the cycle dura=
tion.

[cid:image002.jpg@01D69CBD.F5939450]

Do you know the reasons for these strong increases in cycle duration? Is th=
ere a way to limit the influence of these non-real-time processes on our re=
al-time application?

System configuration:

  *   Main Processor architekture:
     *   Linux 4.14.89-xenomai-3.0.8-cobalt #1 SMP PREEMPT x86_64 x86_64 x8=
6_64 GNU/Linux
  *   Kernel:
     *   4.14.89-xenomai-3.0.8-cobalt
  *   Config knobs:
     *   Build args: --prefix=3D/usr/xenomai-3.0.8-cobalt --with-core=3Dcob=
alt --enable-pshared --enable-smp
  *   I-pipe core release number:
     *   2
  *   OS:
     *   Ubuntu 18.04 LTS bionic
  *   CPU:
     *   CPU Intel(R) Core(TM) i7-6820EQ CPU @ 2.80GHz (4 physical cores, h=
yper threading deactivated)
  *   Dynamic Boot Parameters:
     *   BOOT_IMAGE=3D/boot/vmlinuz-4.14.89-xenomai-3.0.8-cobalt root=3DUUI=
D=3De50978cf-72c7-11e8-ba28-000babbcd619 ro xenomai.allowed_group=3D1005 is=
olcpus=3D1,2,3 xenomai.sysheap_size=3D1024

Best regards and thank you very much for your help,

Steffen Diehl

--
Steffen Diehl, M.Sc.
Medical Systems Engineering

ITK Engineering GmbH
Im Speyerer Tal 6
76761 R=FClzheim

Tel.: +49 7272 7703-764
Fax: +49 7272 7703-100

mailto:steffen.diehl@itk-engineering.de
_____________________________________________________________
ITK Engineering GmbH  Im Speyerer Tal 6  76761 R=FClzheim
Tel.: +49 7272 7703-0   Fax: +49 7272 7703-100
mailto:info@itk-engineering.de   http://www.itk-engineering.de<http://www.i=
tk-engineering.de/>

Vorsitzender des Aufsichtsrats/Chairman of the Supervisory Board:
Dr. Rudolf Maier
Gesch=E4ftsf=FChrung/Executive Board:
Michael Englert (Vorsitzender/Chairman), Bernd Gohlicke
Sitz der Gesellschaft/Registered Office: 76761 R=FClzheim
Registergericht/Registered Court: Amtsgericht Landau, HRB 32046
USt.-ID-Nr./VAT-ID-No. DE 813165046

-------------- next part --------------
A non-text attachment was scrubbed...
Name: image002.jpg
Type: image/jpeg
Size: 46487 bytes
Desc: image002.jpg
URL: <http://xenomai.org/pipermail/xenomai/attachments/20201007/7ee92a21/at=
tachment.jpg>
