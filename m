From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <CAJZRki9RpfcQQ+c8oz1bJ7RsFQE4MrsQdULxvHAuh-STi0fhkQ@mail.gmail.com>
 <oqegntropy.fsf@merlin.sez.to>
 <20150409220956.GE29558@csclub.uwaterloo.ca>
 <20150409221718.GI20752@hermes.click-hack.org>
 <20150409222914.GJ20752@hermes.click-hack.org>
Date: Thu, 09 Apr 2015 19:17:53 -0400
In-Reply-To: <20150409222914.GJ20752@hermes.click-hack.org> (Gilles
 Chanteperdrix's message of "Fri, 10 Apr 2015 00:29:14 +0200")
Message-ID: <44wq1knb6m.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] Why does mqueue.h define mqd_t as unsigned
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai Mailing List <xenomai@xenomai.org>

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:

> On Fri, Apr 10, 2015 at 12:17:18AM +0200, Gilles Chanteperdrix wrote:

>> This design is specified by POSIX. This looks like a "fighting the
>> windmill" case.
>
> I think the upside of this design is that it allows mqd_t being
> implemented as a pointer or as an integer, this gives freedom to the
> implementer by making the type opaque.

Yes, but in other cases POSIX specified symbolic constants rather than
numeric values for exactly that problem.  It's possible that somebody just
made a mistake by not doing that here, but I would venture to guess that
there was probably an issue with existing code that led to this hack.

