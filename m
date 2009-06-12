MIME-Version: 1.0
In-Reply-To: <1244822047.7890.210.camel@domain.hid>
References: <8bd0f97a0906081015k59a49a1dre38622401f011362@domain.hid> 
	<1244492079.7890.70.camel@domain.hid>
	<8bd0f97a0906120832h14f200f3rfbd66af868af7710@domain.hid> 
	<1244822047.7890.210.camel@domain.hid>
From: Mike Frysinger <vapier.adi@domain.hid>
Date: Fri, 12 Jun 2009 12:05:55 -0400
Message-ID: <8bd0f97a0906120905r287665c7w883cf133743fc02f@domain.hid>
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

On Fri, Jun 12, 2009 at 11:54, Philippe Gerum wrote:
> On Fri, 2009-06-12 at 11:32 -0400, Mike Frysinger wrote:
>> On Mon, Jun 8, 2009 at 16:14, Philippe Gerum wrote:
>> > On Mon, 2009-06-08 at 13:15 -0400, Mike Frysinger wrote:
>> >> i just finished converting Blackfin to the new irqflags.h system whic=
h
>> >> included punting pretty much all of the irq.h guts (including IPIPE).
>> >> since irqflags.h is directly designed for hooking the lower irq stuff=
,
>> >> do we still need this stuff patched into the Blackfin code ? =C2=A0se=
ems
>> >> like patching linux/irqflags.h would get you support for pretty much
>> >> all arches for free ...
>> >
>> > I wish it was so, but we do need to override the native routines that
>> > manipulate the hw interrupt state when the I-pipe is enabled, and usin=
g
>> > the irqflags framework will still require the implementation to provid=
e
>> > the raw_local_irq* helpers linux/irqflags.h requires, in some arch-dep
>> > companion file for the Blackfin. This is the one we want to patch for
>> > the I-pipe, to get them virtualized.
>>
>> well ive just tossed the code for 2.6.31 since it's pretty hopeless
>> for me to get this right. =C2=A0consider yourself notified ! ;)
>
> Ok, I now consider myself in trouble then.
>
> Btw, could you give me some hints regarding the Blackfin project policy
> for updating svn://sources.blackfin.uclinux.org/linux-kernel and/or
> git://sources.blackfin.uclinux.org/git/readonly-mirrors/linux-kernel.git?
> Is the latter still a pre-mainline staging tree pulling from the former?

let's just forget about that stuff from now on (or at least as long as
i'm handling the tree)

> More specifically, which one shall I pull your changes from?

boom:
http://git.kernel.org/?p=3Dlinux/kernel/git/vapier/blackfin.git;a=3Dshortlo=
g;h=3Dtrunk

currently i rebase this branch as i treat it as a set of patches on
top of the upstream branch.  but if you only have one patch to
maintain against these sources, that shouldnt be too much of a problem
... you can pop/push it ...

if that really is a hassle for you though, i can look at making a
branch that is full of ugly merge commits and keep my patch series in
a different branch ...

> (the blackfin.uclinux.org seems currently unreachable).

ugh, rogers in canada really blows sometimes.  this isnt the first
time they screwed up routing and sent things into an infinite loop.
-mike

