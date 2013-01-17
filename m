From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Thu, 17 Jan 2013 16:55:02 +0100
References: <50F7DB33.7000902@siemens.com>
	<201301171500.43290.leo@alaxarxa.net>
	<50F8056A.2020701@xenomai.org>
In-Reply-To: <50F8056A.2020701@xenomai.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201301171655.03019.leo@alaxarxa.net>
Subject: Re: [Xenomai] core-3.5 vs. core-3.5.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

A Dijous 17 Gener 2013, Philippe Gerum va escriure:
> On 01/17/2013 03:00 PM, Leopold Palomo-Avellaneda wrote:
> > A Dijous 17 Gener 2013, Philippe Gerum va escriure:
> >> On 01/17/2013 12:06 PM, Jan Kiszka wrote:
> > [....]
> >
> >> powerpc* and bfin will have support for kernel 3.5.7 in the upcoming
> >> 2.6.2.1.
> >
> > 2.6.2.1 ?
> >
> > what's about to have a 2.6.3? IMHO four version numbers is a bit excessive 
...
> >
> 
> It's not about how many numbers you put in the release tag, this is 
> about what you put in the release. The next release is a fix up for 
> brown paper bag issues in 2.6.2, not a full fledged upgrade with 
> significant functional updates.

I know, but _always_ all of this kind of stuff is relative. I think that 
looking on the xenomai audience you don't need a:

> a full fledged upgrade with significant functional updates

to put a 2.6.3. You can say:

we release a new version with all the fixes of 2.6.2

I see looking on [1] the xenomai history some version with 4 numbers. But, 
IMHO all this kind of stuff is a convention and it's not necessary to be so 
strict with the last number. It's binary compatible, you don't have changed 
the ABI ...

Just my 2 ct.

Regards,


Leo


[1] http://www.xenomai.org/index.php/Xenomai:News



-- 
--
Linux User 152692
Catalonia

