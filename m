From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 2 Jan 2015 10:47:00 -0500
Message-ID: <20150102154700.GU24110@csclub.uwaterloo.ca>
References: <mailman.787.1420134217.6101.xenomai-git@xenomai.org>
 <54A672BA.8090209@web.de> <54A679D5.20903@xenomai.org>
 <54A67CD1.10103@web.de> <20150102125133.GA1492@daedalus>
 <20150102150503.GT24110@csclub.uwaterloo.ca>
 <20150102151027.GF1492@daedalus> <20150102152245.GG1492@daedalus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150102152245.GG1492@daedalus>
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum: copperplate: add
 configuration tunable for registry moint point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@web.de>, Xenomai <xenomai@xenomai.org>

On Fri, Jan 02, 2015 at 04:22:45PM +0100, Gilles Chanteperdrix wrote:
> And from a pure technical point of view, the perturbation induced by
> a temporary mount on /mnt will be well, temporary, as soon as you
> unmount, you will be able to access /mnt/xenomai again. And I doubt
> the application itself will notice anything, as it will have kept
> the /mnt/xenomai directory opened and so will be able to keep
> accessing it, even if something else is mounted on top of /mnt.

If xenomai doesn't open and close stuff as it goes, then yes it should
stay working in that case.

I still don't consider what xenomai is doing a temporary mount though.

-- 
Len Sorensen

