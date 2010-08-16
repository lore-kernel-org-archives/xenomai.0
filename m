Date: Mon, 16 Aug 2010 13:13:43 +0100 (BST)
From: edward.robbins@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4C65583D.3030800@domain.hid>
References: <1281709057.650414331@domain.hid> <4C65583D.3030800@domain.hid>
Message-ID: <1281960823.030215299@domain.hid>
Subject: Re: [Xenomai-help] Very high latencies under stress testing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

=0A=0AOn Friday, 13 August, 2010 3:35pm, "Gilles Chanteperdrix" <gilles.cha=
nteperdrix@domain.hid> said:=0A=0A> edward.robbins@domain.hid=
k wrote:=0A>>=0A>> I wonder if this is to do with graphics? I have set "NoA=
ccel" in the=0A>> driver section of Xorg.conf (I am using fbdev). I also no=
tice that=0A>> latencies go massive (e.g. 4200uS) the first time I run glxg=
ears.=0A>> "glxinfo" reports "Direct rendering: no".=0A> =0A> This is bad n=
ews. It could come either from the fact that the Xorg=0A> driver shuts hard=
ware interrupts off (there is nothing xenomai can do=0A> about that), or it=
 could be an SMI issue. What about using the driver=0A> for the real graphi=
c card you have ? Probably intel card? Do you observe=0A> any big latencies=
 if you stress the system with anything else than X?=0A> =0A>> Power manage=
ment options (ACPUI, APM): Disable ACPI (Advanced=0A>> Configuration and Po=
wer Interface) Support --> Processor Disable CPU=0A>> Frequency Scaling Dis=
able CPU idle PM support Disable Power Managment=0A>> Support=0A> =0A> Disa=
bling ACPI is a bad idea. As repeated many times, only=0A> ACPI_PROCESSOR s=
hould be disabled, not ACPI.=0A> =0A=0AThanks for your helpful responses.=
=0A=0AI'm not working on this project again until next week, but on Friday =
I was able to=0A=0A o Recompile the kernel with ACPI enabled =0A o Boot wit=
h the 'SMI handler' BIOS option set to disabled....=0A   according to the h=
elp text this option should be disabled if 'an RTOS =0A   is installed' - I=
 presume this means that SMIs are completely disabled =0A   and therefore S=
MIs cannot be the source of the problem =0A  (very convenient BIOS option..=
. now I begin to appreciate the expense of this board!) =0A o Changed xorg =
to use the intel video driver=0A=0AAfter doing this I still have problems w=
ith latencies and X, but did not have a chance to stress the system with no=
n-graphics tasks. I am thinking that when I get back to it next week I will=
 compile the kernel a few times and also try writing a large file a number =
of times to the disk as Philippe suggested. Hopefully this will not cause a=
ny problems and I can then more confidently attribute the high latency to t=
he graphics system. I will also attempt to install the I-pipe tracer as sug=
gested. I'll update when (if!?) I get that far.=0A=0AThanks=0AEdward


