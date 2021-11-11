From: Ando Yuta <andouyuuta@yamaha-motor.co.jp>
Subject: RE: Trying Xenomai3.2 and has some web browser problem
Date: Thu, 11 Nov 2021 10:58:50 +0000
Message-ID: <TY2PR04MB38382DD227A50372A8E60025AA949@TY2PR04MB3838.apcprd04.prod.outlook.com>
References: <TY2PR04MB3838919175C4210652E4FCD4AA939@TY2PR04MB3838.apcprd04.prod.outlook.com>
 <ae935e63-ad36-7d98-da3a-7046948ab38a@siemens.com>
 <TY2PR04MB3838BC44901BBCE5A33A14A8AA949@TY2PR04MB3838.apcprd04.prod.outlook.com>
 <6bd9fd83a953df456c4864fdf030eb918cf6e644.camel@siemens.com>
In-Reply-To: <6bd9fd83a953df456c4864fdf030eb918cf6e644.camel@siemens.com>
Content-Language: ja-JP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>

Hello

>Sandbox enabled:
>stat("/sys/fs/cgroup/cpuset/chrome", 0x7f9068a987c0) =3D -1 ENOSYS (Functi=
on not implemented)
>Sandbox disabled:
>stat("/sys/fs/cgroup/cpuset/chrome", 0x7f9e3a03a7c0) =3D -1 ENOENT (No suc=
h file or directory)
>You have updated the kernel, but did you update your libseccomp security p=
rofile as well? (IOW: Have you updated your userspace as well?)
>I know about some problems in the past where similar affects were observed=
 when using syscalls that were not known to the security profile in use. Th=
e stat call is not new, but ENOSYS is unexpected.

Yes I checked. My seccomp version is 2.5.1-1ubuntu1~18.04.1.
Is there anything else I need to do to update the security profile of libse=
ccomp?

Yuta Ando

-----Original Message-----
From: Bezdeka, Florian <florian.bezdeka@siemens.com>=20
Sent: Thursday, November 11, 2021 6:09 PM
To: xenomai@xenomai.org; Ando Yuta <andouyuuta@yamaha-motor.co.jp>; jan.kis=
zka@siemens.com
Subject: Re: Trying Xenomai3.2 and has some web browser problem

On Thu, 2021-11-11 at 04:46 +0000, Ando Yuta via Xenomai wrote:
> Hello Jan
>=20
> Thanks for the reply.
>=20
> > x86?
>=20
> Sorry I forgot to write the CPU info.
> My CPU is x86_64(11th Gen Intel i5)
>=20
> > Can you generate a trace (strace or maybe even kernel event trace) of b=
oth good an bad cases? To see where the behaviour diverges.
> > Or is there something that reproduces this without requiring a full UI =
for the browser?
>=20
> Yes, I found that the same phenomenon occurs when I specify "--disable-gp=
u" in headless mode chrome.
>=20
> There are the command to reproduce.
> 1 chrome --headless --disable-gpu=20
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.
> google.com%2F&amp;data=3D04%7C01%7Candouyuuta%40yamaha-motor.co.jp%7C42b
> 7cfc69345461303a108d9a4f2e22f%7C76684a67d81643ce93f929b6f72f823f%7C1%7
> C0%7C637722185358222963%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC
> JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dd5K%2BuP
> 31DcmB3cCvYv8aHIjEHYCaj6%2FFKczgq5qTM2I%3D&amp;reserved=3D0 (in dovetail=
=20
> browser crash, in generic works properly)
> 2 chrome --headless --disable-gpu --disable-seccomp-filter-sandbox=20
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.
> google.com%2F&amp;data=3D04%7C01%7Candouyuuta%40yamaha-motor.co.jp%7C42b
> 7cfc69345461303a108d9a4f2e22f%7C76684a67d81643ce93f929b6f72f823f%7C1%7
> C0%7C637722185358232954%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC
> JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DFeCuoU%2
> BojmsoaLbDIO2Q%2BovZ88u1A5JPfql9RtXu8nc%3D&amp;reserved=3D0 (disable=20
> sandbox, this works in both dovetail and generic but unsafe)
>=20
> Attached files are the results of strace and kernel event trace in headle=
ss mode above.
> They are generic, dovetail with sandbox enabled, and dovetail with sandbo=
x disabled.

