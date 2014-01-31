From: Paul <paul_c@tuxcnc.org>
Date: Fri, 31 Jan 2014 14:12:40 +0000
References: <1391006203.6916.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <52EAB676.7000103@xenomai.org>
 <1391159926.16255.YahooMailNeo@web163901.mail.gq1.yahoo.com>
In-Reply-To: <1391159926.16255.YahooMailNeo@web163901.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201401311412.40855.paul_c@tuxcnc.org>
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

On Friday 31 January 2014, Huub Van Niekerk wrote:
> Despite starting all over (tar jxf xenomai), downloading and patching
> again, debuild stops at exactly the same place. I still wonder why
> debuild on x86 (Ubuntu 10.04) worked great instantly and on armhf
> (Ubuntu 12.04) keeps ending in error. I just ran a test with standard
> "debuild -uc -us" on Ubuntu 12.04 x86 and it delivers the expected
> xenomai deb files without a problem. So why doesn't it do the same on
> armhf ?

This is sounding more like a bug either in Ubuntu 12.04 or some 
peculiarities with this particular armhf flavour rather than a Xenomai 
issue.

If Gilles is OK with this, I can work with Huub off list to identify the 
issue and post back to the list with a resolution.


Regards, Paul.

