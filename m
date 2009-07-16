MIME-Version: 1.0
In-Reply-To: <4A5F3ED3.20608@domain.hid>
References: <b88603c30907130031v9ec9618r46bd28b494ac3417@domain.hid>
	<4A5EE47E.5000507@domain.hid>
	<b88603c30907160224o7a0ebde0w6d52016dc40fccbe@domain.hid>
	<4A5EF277.8090304@domain.hid>
	<b88603c30907160239u3417036g1fa21251e7d4a379@domain.hid>
	<4A5EF6E1.80108@domain.hid>
	<b88603c30907160325k693081efi63b92b4e5f5a2e06@domain.hid>
	<4A5F058B.2090808@domain.hid>
	<b88603c30907160544q54968965q20c185bd1deae25a@domain.hid>
	<4A5F3ED3.20608@domain.hid>
Date: Thu, 16 Jul 2009 17:09:17 +0200
Message-ID: <b88603c30907160809m1b186d12p6e58e3f578d3aed4@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] ARM: userspace apps result in Segmentation fault
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

Unfortunately enabling the CONFIG_VFP in the kernel config and
building the xenomai with CFLAGS=3D"-mfpu=3Dvfp -mfloat-abi=3Dsoftfp"
LDFLAGS=3D"-mfpu=3Dvfp -mfloat-abi=3Dsoftfp" had no success and results in =
a
system hang-up again. The only thing that works for me is disabling
the CONFIG_VFP in the kernel with -msoft-float for the xenomai user
build.

Thanks,
Henri.

On Thu, Jul 16, 2009 at 4:53 PM, Gilles
Chanteperdrix<gilles.chanteperdrix@xenomai.org> wrote:
> Henri Roosen wrote:
>> Hi Gilles,
>>
>> I disabled the CONFIG_VFP and build userspace with -msoft-float. The
>> xenomai test apps now work!!
>> I will also try to enable the VFP again because the ARM926EJ-S should
>> have a VFP and then use the other flags.
>
> Ok. Please tell us if it works so that I can modify the makefile to
> enable vfp with at91sam926x on head...
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0Gilles
>
>

