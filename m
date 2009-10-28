MIME-Version: 1.0
In-Reply-To: <4AE860FB.4090903@domain.hid>
References: <b88603c30910280734i7a823063s75b420720fdf3707@domain.hid>
	<4AE858F0.4010600@domain.hid>
	<b88603c30910280753uea312e1p3d5f62012814d355@domain.hid>
	<4AE860FB.4090903@domain.hid>
Date: Wed, 28 Oct 2009 16:25:24 +0100
Message-ID: <b88603c30910280825t39954bddl48f33c76181b9938@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Read TSC results in bus error (ARM iMX25)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

Hi Gilles,

I found the problem.

There seems to be a sw-workaround needed to access the peripherals in
user-mode. It is implemented in cpu.c, which the bsp for the iMX25 did
not have, but the iMX3 has. I implemented the post_cpu_init() call for
the iMX25 and now the access is fine.

Thanks for your reply!

On Wed, Oct 28, 2009 at 4:19 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Henri Roosen wrote:
>> Hi Gilles,
>>
>> Thanks for the quick response! Please find attached the .config
>
> Ok. I can not find anything about /dev/mem in the kernel configuration.
> I wonder where I saw this.
>
> If you are sure that the physical address is correct, then maybe the MMU
> parameter are incorrect. In xeno_arm_features_check, could you try to
> open /dev/mem without the O_SYNC flag, and see if it does not change
> anything ?
>
> If it does not work, I am afraid you will have to configure Xenomai
> user-space with --enable-arm-mach=3Dgeneric, in which case the tsc
> emulation in user-space will be disabled.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0Gilles
>
>

