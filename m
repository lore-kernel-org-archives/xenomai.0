Date: Tue, 28 May 2019 06:01:53 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1368542045.799892.1559041313687.JavaMail.zimbra@wolfram.com>
In-Reply-To: <81b1d78e-2835-7e53-3bd9-67e3e3f1daa8@siemens.com>
References: <1472936151.691343.1558942077593.JavaMail.zimbra@wolfram.com>
 <c3d7d4a5-6446-1109-1100-39dd83cf862e@siemens.com>
 <661761898.734873.1558973625401.JavaMail.zimbra@wolfram.com>
 <81b1d78e-2835-7e53-3bd9-67e3e3f1daa8@siemens.com>
Subject: Re: RTUdp incoming msg are ok but unable to send UDP
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>


----- Den 28 maj 2019, p=C3=A5 kl 8:45, Jan Kiszka jan.kiszka@siemens.com s=
krev:

> On 27.05.19 18:13, Per Oberg wrote:

> > ----- Den 27 maj 2019, p=C3=A5 kl 10:22, Jan Kiszka jan.kiszka@siemens.=
com skrev:

> >> On 27.05.19 09:27, Per Oberg via Xenomai wrote:
> >>> Hi folks

> >>> I am having some troubles with UDP and rtnet. I think it used to work=
, but I'm
> >>> not sure in what configuration. I had to update to meet some driver d=
emands and
> >>> now i am using the following versions:

> >>> Xenomai 3.0.7
> >>> ipipe-core-4.9.90-x86-6
> >>> Kernel 4.9.90


> >>> When trying to send a UDP message I got a kernel paging request error=
 so I tried
> >>> adding nosmap to the boot parameters. This solved the kernel paging b=
ug but no
> >>> messages are coming out.


> >>> Does anyone know if there went in some patches to rtudp lately that w=
ould fix
> >>> this?

> >>> Any other tips out there ?


> >> Can you try if the issue is also present in stable/v3.0.x or master?

>> At a first glance it looks like the bug is fixed. However, I couldn't ma=
ke it
>> work in 3.0.8 because of compilation issues with the kernel. In current =
master
> > it works however.


> Can you share the compilation issues? Either they have been fixed in git,=
 or
> they better should be before the next release.


I'm compiling using my own Yocto setup based on meta-xenomai from [1] below=
. For some reason I couldn't compile the kernel modules because of a missin=
g  rtdm/net.h. I noticed that there was a split in the git tree while back =
so I guess that's the original culprit.=20

However, I was never able to figure out if I had some old Xenomai-stuff lay=
ing around in the wrong places or if I forgot to update my sdk. Further, I =
was not able to get the actual compilation environment or see the real "cc =
commands". Instead of digging around further I decided to check master.

So, either Yocto kept the old kernel source or there is something else brok=
en in 3.0.8 compilation. I haven't been able to tell which is more likely. =
When I created my own 3.0.8a release files based on master it started worki=
ng again without cleaning anything else out.=20

This is one example of the error:
---------------------------------------------------------------------------=
---------------------------------------------
In file included from .../kernel-source/drivers/xenomai/net/stack/include/r=
tdev.h:37:0,
                 from .../kernel-source/drivers/xenomai/net/stack/include/r=
tnet_port.h:32,
                 from .../kernel-source/drivers/xenomai/net/drivers/8139too=
.c:54:
.../kernel-source/drivers/xenomai/net/stack/include/rtskb.h:32:10: fatal er=
ror: rtdm/net.h: No such file or directory
---------------------------------------------------------------------------=
---------------------------------------------

I just realized that I probably hit this bug: [2/3]. I knew I saw it somewh=
ere, but still couldn't fint it when I was looking yesterday.=20

Does anyone have a good idea on how to effectively search the mailing list =
?=20


> >> Jan

> >> PS: 4.9 is EOL by now.

>> Yes, I've been meaning to upgrade to 4.14, but I got the feeling there w=
as
> > something iffy going on for quite a while?


> What exactly do you mean?

Sorry for being unclear. With iffy I meant that I've been seeing some repor=
ts of issues people have had, and I was probably more wrong than right. It'=
s kind of hard to figure out afterwards if issues you only glanced on when =
they passed the mailing list was ever fixed, only a glitch, or something se=
rious. The bug-reporting system seems a bit under-used =3D)

Anyway, I was referring to these:
- [4] In my mind it was only yesterday it was released, but time flies.=20
- [5] with a follow up that it was also for real hardware
- [6] perhaps only amd issue ?
- [7] kvm only issue ?



> Jan

[1] https://bitbucket.org/pficheux/meta-xenomai/src
[2] https://www.xenomai.org/pipermail/xenomai/2019-February/040364.html
[3] https://www.xenomai.org/pipermail/xenomai/2019-May/040866.html
[4] https://www.xenomai.org/pipermail/xenomai/2018-October/039653.html
[5] https://www.xenomai.org/pipermail/xenomai/2019-March/040460.html
[6] https://www.xenomai.org/pipermail/xenomai/2019-March/040619.html
[7] https://www.xenomai.org/pipermail/xenomai/2019-April/040722.html

Per =C3=96berg=20

