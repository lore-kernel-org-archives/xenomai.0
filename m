Message-ID: <4C91E05E.6010202@domain.hid>
Date: Thu, 16 Sep 2010 11:16:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C91D29F.7020106@domain.hid>
In-Reply-To: <4C91D29F.7020106@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] (Not yet) Xenomai 2.5.5.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, Xenomai core <Xenomai-core@domain.hid>, Xenomai help <xenomai@xenomai.org>

Am 16.09.2010 10:17, Gilles Chanteperdrix wrote:
> 
> Hi,
> 
> I would like to make that next release of Xenomai, especially since the
> fix for the I-pipe on x86_32 with grub2 has been available for some time
> now, and has not yet been in a stable release.
> 
> So, I have a few minor questions:
> - Wolfgang, Alexis, it seems we have a few warnings when compiling
> rtcan/analogy tools with recent versions of gcc (4.4.1 from
> codesourcery). You will find the logs here:
> http://sisyphus.hd.free.fr/~gilles/pastebin/KVSBtb
> we are not in a hurry to fix this, so simply tell me if the fix is easy
> or not.
> - Alexis, from the mailing list discussions, you probably have some
> commits ready in the analoty branch, would it be possible to have a pull
> request for these?
> - Jan, where are we with CLOCK_HOST_REALTIME, are the I-pipe ready?
> Should I merge Wolfgang's patches, or the I-pipe/Xenomai interface has
> changed following the discussions with Philippe?

I've a ready-to-use version that should address all of Philippe's
remarks in my 2.6.35 queue [1]. The plan was to push it along this line,
but then things got stuck due to the 32-bit boot hang report by Ed
Hoffman (still waiting for further information from him). Also my KVM
patches in that queue do not work yet, but they will likely be postponed.

Besides that, I've longer queue of fixes and enhancement to Xenomai [2]
that partially depends on [1]. I already sent pull requests, but then
did not refresh it due to the dependency.

Unfortunately, I'm "a bit" short on time the next weeks, so we need to
find the cheapest way of getting the most important stuff merged for
2.5.5 I guess. I already started backporting the critical sync fixes for
I-pipe to 2.6.34 [3], just sent no pull request yet.

Jan

[1]
http://git.kiszka.org/?p=ipipe-2.6.git;a=shortlog;h=refs/heads/queues/2.6.35-x86
[2]
http://git.xenomai.org/?p=xenomai-jki.git;a=shortlog;h=refs/heads/for-upstream
[3]
http://git.kiszka.org/?p=ipipe-2.6.git;a=shortlog;h=refs/heads/queues/2.6.34-x86

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

