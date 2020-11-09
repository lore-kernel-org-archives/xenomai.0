Date: Mon, 9 Nov 2020 03:22:11 -0600 (CST)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1390643975.688480.1604913731849.JavaMail.zimbra@wolfram.com>
In-Reply-To: <CAAvDm6a_at2CeQy4RZvYNBeBUoPbryHLhVrDqSiyWWr0vkO68g@mail.gmail.com>
References: <CAAvDm6a_at2CeQy4RZvYNBeBUoPbryHLhVrDqSiyWWr0vkO68g@mail.gmail.com>
Subject: Re: Is it possible to enable rt Can devices and non-rt Can devices
 at the same time on the  Linux+Xenomai platform?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>


----- Den 9 nov 2020, p=C3=A5 kl 2:35, xenomai xenomai@xenomai.org skrev:

> Hi, list

> Is it possible to enable rt Can devices and non-rt Can devices at the
> same time on the Linux+Xenomai platform?

> What about ethernet devices?

I Can't see any reason why this shouldn't work, so YES!

If you are using the POSIX skin and you want to access both variants in the=
 same code-base there may be some quirks you need to work around (i.e. pick=
ing the right one to open). And if you access them both in the same thread =
you will break real time constraints but that hardly needs saying.=20

However, if you are using the same brand of devices for both cases you need=
 to make sure the driver only initializes the hardware you want it to initi=
alize. E.g. if you load the regular linux igb ethernet driver it will initi=
alize all igb compatible hardware to be non realtime.=20

For some drivers, you can pass options to make it only initialize some of t=
he devices. The modinfo command will give you a parameter list for each dri=
ver.  If you need to play around with it you can blacklist the relevant dri=
vers by putting stuff in the modprobe.d directory. You can then load the dr=
ivers manually using the regular modprobe cmd.

> Thank you for your attention to my question.
> Best regards.
> Sunshilong

Per =C3=96berg=20

