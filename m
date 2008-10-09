Message-ID: <15875130.1223557641586.JavaMail.ngmail@domain.hid>
Date: Thu, 9 Oct 2008 15:07:21 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_57923_20149664.1223557641585"
Subject: [Xenomai-help] Bug with Xenomai and xeno_heap: Eeek!
 page_mapcount(page) went negative!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_57923_20149664.1223557641585
Content-Type: multipart/alternative; 
	boundary="----=_Part_57922_26661869.1223557641585"

------=_Part_57922_26661869.1223557641585
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi everybody,

I am using the Xenomai version 2.4.5 with Linux version 2.6.26.5 (adeos pat=
ch provided with Xenomai 2.4.5).
Pentium D 3.2 GHz.

There seems to be a bug with the Xenomai mmap page handling that leads to
a=20
Eeek! page_mapcount(page) went negative! (-1)
Kernel error.

With previous version (Xeno 2.3.3,  Kernel 2.6.20.4) this worked.
The situation is the following:
I allocate DMA capable memory in a kernel module.
Then I map to this memory from user space.
So far, everything is fine.
I can access the memory without problem.

However, once I terminate by user space application I get the Eeek.
The strange thing is, that the crash seems to happen with a xeno thread (no=
t the one that mapped to the memory).

I have included the dmesg dump and also a very tiny standalone application =
that crashes with my system
every time I start it.
Untar the heap.tgz archive, run make to build the kernel module and the use=
r space application.
Then, insmod the module and run the user space application.
After a couple of seconds, the system crashes with the Eeek.


Any help on this issue is highly welcome!

Best regards

Mathias





--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Jetzt komfortabel bei Arcor-Digital TV einsteigen: Mehr Happy Ends, mehr He=
rzschmerz, mehr Fernsehen! Erleben Sie 50 digitale TV Programme und optiona=
l 60 Pay TV Sender, einen elektronischen Programmf=FChrer mit Movie Star Be=
wertungen von TV Movie. Au=DFerdem, aktuelle Filmhits und spannende Dokus i=
n der Arcor-Videothek. Infos unter www.arcor.de/tv
------=_Part_57922_26661869.1223557641585--

------=_Part_57923_20149664.1223557641585
Content-Type: application/x-gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=dmesg.gz

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
dw0AAA==
------=_Part_57923_20149664.1223557641585
Content-Type: application/x-compressed
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=heap.tgz

H4sIACP/7UgAA+1WW3PiNhTOa/wrzqRpxnQhGAjQkrBTh3g3aQzZIWS6D53xOLIMXnyrbTLZdve/
90iywRBI+pI8tPrGM5Z0rjo6/uQZteNjsveq0BCdkxP2bnTbGp83xJwPu53OXqOhdVutbqfZ6u5p
jUar2d4D7XXTElikmZ0A7Pn2PbGT5/Rokr5FQm8L5QcvJP7CoXCWZo4XHc/el5e+pvUgsEO2WloO
7cx7oPXMTufr+rkgpcHW9RlrNuZKGU+siX57DcyFbTk0Jad88dLQP0HwlSnigvIQeQ5OuZbKJz+R
KJp7tKL8rQDCCzPwmCabuFECqtfXTsGDM2jj6927CpcIZYYks5g3K/UpjdW26MDK6VIeJ+jSVQ8m
qAT6H+FBSbZu29AKmOZOB03hIU/wu3gVKpdeFbKZlwI+WSned6bPdhbYXsi3Xd5uQkQwUY5YTAI/
InPb99XhwLQGd+OxMZp8Y+MPd5O7sZHnVwSO0RJj/uhhvCpMaYYLamWVZ7FRklA7o+rR6pSqcJAf
BxpqVfi5UYWJ9dvN1Ug/N4swyzrhl5WtWx/l1lUY3fGyCQMCfWbFjt2690JHPRI9wMOxAUabDK3R
zejcvBlcb2ynbAkJzRZJmPaK3SVkaxSsVURWYbQ1/5hnvCMGtysHgZiXMs6DVSGuFP0o+qS1qgr3
4CaUrgLHG9JFWN7/MvW8ol8ibIhSQTeSHGK/9EAHpkadovW4A54waHlzrb5/HjSInIVPX+0aeIn/
T1pawf8nXRxrjWan3ZT8/xZYcbTvhYvHur3IIhKF7jp/C1neJlskbrptdWETQtOtojlNQuqjhDXn
EylNkjDaJQw27hY7DeqxPaVPVzdvsye30PDm4s40LPNqYIxuDfXg4ydTfDLYE5lHoLiQxHWUL+a8
a4ktWLbjJKeCrr3Qy/JvaSdrr5FQwa+bVHei/dKpwqV1e6mPjQv4hsOLoV7+2OcrRhJO8i+cOmu8
x6O7oOJkdYsJKmAJ7aTFXaRY3vS/TmeNHLd4eC7BTfbi9MVPgPjUDhfxtnqvM23Os1sCF3oO9Wlx
DJUnDPnfxtCeU9fz6WvGeIn/m4328v+/iz/++P/f6bYk/78FGAee67dGv/QjoCjR/ZdaAL0+HKq5
vHIcAbKcS/8E9VC9NsYjwxwbpsFE1YoiTObRhs084utkY5koyiMNoxq7aLwpE9YXaVJna/jLW8c/
oHpJzj5H47PR5zSM4zjBjn0ULtMZ9X18l9QrUKsJFUxr8MHUP94+o4vKYu769jRF2ynUfkcWRMFN
UzEvlvY1X1wfLznynU1PmDK+emiAu6jgS5SKFW057okRsuA+1km/Rr3aQFQlTUid33ww7B+q+G9/
cTWugDiplPtgbgv3WNv9KSFQi+DwV1wTBcCoZ4CzfD8YGpu+p+yz1icP7l+FcTZdDgkUKUHBEYrC
SRftakkANffJjvJRgP6pn1Jl3/g8GevW6hBqV2sHnd/MqB06nvv/IV0JCQkJCQkJCQkJCQkJCQkJ
CQkJCQmJV8Y/owju8AAoAAA=
------=_Part_57923_20149664.1223557641585--


