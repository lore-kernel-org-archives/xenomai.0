Message-ID: <4E4FFD02.2060002@domain.hid>
Date: Sat, 20 Aug 2011 20:29:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHoMn5rnGNWdfOCkdSX_E=v=3gxxZ+Mm8AM69J5Togg6-aSpXQ@mail.gmail.com>	<4E4E29DB.3070904@domain.hid>	<CAHoMn5pdOi_CZUXj_57b2X3HGZKTux5b-_NMxJQ2b9pVbfwNYg@domain.hid>
	<CAHoMn5pW7OL3J7Oa55+=vpgV67Yjut+iq2=p9hP9L2EDo983HA@mail.gmail.com>
In-Reply-To: <CAHoMn5pW7OL3J7Oa55+=vpgV67Yjut+iq2=p9hP9L2EDo983HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Fwd:  building xenomai for AT91SAM9263
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: yi zheng <yizheng23@domain.hid>
Cc: xenomai@xenomai.org

On 08/20/2011 04:20 AM, yi zheng wrote:
>>
>>>> Hi,all
>>>>       i am a newer to xenomai.Now i want to build xenomai for my tar=
get
>>>> platform with AT91SAM9263 ARM and linux kernel vision 2.6.25.I use
>>>> arm-linux-gcc 3.4.1 for compiler,
>>>> is it suitable for build
>>>> xenomai=EF=BC=9Fwhich xenomai vision is better for me?
>>
>>> Xenomai 2.5.6 is the latest stable release, it should work. But I-pip=
e
>>> patches for later linux kernel releases have support for FCSE, which
>>> greatly improves latencies. As for the version of gcc, I have only be=
en
>>> using gcc 4 for a long time.
>>
>> --
>>
>=20
>=20
>=20
>>                                             Gilles.
>>
>      Hi Gilles
>            thank you for your kindly replying.I have used linux-2.6.25
> and Xenomai 2.4.4 today.I compiled both linux kernel and Xenomai

If you have no special reason for using such old versions, you should
probably use the latest releases. Really. Even if you are stuck  with
linux 2.6.25 (which probably means that the I-pipe patch you use does
not have the FCSE option), you can use Xenomai 2.5.6

how can i check out that Xenomai can run smoothly with my target
> platform.look forward to your reply.

Just run the latency test. But without FCSE, you will not get good
latencies.

--=20
                                                                Gilles.


