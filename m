Date: Mon, 9 Mar 2015 13:13:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150309121359.GF17373@hermes.click-hack.org>
References: <CA+C+_XSBhPvzuLqrUTLzR63-bu0NsvCZ_u17domFcBy0dTZceQ@mail.gmail.com>
 <20150308153852.GD5998@hermes.click-hack.org>
 <39462913-7C37-406F-B15C-F1264410BE46@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39462913-7C37-406F-B15C-F1264410BE46@gmail.com>
Subject: Re: [Xenomai] rt_mutex_acquire() timing out
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathew Benson <mathew.benson@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Mar 09, 2015 at 06:56:08AM -0500, Mathew Benson wrote:
> I haven't tried yet. To simplify maintenance, I'm trying to stick
> with whatever software is available in the official apt-get
> repositories,

Bad idea, what is in the official apt-get repositories is crap. And
not using the latest version in the stable branch is a bad idea too:
all versions in the same branch are binary compatible, so you do not
even need to recompile your applications to use the latest stable
version.

Xenomai sources contain a debian directory allowing you to compile
the packages from sources.

See:
https://xenomai.org/2014/06/building-debian-packages/

> unless I really need to update from source. If you
> think it will help, I can step up to 2.6.4.

I do not remember all that has been fixed between 2.6.3 and 2.6.4,
so yes, testing 2.6.4 would allow finding if this issue has been
fixed or if it is still there.

-- 
					    Gilles.

