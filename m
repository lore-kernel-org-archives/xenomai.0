Message-ID: <4D9B33BA.5060807@domain.hid>
Date: Tue, 05 Apr 2011 17:22:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <COL122-W376680783697A8A880DC2BBDA20@domain.hid>
In-Reply-To: <COL122-W376680783697A8A880DC2BBDA20@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Tiny Core Linux + xenomai/RTAI
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: krishna m <krishnamurthyjs@domain.hid>
Cc: xenomai@xenomai.org

krishna m wrote:
> Has anyone tried applying Xenomai or RTAI patch to the tiny core
> Linux? Will it give a better performance compared to the plain
> vanilla Linux because the kernel footprint is small?

Let us make this clear, since apparently people still seem to wonder:
Xenomai only relies on the Linux kernel and the C library you use, it
does not care about any distribution. Whether tiny core, Ubuntu, Fedora,
Debian, Slackware, gentoo, it does not matter.

And since you still have not understood either, a reminder: the Xenomai
mailing lists are an old fashioned RFC 1855 plain text, 72 columns,
bottom posting, mailing list. So, please no HTML, no
multipart/alternative, no head-twisting long lines.

And no cross-posting with RTAI mailing list, most people are not
subscribed to the two lists, so will get mailer daemon errors when
posting to the mailing list they are not subscribed to.

-- 
					    Gilles.

