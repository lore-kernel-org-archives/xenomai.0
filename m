From: Josh Karch <JKarch@domain.hid>
Date: Thu, 10 Dec 2009 08:30:07 -0800
Message-ID: <843773D242212C4882D4EDFFBF665F7F0155A93AAD@FW-SBS.fw.local>
References: <843773D242212C4882D4EDFFBF665F7F0155A93A9D@FW-SBS.fw.local>,
	<4B1FE230.8070702@domain.hid>
	<843773D242212C4882D4EDFFBF665F7F0155A93AA7@domain.hid>,
	<4B1FEF97.9000509@domain.hid>
	<843773D242212C4882D4EDFFBF665F7F0155A93AAA@FW-SBS.fw.local>,
	<4B20C5DE.2040606@domain.hid>
In-Reply-To: <4B20C5DE.2040606@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai scheduling while atomic bug--debugging
	parameters
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan,

Our program ran without interruption last night with no bug, except it appe=
ars one still exists possibly regarding either ethernet (Intel e100), sshd,=
 nfsd, or as a result of running top.  It seems excessive network requests =
and calls to top and dmesg can trigger it.

Today I will recompile the kernel with all debugging options enabled,  make=
 the system run until the bug occurs, send you that .config file as well as=
 the current .config that still crashes on occasion (though the xenomai app=
lication runs rock solid in spite of the linux scheduling while atomic bugs=
). since the logs may be big, is there an ftp I can send them to or should =
I email those directly?

Thank you,

Joshua Karch


________________________________________
From: Jan Kiszka [jan.kiszka@domain.hid]
Sent: Thursday, December 10, 2009 1:56 AM
To: Josh Karch
Cc: xenomai@xenomai.org
Subject: Re: Xenomai scheduling while atomic bug--debugging   parameters

Josh Karch wrote:
> Hi Jan,
>
> I did a complete make mrproper on the system and recompiled without debug=
ging parameters,

mrproper is not required, the kernel is supposed to detect what needs to
be rebuild based on the .config changes.

> which took a few hours on the machine because the modules take up a lot. =
I probably should prune all unused modules (eg video, pcmcia, sound, etc) t=
hat I'm not using.

Yep.

>
> I guess I will have to back up my current /lib/modules/2.6.30.8 when I re=
compile with all debug support for that experiment, grab the data, and then=
 get that to you once my testing (hopefully) is successful on this change w=
ithout kernel debugging options.
>

Gilles already said this: We also need your .config to check if you are
stressing an uncommon configuration or if we are even able to reproduce
it locally.

Jan

--
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

