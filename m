Date: Sat, 7 Dec 2019 10:19:44 +0100 (CET)
From: g.strobbe@telenet.be
Message-ID: <210878712.105504242.1575710384598.JavaMail.zimbra@telenet.be>
In-Reply-To: <CAOW0jKGnArrCBZ0gzHXXVUa+78m5pTK+VrROuoC5+pGJ2y_hWQ@mail.gmail.com>
References: <CAOW0jKGnArrCBZ0gzHXXVUa+78m5pTK+VrROuoC5+pGJ2y_hWQ@mail.gmail.com>
Subject: Re: [Xenomai] Rtnet driver of RTL8111/8168/8411
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wei Lou <highouse1990@gmail.com>
Cc: xenomai <xenomai@xenomai.org>



----- On Dec 6, 2019, at 8:30 AM, xenomai xenomai@xenomai.org wrote:

> How to update Rtnet driver of RTL8111/8168/8411

What I did to update the e1000e driver:

Find out on which mainline kernel driver version the old rtnet driver is based
upon. Compare the two to see what it involved to make the change.

It came down to what is described in this document:
https://gitlab.denx.de/Xenomai/xenomai/blob/master/kernel/drivers/net/doc/README.drvporting

Kompare that old mainline kernel driver to the latest version to see what has
been changed since then.

Decide if you would likely get a better end result 
by porting the newest mainline kernel driver to rtnet versus
upgrading the old rtnet driver version.

With the e1000e I choose to port the newest mainline kernel driver version to
rtnet.



