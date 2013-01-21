Message-ID: <1358809464.75419.YahooMailNeo@web140601.mail.bf1.yahoo.com>
Date: Mon, 21 Jan 2013 15:04:24 -0800 (PST)
From: A User <t02446@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] x86 Linux with xenomai and i915 graphics stall
Reply-To: A User <t02446@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I'm trying to run a Linux/Xenomai system with Ubuntu 12.04 LTS=0Adistro inc=
luding X Window System on an Intel x86 board.=0A=0Alinux: 3.2.21=0Axenomai:=
 2.6.1=0Ai-pipe Patch: 3.2.21-x86-1=0A=0AAt present, the board I am testing=
 is a DFI-Itox CR100-CRM with an i5=0ACPU, it has Intel HD Graphics 4000, a=
nd runs the Linux i915 driver.=0A=0ALess interesting to you, but useful for=
 me, it has mini-PCIe,=0Aa handful of rs232s, and mini-ITX form factor.=0A=
=0AFollowing the Xenomai x86 config advice, I turn off CONFIG_PCI_MSI=0A=0A=
http://www.xenomai.org/index.php/Configuring_x86_kernels#Message_Signaled_I=
nterrupts_.28MSI_and_MSI-X.29=0A=0AWhen I build, install, and boot, the X W=
indow system is sluggish on=0Aabout 1/4 to 1/2 the boots.=A0 When it is slu=
ggish, graphics will freeze=0Auntil I wiggle the mouse.=A0 When this happen=
s, I get this in dmesg,=0Aseveral times per minute:=0A=0A[drm:i915_hangchec=
k_ring_idle] ERROR Hangcheck timer elapsed... render ring idle [waiting on =
1403, at 1403], missed IRQ?=0A=0AGoogling suggests that when this bug appea=
red in the Intel driver,=0Athe code involved MSI:=0A=0Ahttps://patchwork.ke=
rnel.org/patch/879522/=0A=0A+ if (IS_GEN6(dev))=0A+ /* allow blitter user i=
nterrupt to generate a MSI write from=0A+ the ISR */=0A+ I915_WRITE(GEN6_BL=
ITTER_HWSTAM,=0A+ 0xffffffff & ~GEN6_BLITTER_USER_INTERRUPT);=0A=0AThere ar=
e a few hits about GPU stalling on Linux kernel and and Intel=0Agraphics ma=
ilings lists when you google for "i915 msi gen6" or=0Ai915_hangcheck_ring_i=
dle (mostly from mid-2011).=0A=0AI have tried various other hacks to try to=
 work around this problem,=0Athere are bug fix discussion threads that sugg=
est turning off:=0A=0A=A0 /sys/module/i915/parameters/semaphores=0A=A0 or=
=0A=A0 /sys/modules/i915/parameters/i915_enable_rc6=0A=0Abut these did not =
work for me.=0A=0AIt seems that for me, if the bug appears, it appears imme=
diately at=0Aboot time, and if it does not appear, it does not appear again=
 until reboot,=0Abut I am not fully sure of this.=0A=0AWhen I run with CONF=
IG_PCI_MSI turned off, I get good Xenomai latency,=0Abut the X Window Syste=
m is unusable.=A0 With MSI turned on, graphics is=0Asolid, but latency jump=
s to about 450 usec when I run glxgears=0A(instead of avg 10 usec, max 50 u=
sec).=0A=0AI believe that if I want to use X Window system in a recent x86 =
system=0Awith motherboard graphics, the most popular choice (the only choic=
e?)=0Ais i915.=0A=0ADo you have any advice on how I can run with i915 and X=
enomai with=0Athis hardware and software?=0A=0A-Andy=0A

