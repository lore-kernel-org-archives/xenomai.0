MIME-Version: 1.0
In-Reply-To: <1244824342.6786.21.camel@domain.hid>
References: <8bd0f97a0906081015k59a49a1dre38622401f011362@domain.hid> 
	<1244492079.7890.70.camel@domain.hid>
	<8bd0f97a0906120832h14f200f3rfbd66af868af7710@domain.hid> 
	<1244822047.7890.210.camel@domain.hid>
	<8bd0f97a0906120905r287665c7w883cf133743fc02f@domain.hid> 
	<1244824342.6786.21.camel@domain.hid>
From: Mike Frysinger <vapier.adi@domain.hid>
Date: Fri, 12 Jun 2009 12:42:00 -0400
Message-ID: <8bd0f97a0906120942r6171eaf5x6d057ac73d175a1f@domain.hid>
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

On Fri, Jun 12, 2009 at 12:32, Philippe Gerum wrote:
> On Fri, 2009-06-12 at 12:05 -0400, Mike Frysinger wrote:
>> On Fri, Jun 12, 2009 at 11:54, Philippe Gerum wrote:
>> > More specifically, which one shall I pull your changes from?
>>
>> boom:
>> http://git.kernel.org/?p=3Dlinux/kernel/git/vapier/blackfin.git;a=3Dshor=
tlog;h=3Dtrunk
>
> Hey, nice, you just allowed me to eat 738Mb of disk space!

hmm maybe i should run gc/pack on the tree and prune unreferenced objects.

>> currently i rebase this branch as i treat it as a set of patches on
>> top of the upstream branch. =C2=A0but if you only have one patch to
>> maintain against these sources, that shouldnt be too much of a problem
>> ... you can pop/push it ...
>>
>> if that really is a hassle for you though, i can look at making a
>> branch that is full of ugly merge commits and keep my patch series in
>> a different branch ...
>
> That should be ok; I have a single patch and this is fine as long as I
> am able to rebase it on the next tree; I don't need much linear history
> here. I will send the arch-dep part of it for inclusion as usual, the
> rest landing on the bfin_patch/ area IIRC.

git rebase has an --onto option which should let you do it.  git am -3
also does a pretty good job.  but if it does get to be a hassle, lemme
know.
-mike

