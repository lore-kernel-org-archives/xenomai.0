MIME-Version: 1.0
In-Reply-To: <1244492079.7890.70.camel@domain.hid>
References: <8bd0f97a0906081015k59a49a1dre38622401f011362@domain.hid> 
	<1244492079.7890.70.camel@domain.hid>
From: Mike Frysinger <vapier.adi@domain.hid>
Date: Fri, 12 Jun 2009 11:32:36 -0400
Message-ID: <8bd0f97a0906120832h14f200f3rfbd66af868af7710@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] irq hooking and irqflags
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Jun 8, 2009 at 16:14, Philippe Gerum wrote:
> On Mon, 2009-06-08 at 13:15 -0400, Mike Frysinger wrote:
>> i just finished converting Blackfin to the new irqflags.h system which
>> included punting pretty much all of the irq.h guts (including IPIPE).
>> since irqflags.h is directly designed for hooking the lower irq stuff,
>> do we still need this stuff patched into the Blackfin code ? =C2=A0seems
>> like patching linux/irqflags.h would get you support for pretty much
>> all arches for free ...
>
> I wish it was so, but we do need to override the native routines that
> manipulate the hw interrupt state when the I-pipe is enabled, and using
> the irqflags framework will still require the implementation to provide
> the raw_local_irq* helpers linux/irqflags.h requires, in some arch-dep
> companion file for the Blackfin. This is the one we want to patch for
> the I-pipe, to get them virtualized.

well ive just tossed the code for 2.6.31 since it's pretty hopeless
for me to get this right.  consider yourself notified ! ;)
-mike

