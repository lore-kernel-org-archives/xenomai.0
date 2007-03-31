Subject: Re: [Xenomai-help] Xenomai 2.3.1 - /proc/xenomai/affinity?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <3496271.1175094118017.JavaMail.ngmail@domain.hid>
References: <3496271.1175094118017.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Sat, 31 Mar 2007 19:01:06 +0200
Message-Id: <1175360467.20140.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-03-28 at 17:01 +0200, M. Koehrer wrote:
> Hi everybody,
> 
> I wonder why the really nice feature to set the CPU affinity via /proc/xenomai/affinity 
> is not part of 2.3.1 as this  is in subversion for a long time now...
> 

Because we neither add nor remove features to/from stable revisions.
These are aimed at bug fixing only.

> Or: How can I enable this nice feature for the 2.3.1?
> I had a nice patch (extracted from SVN) that worked with 2.3.0 but the patch fails for 2.3.1...
> 

Conflicts may be solved by hand.

> Thanks for any response on that issue.
> 
> Regards
> 
> Mathias
> 
-- 
Philippe.