Sandbox enabled:
stat("/sys/fs/cgroup/cpuset/chrome", 0x7f9068a987c0) =3D -1 ENOSYS (Functio=
n not implemented)

Sandbox disabled:
stat("/sys/fs/cgroup/cpuset/chrome", 0x7f9e3a03a7c0) =3D -1 ENOENT (No such=
 file or directory)

You have updated the kernel, but did you update your libseccomp security pr=
ofile as well? (IOW: Have you updated your userspace as
well?)

I know about some problems in the past where similar affects were observed =
when using syscalls that were not known to the security profile in use. The=
 stat call is not new, but ENOSYS is unexpected.

>=20
> Yuta Ando
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: Wednesday, November 10, 2021 8:16 PM
> To: Ando Yuta <andouyuuta@yamaha-motor.co.jp>; xenomai@xenomai.org
> Subject: Re: Trying Xenomai3.2 and has some web browser problem
>=20
> On 10.11.21 07:33, Ando Yuta via Xenomai wrote:
> > Hello
> >=20
> > We are now testing xenomai3.2 with dovetail core(kernel ver5.10.70)
>=20
> x86?
>=20
> > The kernel build was successful with some modifications to the ipipe co=
nfiguration we had been using.
> > Building our application was also successful without any problems, just=
 by slightly changing the flags in cmake.
> > So our application is working well, except for one thing.
> >=20
> > When using xenomai 3.1 with ipipe patch 5.4.77, there was no=20
> > problem, but when using 5.10.70 dovetail, the web browser started to cr=
ash.
> >=20
> > Firefox didn't work at all.
> > When using Google Chrome and chromium, some pages don't crash and=20
> > some, in particular, video sites like youtube and sites that require lo=
gin such as github did.
> >=20
> > Attached below are the results of strace when using chrome.
> > The problem seems to be around seccomp.
> >=20
> > If we follow this
> > web(https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%
> > 2F=20
> > chromium.googlesource.com%2Fchromium%2Fsrc%2F%2B%2Frefs%2Fheads%2Fma
> > in=20
> > %2Fdocs%2Flinux%2Fsandboxing.md&amp;data=3D04%7C01%7Candouyuuta%40yama
> > ha
> > -motor.co.jp%7C9d666629b66d41c1cad908d9a43b70b4%7C76684a67d81643ce93
> > f9=20
> > 29b6f72f823f%7C1%7C0%7C637721397467929645%7CUnknown%7CTWFpbGZsb3d8ey
> > JW=20
> > IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100
> > 0&=20
> > amp;sdata=3DB0%2BqIC8MVLBc%2FxdqkCWmb2skU6NDLv2793FFvQTZGLQ%3D&amp;res
> > er
> > ved=3D0) and specify --disable-seccomp-filter-sandbox, the crash was=20
> > apparently avoided.
> > However, this option disables sandbox, which causes a security problem.
> > Therefore, we do not want to disable sandbox if possible.
> >=20
> > This browser crash does not occur on the same 5.10.70 kernel unless=20
> > we enable the dovetail realtime kernel, so It seems to be an issue with=
 a system call related to dovetail's seccomp.
