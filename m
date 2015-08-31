Date: Mon, 31 Aug 2015 20:31:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150831183112.GB5696@hermes.click-hack.org>
References: <20150831012041.GO15616@csclub.uwaterloo.ca>
 <795260343.3753533.1441008554562.JavaMail.yahoo@mail.yahoo.com>
 <20150831151609.GP15616@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150831151609.GP15616@csclub.uwaterloo.ca>
Subject: Re: [Xenomai]
 =?utf-8?b?2KjYrti12YjYtTogINio2K7YtdmI2LU6IHhlbm9tYWkg?=
 =?utf-8?q?on_debian?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Aug 31, 2015 at 11:16:09AM -0400, Lennart Sorensen wrote:
> On Mon, Aug 31, 2015 at 08:09:14AM +0000, ‫Mohamed Fawzy‬ ‫ wrote:
> > thanks for your reply 
> > i succeed to build and The build results in the following packages:
> > xenomai-runtime – Xenomai runtime utilitieslibxenomai1 – Shared libraries for Xenomailibxenomai-dev – Headers and static libraries for Xenomaixenomai-kernel-source – Sources of the Xenomai 2.x kernelxenomai-doc – Xenomai documentation
> > then i installed them using (dpkg -i *.deb )
> > 
> > now , how i can test xenomai ?
> 
> Well that gives you the runtime libraries and test suite, but you can't
> do anything until you have made a kernel with ipipe/xenomai patched in
> and enabled and are running that.

... and have checked the kernel logs to see why Xenomai does not
start. Oh wait, but this was the first answer to the very first mail
Mohamed posted.

-- 
					    Gilles.
https://click-hack.org

