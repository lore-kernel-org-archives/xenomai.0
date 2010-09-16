Message-ID: <4C91D29F.7020106@domain.hid>
Date: Thu, 16 Sep 2010 10:17:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] (Not yet) Xenomai 2.5.5.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>, Alexis Berlemont <berlemont.hauw@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>, Xenomai core <Xenomai-core@domain.hid>


Hi,

I would like to make that next release of Xenomai, especially since the
fix for the I-pipe on x86_32 with grub2 has been available for some time
now, and has not yet been in a stable release.

So, I have a few minor questions:
- Wolfgang, Alexis, it seems we have a few warnings when compiling
rtcan/analogy tools with recent versions of gcc (4.4.1 from
codesourcery). You will find the logs here:
http://sisyphus.hd.free.fr/~gilles/pastebin/KVSBtb
we are not in a hurry to fix this, so simply tell me if the fix is easy
or not.
- Alexis, from the mailing list discussions, you probably have some
commits ready in the analoty branch, would it be possible to have a pull
request for these?
- Jan, where are we with CLOCK_HOST_REALTIME, are the I-pipe ready?
Should I merge Wolfgang's patches, or the I-pipe/Xenomai interface has
changed following the discussions with Philippe?

Thanks in advance.

-- 
					    Gilles.

