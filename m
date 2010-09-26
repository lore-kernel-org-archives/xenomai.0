MIME-Version: 1.0
In-Reply-To: <4C9F3163.4050106@domain.hid>
References: <AANLkTimFXFr48DgXSj=53pNjAQB7w+mjOwwuEYQXc3KV@mail.gmail.com>
	<4C9D0A94.9030501@domain.hid>
	<AANLkTikQi1+5F5e5x1om=4HMqmwc9twJ+ZtK-kWN8gnD@mail.gmail.com>
	<4C9DB383.1050606@domain.hid>
	<AANLkTikR8pc1w27pi11wA7rS-K6C3wzSQXkE33iKHfcX@mail.gmail.com>
	<4C9E6C21.8010403@domain.hid>
	<AANLkTimte2sxk535RfQ4M7b2gT4v1PJAzUiVB_nh7-zO@mail.gmail.com>
	<4C9F3163.4050106@domain.hid>
Date: Sun, 26 Sep 2010 14:38:21 +0200
Message-ID: <AANLkTimhq+2tOPJyK7tHjz=WYKYa8s+QU_FbV2GAVuyO@mail.gmail.com>
From: Gajamohan Mohanarajah <gajamohan.m@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] switchtest/xeon-test fails: Help needed
 (Ubuntu/Core i7)
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

Hi Gilles,

> Please capture the full kernel logs and post them here (do not forget to
> remove the "quiet" argument which ubuntu passes on the kernel command lin=
e).

I did this:
/boot/grub/grub.cfg (quiet removed)
linux   /boot/vmlinuz-2.6.32.15+drm33.5+xenomai-test
root=3DUUID=3D616a0432-f0f8-41e8-b470-de11405fa45a ro
crashkernel=3D384M-2G:64M,2G-:128M acpi=3Dforce

But can you please let me know how to capture the crash log.
Since the problem is with the hard disk, I cant think of any way to log.

Thanks
Gajan




> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>

