From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B76C045.2070602@domain.hid>
References: <4B6E8167.6010907@domain.hid> <4B76B7F2.2050303@domain.hid>
	<4B76C045.2070602@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 14 Feb 2010 10:38:49 +0100
Message-ID: <1266140329.27019.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai in Debian
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roland Stigge <stigge@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>


Hi Roland,

On Sat, 2010-02-13 at 16:07 +0100, Roland Stigge wrote: 
> Hi Gilles,
> 
> first - I'm sorry if you sometimes feel offended by my work on Xenomai 
> in Debian. I understand that you are very much connected to your project 
> and want to have it working perfectly everywhere.
> 
> Unfortunately, my time to work on this is limited and the last uploads 
> were work in progress - to provide latest Xenomai in Debian. Further 
> work on it was planned for this weekend.
> 
> But please also understand that Debian developers will possibly 
> prioritize work on upstream packages where they feel their work is 
> appreciated. So please think about your tone before sending email and 
> driving people away from Xenomai.
> 
> Gilles Chanteperdrix wrote:
> > - the package ships with patches for 2.6.24. These I-pipe patches are
> > outdated and have been publicly announced as being bogus on the Xenomai
> > mailing lists;
> 
> Thanks for pointing that out! Will be removed.
> 
> > - xenomai 2.5.1 seems to have introduced a conflict with sigtest, my
> > fault, you seem to have fixed this by prefixing all xenomai binaries
> > with xenomai-, there was a simple solution which would have been for us
> > to rename only sigtest.
> 
> First, I was thinking about this solution also, of course. But many of 
> the Xenomai binaries' names are very generic and not easily recognizable 
> as related to Xenomai ("latency", "arith", etc.).  (Please consider that 
> there are 10000s of binaries in Debian's /usr/bin.) So I decided to 
> rename them all, for consistency. Therefore, also "xenomai-xeno-config". 
> :-) It's one exception. I was completely aware of this and also didn't 
> find it very beautiful.
> 
> The alternative would have been a separate directory for them, e.g. 
> somewhere under /usr/lib/xenomai. But that would lead to them not being 
> available in user's PATHs. So I decided otherwise.
> 
> > This looks to me like a bad idea. You are breaking the documented user
> > interface.
> 
> Feel free to make suggestions for improvement.
> 
> > I have already asked publicly for this, but will ask it once again:
> > please inform the xenomai mailing list of the debian xenomai package
> > bugs, and get us involved in their resolution.
> 
> I'm doing this if it concerns you. E.g. your non-PIC bug. Problems with 
> Debian packaging are Debian's task. I'm open to all suggestions, but 
> please CC me, I'm not following the Xenomai list so closely.
> 
>  > Because the debian packaging of xenomai simply do not
>  > meets the quality standards of the Xenomai project.
> 
> Please stop. Debian sid is the equivalent of a development branch of 
> Xenomai. It's unreleased code. I also don't flame you for bugs in 
> Xenomai but instead send patches. So please let's work friendly each one 
> on his own project and don't flame.
> 

Ok, let's end the ballistic game. I think Gilles is very concerned by
the fact that introducing inconsistencies or any ambiguity in downstream
packages will certainly backfire upstream, with endless posting on the
xenomai mailing lists from users being lost in space. Which makes sense.

Personally, I would really recommend to move the Xenomai stuff in its
own sub-dir whenever possible, as a first remedy; requiring PATH update
is much better than forking the Xenomai namespace.
In the future, maybe we could simply provide a wrapper script accepting
sub-commands, such as "xeno latency, xeno sigtest" etc, to be put
into /usr/bin by distros, which would hide the actual location of those
binaries?

In any case, thanks for your work so far. We probably need to discuss
the packaging issues on this list, so that we get both consistency and
usability in the future.

Gilles and Roland, if this is fine with you, I'll handle the liaison
role with upstream packagers, so please CC me explicitly on those mails.
We'll sort out this issue, it doesn't look that bad anyway.

-- 
Philippe.



