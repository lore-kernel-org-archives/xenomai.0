From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 31 Aug 2015 11:16:09 -0400
Message-ID: <20150831151609.GP15616@csclub.uwaterloo.ca>
References: <20150831012041.GO15616@csclub.uwaterloo.ca>
 <795260343.3753533.1441008554562.JavaMail.yahoo@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <795260343.3753533.1441008554562.JavaMail.yahoo@mail.yahoo.com>
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
To: =?utf-8?B?4oCrTW9oYW1lZCBGYXd6eeKArCDigKs=?= <m.fawzy307@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Aug 31, 2015 at 08:09:14AM +0000, ‫Mohamed Fawzy‬ ‫ wrote:
> thanks for your reply 
> i succeed to build and The build results in the following packages:
> xenomai-runtime – Xenomai runtime utilitieslibxenomai1 – Shared libraries for Xenomailibxenomai-dev – Headers and static libraries for Xenomaixenomai-kernel-source – Sources of the Xenomai 2.x kernelxenomai-doc – Xenomai documentation
> then i installed them using (dpkg -i *.deb )
> 
> now , how i can test xenomai ?

Well that gives you the runtime libraries and test suite, but you can't
do anything until you have made a kernel with ipipe/xenomai patched in
and enabled and are running that.

-- 
Len Sorensen

