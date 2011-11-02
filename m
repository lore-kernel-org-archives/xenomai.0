MIME-Version: 1.0
In-Reply-To: <4EB16341.2060103@domain.hid>
References: <CAAeYjMmZxEkFRfKx8DPUen+RtzijdBn3PTBLkMNjbP74K_c84w@domain.hid>
	<4EB16341.2060103@domain.hid>
From: =?UTF-8?Q?=C5=81ukasz_Sacha?= <dragilla@domain.hid>
Date: Wed, 2 Nov 2011 16:45:06 +0100
Message-ID: <CAAeYjMkubri9yPX1wbHyWwC3aLyLWPESoaW7irtzFyQqi1m-JA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] error messages
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Nov 2, 2011 at 16:35, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 11/02/2011 01:15 AM, =C5=81ukasz Sacha wrote:
>> I managed to install xenoami 2.5.6 on my mini (with kernel 2.6.35.9).
>> However I'm having problems even running the test scripts.
>> For example the ouput of xeno-test is provided as an attachment, it
>> looks somewhat like this:
>>
>> /usr/xenomai/bin/xeno-load: line 247: /usr/xenomai/bin/latency: not foun=
d
>>
>> /usr/xenomai/bin # ls -al latency
>> -rwxr-xr-x =C2=A0 =C2=A01 root =C2=A0 =C2=A0 root =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 29528 Nov =C2=A01 =C2=A02011 latency
>>
>> Any hint on what's causing the errors?
>
> Mismatch between libraries in the toolchain, and libraries installed?
> Especially the loader ld-linux.so. Please try and copy ldd to the board
> filesystem and try the command:
> ldd /usr/xenomai/bin/latency
>
> --
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Gilles.
>
>

Yes, that was it. Now it works. Thank you.
--
=C5=81ukasz Dragilla Sacha

