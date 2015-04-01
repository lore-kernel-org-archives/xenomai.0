From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <E1YdHjz-0005Rv-A3@sd-51317.xenomai.org>
 <20150401125148.GA29467@hermes.click-hack.org>
Date: Wed, 01 Apr 2015 09:38:07 -0400
In-Reply-To: <20150401125148.GA29467@hermes.click-hack.org> (Gilles
 Chanteperdrix's message of "Wed, 1 Apr 2015 14:51:48 +0200")
Message-ID: <44384kklz4.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : Create gitignore for
	autotools files
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:

> I am not sure having a gitignore file in the repository is a good
> idea, for instance, it will conflict with the gitignore I already
> had, because not using the same autotools version as Philippe, my
> git status was already filled with tons of autotools files without a
> gitignore and before they were removed from the repository. I also
> like to add files to gitignore like *~ my editor creates, and so if
> my gitignore has local modifications, I will see it in the git
> status too.

While I do not support adding gitignore to repositories, I suggest that
these particular issues are more easily handled with methods that cover
multiple work trees. In these examples, .git/info/exclude and
.config/git/ignore respectively.

