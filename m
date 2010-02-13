Message-ID: <4B76C045.2070602@domain.hid>
Date: Sat, 13 Feb 2010 16:07:49 +0100
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
References: <4B6E8167.6010907@domain.hid> <4B76B7F2.2050303@domain.hid>
In-Reply-To: <4B76B7F2.2050303@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai-core <xenomai@xenomai.org>

Hi Gilles,

first - I'm sorry if you sometimes feel offended by my work on Xenomai 
in Debian. I understand that you are very much connected to your project 
and want to have it working perfectly everywhere.

Unfortunately, my time to work on this is limited and the last uploads 
were work in progress - to provide latest Xenomai in Debian. Further 
work on it was planned for this weekend.

But please also understand that Debian developers will possibly 
prioritize work on upstream packages where they feel their work is 
appreciated. So please think about your tone before sending email and 
driving people away from Xenomai.

Gilles Chanteperdrix wrote:
> - the package ships with patches for 2.6.24. These I-pipe patches are
> outdated and have been publicly announced as being bogus on the Xenomai
> mailing lists;

Thanks for pointing that out! Will be removed.

> - xenomai 2.5.1 seems to have introduced a conflict with sigtest, my
> fault, you seem to have fixed this by prefixing all xenomai binaries
> with xenomai-, there was a simple solution which would have been for us
> to rename only sigtest.

First, I was thinking about this solution also, of course. But many of 
the Xenomai binaries' names are very generic and not easily recognizable 
as related to Xenomai ("latency", "arith", etc.).  (Please consider that 
there are 10000s of binaries in Debian's /usr/bin.) So I decided to 
rename them all, for consistency. Therefore, also "xenomai-xeno-config". 
:-) It's one exception. I was completely aware of this and also didn't 
find it very beautiful.

The alternative would have been a separate directory for them, e.g. 
somewhere under /usr/lib/xenomai. But that would lead to them not being 
available in user's PATHs. So I decided otherwise.

> This looks to me like a bad idea. You are breaking the documented user
> interface.

Feel free to make suggestions for improvement.

> I have already asked publicly for this, but will ask it once again:
> please inform the xenomai mailing list of the debian xenomai package
> bugs, and get us involved in their resolution.

I'm doing this if it concerns you. E.g. your non-PIC bug. Problems with 
Debian packaging are Debian's task. I'm open to all suggestions, but 
please CC me, I'm not following the Xenomai list so closely.

 > Because the debian packaging of xenomai simply do not
 > meets the quality standards of the Xenomai project.

Please stop. Debian sid is the equivalent of a development branch of 
Xenomai. It's unreleased code. I also don't flame you for bugs in 
Xenomai but instead send patches. So please let's work friendly each one 
on his own project and don't flame.

Thanks for considering.

bye,
   Roland


