Date: Thu, 8 Jan 2015 17:10:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150108161031.GE21505@hermes.click-hack.org>
References: <87BB06E7C07D514A96969FF11282F7954DEB98@MXSTU2012.hpi.uni-potsdam.de>
 <20150108153519.GC21505@hermes.click-hack.org>
 <20150108153947.GD21505@hermes.click-hack.org>
 <87BB06E7C07D514A96969FF11282F7954DEFBF@MXSTU2012.hpi.uni-potsdam.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87BB06E7C07D514A96969FF11282F7954DEFBF@MXSTU2012.hpi.uni-potsdam.de>
Subject: Re: [Xenomai] Is there a specification?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Eichenberg, Marius" <Marius.Eichenberg@student.hpi.uni-potsdam.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Jan 08, 2015 at 04:02:44PM +0000, Eichenberg, Marius wrote:
> Hey Gilles, 
> thanks for your fast response.
> 
> Actually we don't want to implement an own skin.

It is the way to go, if you want to run OSEK over Xenomai. Note that
the OSEK API is really lightweight, so going directly to an initial
implementation of this API would take somewhere around two weeks to
someone who knows the job. There is no need to turn around the
problem and ask useless questions, if something is missing, you can
add it to Xenomai core.

> We just want to compare the tasks from OSEK and the one from
> Xenomai (version 3 is preferred).

I am not sure how this is going to achieve anything.

> 
> For now we were using the Task Management Service of the Alchemy API as a reference.
> https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__task.html
> 
> The API is good for a specific mapping of the methods, but we're
> missing an abstract overview.

The Alchemy API is an API equivalent to the OSEK API. This is not
what you should be looking at, if you want to implement an OSEK
skin. You should look at the implementation itself, not the Alchemy
API.

> Especially a conceptual description how Xenomai sees tasks,
> e.g. which states are available, when are transitions firing?

There is an explanation of all this in Xenomai white paper. Have you
not skimmed all the available documentation at:
https://www.xenomai.org 

?

Please do not top-post.
Regards.

-- 
					    Gilles.

