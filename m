Date: Mon, 9 Nov 2020 09:28:43 -0600 (CST)
From: Per Oberg <pero@wolfram.com>
Message-ID: <162703384.737337.1604935723078.JavaMail.zimbra@wolfram.com>
In-Reply-To: <CAAvDm6ZRxC76mwz_v75fmLzPEfzyJfpuPv01oxP5YasbpADPGw@mail.gmail.com>
References: <CAAvDm6a_at2CeQy4RZvYNBeBUoPbryHLhVrDqSiyWWr0vkO68g@mail.gmail.com>
 <1390643975.688480.1604913731849.JavaMail.zimbra@wolfram.com>
 <CAAvDm6ZRxC76mwz_v75fmLzPEfzyJfpuPv01oxP5YasbpADPGw@mail.gmail.com>
Subject: Re: Is it possible to enable rt Can devices and non-rt Can devices
 at the same time on the Linux+Xenomai platform?
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
To: =?utf-8?B?5a2Z5LiW6b6Z?= sunshilong <sunshilong369@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

----- Den 9 nov 2020, p=C3=A5 kl 12:46, =E5=AD=99=E4=B8=96=E9=BE=99 sunshil=
ong sunshilong369@gmail.com skrev:

> There are two user application programs on the Linux+Xenomai platform.
> I want that one program uses a rt Can device and the other one uses a
> non-rt Can device.

Then it all comes down to the actual choice of hardware. For ethernet many =
motherboards with dual ports come with different NICs for the different por=
ts. This simplifies it a bit because you can easily choose what drivers to =
load. For CAN i have only tried with different versions of PEAK hardware an=
d that has worked well. In my case though I had USB devices for the non RT =
part, and the RT driver completely ignores the USB hardware so it worked st=
raight out of the box.

> On Mon, Nov 9, 2020 at 5:22 PM Per Oberg via Xenomai
> <xenomai@xenomai.org> wrote:


> > ----- Den 9 nov 2020, p=C3=A5 kl 2:35, xenomai xenomai@xenomai.org skre=
v:

> > > Hi, list

> > > Is it possible to enable rt Can devices and non-rt Can devices at the
> > > same time on the Linux+Xenomai platform?

> > > What about ethernet devices?

> > I Can't see any reason why this shouldn't work, so YES!

>> If you are using the POSIX skin and you want to access both variants in =
the same
>> code-base there may be some quirks you need to work around (i.e. picking=
 the
>> right one to open). And if you access them both in the same thread you w=
ill
> > break real time constraints but that hardly needs saying.

>> However, if you are using the same brand of devices for both cases you n=
eed to
>> make sure the driver only initializes the hardware you want it to initia=
lize.
>> E.g. if you load the regular linux igb ethernet driver it will initializ=
e all
> > igb compatible hardware to be non realtime.

>> For some drivers, you can pass options to make it only initialize some o=
f the
>> devices. The modinfo command will give you a parameter list for each dri=
ver. If
>> you need to play around with it you can blacklist the relevant drivers b=
y
>> putting stuff in the modprobe.d directory. You can then load the drivers
> > manually using the regular modprobe cmd.

> > > Thank you for your attention to my question.
> > > Best regards.
> > > Sunshilong

> > Per =C3=96berg

Best regards
Per =C3=96berg

