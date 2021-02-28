MIME-Version: 1.0
References: <CAFZ-hKipbe==Ca9FP5sbzO2QCamBp4vCbD3hfztcjV6-c_LF6A@mail.gmail.com>
In-Reply-To: <CAFZ-hKipbe==Ca9FP5sbzO2QCamBp4vCbD3hfztcjV6-c_LF6A@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sat, 27 Feb 2021 20:22:23 -0500
Message-ID: <CALLqZ8Qef6bxFp8oHbeGcujE_rXcrSePDbLsk=0hW6=+7fitAQ@mail.gmail.com>
Subject: Re: RTDM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leandro Bucci <guestleandro11@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Sat, Feb 27, 2021 at 7:44 PM Leandro Bucci via Xenomai <
xenomai@xenomai.org> wrote:

> hello everyone, after installing xenomai on the Raspberry and inserting t=
he
> kernel module related to the serial, in the folder / dev / rtdm / I don't
> have the rtser0 device.  How is it possible?
>
It=E2=80=99s possible that the device isn=E2=80=99t listed or enabled in th=
e device tree or
the device is in use by another driver. If it=E2=80=99s in use by another d=
river
you=E2=80=99ll have to unbind that driver and then the serial driver should=
 load.
This is all assuming that the device is properly configured in the device
tree.

Thanks

Greg
