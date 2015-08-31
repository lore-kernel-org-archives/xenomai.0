From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Sun, 30 Aug 2015 21:20:41 -0400
Message-ID: <20150831012041.GO15616@csclub.uwaterloo.ca>
References: <20150830132144.GJ20679@hermes.click-hack.org>
 <1501316721.3426149.1440941423095.JavaMail.yahoo@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1501316721.3426149.1440941423095.JavaMail.yahoo@mail.yahoo.com>
Subject: Re: [Xenomai] =?utf-8?b?2KjYrti12YjYtTogeGVub21haSBvbiBkZWJpYW4=?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?4oCrTW9oYW1lZCBGYXd6eeKArCDigKs=?= <m.fawzy307@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, Aug 30, 2015 at 01:30:23PM +0000, ‫Mohamed Fawzy‬ ‫ wrote:
> i tried 2.6.0 because when i searched for xenomai package for debian wheezy in this site 
> https://packages.debian.org/source/wheezy/devel/
> i found it is xenomai 2.6.0 
> can i use 2.6.4 ?

Building a debian package using the debian/* files in the current
xenomai-2.6 git tree works fine for me.  The packages in Debian are
ancient and a waste of time.

Now for patching your kernel with ipipe and xenomai, that's a separate
problem.

-- 
Len Sorensen

