Message-ID: <514076BD.3020202@antcom.de>
Date: Wed, 13 Mar 2013 13:53:17 +0100
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
References: <1362541011.90317.YahooMailNeo@web161401.mail.bf1.yahoo.com>
	<5136F3A6.8090400@antcom.de> <513F96BA.4030309@xenomai.org>
	<513F9DF2.2030803@antcom.de> <51406EAA.5000303@xenomai.org>
In-Reply-To: <51406EAA.5000303@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] about Xenomai in Debian and Ubuntu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Gilles,

On 03/13/2013 01:18 PM, Gilles Chanteperdrix wrote:
> Actually, what I quoted above is the contrary, you commanded me to warn
> you before a release, and I obeyed.
                            ^^^^^^^^
vs.

>>> Which is why, for the 2.6.2.1 release, I did not warn you (since it had
                                           ^^^^^^^^^^^^^^^^^^
>>> proved useless anyway)

Contradiction. _If_ you interpret my proposal _back_ _then_ as a command,
which I don't. ;-) "Command" is what I called you asking me for sth. and
blaming me of being inactive (for whatever reason - you can't tell if
someone you haven't met before in life is maybe struggling with sth.
else in life.)

> I interpreted you first mail:
> http://www.xenomai.org/pipermail/xenomai/2012-July/000473.html
> as the fact that you agreed to maintain the debian directory.

In this mail I actually stated that (1) it would be _possible_ for me to
do in Xenomai exactly _what I would change in Debian anyway_. and (2)
that I want to prevent duplicated work. So if I consider stuff in Debian
as working, I can't put much more effort into Xenomai's debian/, to do
different stuff you propose. Sorry - merely time restrictions - please
don't take it personal.

> I am not trying to blame you, I am trying to get a clear answer.
                                                     ^^^^^^^^^^^^
OK, under those circumstances of slightly diverging (i.e. minor but
conflicting in terms of project management) goals[1] I propose you commit
Xenomai's debian/* changes yourself without the need to wait for my comment.

In turn, I'm maintaining Debian's debian/* and synchronize as much as
possible (in the interest of both projects and their users). However,
there will be occasions where Xenomai's and Debian's debian/* will need
to diverge, which is fine, e.g. in case of Debian forces me to freeze
Debian, but apply security fixes etc., and Xenomai in turn wants to
support stuff that Debian can't always synchronize with.

Peace,

Roland


[1] Debian: freezing for releases, supporting Debian released versions
of Xenomai. Xenomai: Following up to date environments of different
Debian-like OSes, and commonly releasing more often.

