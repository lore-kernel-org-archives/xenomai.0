MIME-Version: 1.0
In-Reply-To: <4AE86335.5030106@domain.hid>
References: <b88603c30910280734i7a823063s75b420720fdf3707@domain.hid>
	<4AE858F0.4010600@domain.hid>
	<b88603c30910280753uea312e1p3d5f62012814d355@domain.hid>
	<4AE860FB.4090903@domain.hid>
	<b88603c30910280825t39954bddl48f33c76181b9938@domain.hid>
	<4AE86335.5030106@domain.hid>
Date: Wed, 28 Oct 2009 17:17:18 +0100
Message-ID: <b88603c30910280917x1eaa89f2q26c7283e381d05f1@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This code is part of the iMX25 bsp that is not part of any kernel yet,
so generating a patch is not possible. Seems the upcoming 2.6.32
kernel will have support for iMX25, but the -rc5 still has
build-failures for this platform.

Maybe the complete BSP with ipipe for the iMX25 and 2.6.28 kernel
might be interesting for release (similar as the patch
ipipe-2.6.26-mxc.diff), but is still in an early development state:
now the latency app runs I see it runs fine only for a few minutes and
then gets overruns... asks for debugging ;-)

Please let me know if someone is interested to co-develop this bsp with Xen=
omai.

Henri

On Wed, Oct 28, 2009 at 4:28 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Henri Roosen wrote:
>> Hi Gilles,
>>
>> I found the problem.
>>
>> There seems to be a sw-workaround needed to access the peripherals in
>> user-mode. It is implemented in cpu.c, which the bsp for the iMX25 did
>> not have, but the iMX3 has. I implemented the post_cpu_init() call for
>> the iMX25 and now the access is fine.
>>
>> Thanks for your reply!
>
> Could you send me a patch? We will put this in the I-pipe patch.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0Gilles
>
>

