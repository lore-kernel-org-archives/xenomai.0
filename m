Message-ID: <52EB6F47.3030403@xenomai.org>
Date: Fri, 31 Jan 2014 10:39:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1391006203.6916.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <201401301624.25756.paul_c@tuxcnc.org> <52EA816B.9060305@xenomai.org>
 <201401301957.54742.paul_c@tuxcnc.org> <52EAB676.7000103@xenomai.org>
 <1391159926.16255.YahooMailNeo@web163901.mail.gq1.yahoo.com>
In-Reply-To: <1391159926.16255.YahooMailNeo@web163901.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] debuild of xenomai failing: Directory nonexistent
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huub Van Niekerk <huubvanniekerk@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/31/2014 10:18 AM, Huub Van Niekerk wrote:
> Despite starting all over (tar jxf xenomai), downloading and patching
> again, debuild stops at exactly the same place. I still wonder why
> debuild on x86 (Ubuntu 10.04) worked great instantly and on armhf
> (Ubuntu 12.04) keeps ending in error. I just ran a test with standard
> "debuild -uc -us" on Ubuntu 12.04 x86 and it delivers the expected
> xenomai deb files without a problem. So why doesn't it do the same on
> armhf ?

As mentioned by Paul, the directories are supposed to be created by the
debian rules "dh_installdirs" helper, so my patch was in fact wrong, and
you have to understand why dh_installdirs does not do its job in your case.

-- 
                                                                Gilles.