> > Is there any way to solve this problem?
> >=20
> > The strace results are as follows
> >=20
>=20
> Can you generate a trace (strace or maybe even kernel event trace) of bot=
h good an bad cases? To see where the behaviour diverges.
>=20
> Or is there something that reproduces this without requiring a full UI fo=
r the browser?
>=20
> Thanks for reporting!
>=20
> Jan
>=20
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
> -------------- next part -------------- An embedded and=20
> charset-unspecified text was scrubbed...
> Name: generic_kernel_event_trace.txt
> URL:=20
> <https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fxeno
> mai.org%2Fpipermail%2Fxenomai%2Fattachments%2F20211111%2Fe72ff993%2Fat
> tachment.txt&amp;data=3D04%7C01%7Candouyuuta%40yamaha-motor.co.jp%7C42b7
> cfc69345461303a108d9a4f2e22f%7C76684a67d81643ce93f929b6f72f823f%7C1%7C
> 0%7C637722185358232954%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DWIBfYVivj
> d5t7BbAqPDxfnwCzcvNIwNhHisrC%2Fe4n%2Bs%3D&amp;reserved=3D0>
> -------------- next part -------------- An embedded and=20
> charset-unspecified text was scrubbed...
> Name: generic_strace.txt
> URL:=20
> <https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fxeno
> mai.org%2Fpipermail%2Fxenomai%2Fattachments%2F20211111%2Fe72ff993%2Fat
> tachment-0001.txt&amp;data=3D04%7C01%7Candouyuuta%40yamaha-motor.co.jp%7
> C42b7cfc69345461303a108d9a4f2e22f%7C76684a67d81643ce93f929b6f72f823f%7
> C1%7C0%7C637722185358232954%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DjWYe
> qJfFZtSexiqlg5qTANWUptrCcVckGK4wyvBFNug%3D&amp;reserved=3D0>
> -------------- next part -------------- An embedded and=20
> charset-unspecified text was scrubbed...
> Name: dovetail_kernel_event_trace.txt
> URL:=20
> <https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fxeno
> mai.org%2Fpipermail%2Fxenomai%2Fattachments%2F20211111%2Fe72ff993%2Fat
> tachment-0002.txt&amp;data=3D04%7C01%7Candouyuuta%40yamaha-motor.co.jp%7
> C42b7cfc69345461303a108d9a4f2e22f%7C76684a67d81643ce93f929b6f72f823f%7
> C1%7C0%7C637722185358232954%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DyxRN
> KP5dzcjpnJYBxZohT7iXIXKsayKQXAA6zZHg3tU%3D&amp;reserved=3D0>
> -------------- next part -------------- An embedded and=20
> charset-unspecified text was scrubbed...
> Name: dovetail_kernel_event_trace_disable_sandbox.txt
> URL:=20
> <https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fxeno
> mai.org%2Fpipermail%2Fxenomai%2Fattachments%2F20211111%2Fe72ff993%2Fat
> tachment-0003.txt&amp;data=3D04%7C01%7Candouyuuta%40yamaha-motor.co.jp%7
> C42b7cfc69345461303a108d9a4f2e22f%7C76684a67d81643ce93f929b6f72f823f%7
> C1%7C0%7C637722185358232954%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DR0nq
> dSH8z9T2FPTv5fEN1zq7%2BWSv0Gw2tEzWjNKnGcc%3D&amp;reserved=3D0>
> -------------- next part -------------- An embedded and=20
> charset-unspecified text was scrubbed...
> Name: dovetail_strace.txt
> URL:=20
> <https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fxeno
> mai.org%2Fpipermail%2Fxenomai%2Fattachments%2F20211111%2Fe72ff993%2Fat
> tachment-0004.txt&amp;data=3D04%7C01%7Candouyuuta%40yamaha-motor.co.jp%7
> C42b7cfc69345461303a108d9a4f2e22f%7C76684a67d81643ce93f929b6f72f823f%7
> C1%7C0%7C637722185358232954%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D%2Bj
> 4eeKTcAZIphWYiJ406bnhYRQsrsSdgtRQJdqo2Bok%3D&amp;reserved=3D0>
> -------------- next part -------------- An embedded and=20
> charset-unspecified text was scrubbed...
> Name: dovetail_strace_disable_sandbox.txt
> URL:=20
> <https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fxeno
> mai.org%2Fpipermail%2Fxenomai%2Fattachments%2F20211111%2Fe72ff993%2Fat
> tachment-0005.txt&amp;data=3D04%7C01%7Candouyuuta%40yamaha-motor.co.jp%7
> C42b7cfc69345461303a108d9a4f2e22f%7C76684a67d81643ce93f929b6f72f823f%7
> C1%7C0%7C637722185358232954%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DYX9A
> 86Uza%2Bk8bcsuuZHQm9yDy5upAfj6l%2FnqvWy2W0I%3D&amp;reserved=3D0>


