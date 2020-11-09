MIME-Version: 1.0
References: <CAAvDm6a_at2CeQy4RZvYNBeBUoPbryHLhVrDqSiyWWr0vkO68g@mail.gmail.com>
 <1390643975.688480.1604913731849.JavaMail.zimbra@wolfram.com>
In-Reply-To: <1390643975.688480.1604913731849.JavaMail.zimbra@wolfram.com>
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Mon, 9 Nov 2020 19:46:06 +0800
Message-ID: <CAAvDm6ZRxC76mwz_v75fmLzPEfzyJfpuPv01oxP5YasbpADPGw@mail.gmail.com>
Subject: Re: Is it possible to enable rt Can devices and non-rt Can devices at
 the same time on the Linux+Xenomai platform?
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
To: Per Oberg <pero@wolfram.com>
Cc: xenomai <xenomai@xenomai.org>

There are two user application programs on the Linux+Xenomai platform.
I want that one program uses a rt Can device and the other one uses a
non-rt Can device.

On Mon, Nov 9, 2020 at 5:22 PM Per Oberg via Xenomai
<xenomai@xenomai.org> wrote:
>
>
> ----- Den 9 nov 2020, p=C3=A5 kl 2:35, xenomai xenomai@xenomai.org skrev:
>
> > Hi, list
>
> > Is it possible to enable rt Can devices and non-rt Can devices at the
> > same time on the Linux+Xenomai platform?
>
> > What about ethernet devices?
>
> I Can't see any reason why this shouldn't work, so YES!
>
> If you are using the POSIX skin and you want to access both variants in t=
he same code-base there may be some quirks you need to work around (i.e. pi=
cking the right one to open). And if you access them both in the same threa=
d you will break real time constraints but that hardly needs saying.
>
> However, if you are using the same brand of devices for both cases you ne=
ed to make sure the driver only initializes the hardware you want it to ini=
tialize. E.g. if you load the regular linux igb ethernet driver it will ini=
tialize all igb compatible hardware to be non realtime.
>
> For some drivers, you can pass options to make it only initialize some of=
 the devices. The modinfo command will give you a parameter list for each d=
river.  If you need to play around with it you can blacklist the relevant d=
rivers by putting stuff in the modprobe.d directory. You can then load the =
drivers manually using the regular modprobe cmd.
>
> > Thank you for your attention to my question.
> > Best regards.
> > Sunshilong
>
> Per =C3=96berg
>

