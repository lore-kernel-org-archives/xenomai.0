From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 19 Mar 2015 10:07:03 -0400
Message-ID: <20150319140703.GC25508@csclub.uwaterloo.ca>
References: <CAEMXjGwam0jjOrUBgBY_FyFOaT15qHdobMo96G3bEsWx6rEcpA@mail.gmail.com>
 <20150317180654.GB16113@hermes.click-hack.org>
 <CAEMXjGxSMGQFfBvUG3VdepA_cRHb=6n1V_pO3QzXtofY2bUuMA@mail.gmail.com>
 <20150317192431.GY25508@csclub.uwaterloo.ca>
 <CAEMXjGx6R0HtdJwU5_5AoDN=KV1T9nn5ug-ZwctJzd9B43NYSw@mail.gmail.com>
 <20150317213457.GZ25508@csclub.uwaterloo.ca>
 <CAEMXjGy3J+aFoCNdvugUKDOunzqk=sE3aSybHuL-_xK6qiea7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEMXjGy3J+aFoCNdvugUKDOunzqk=sE3aSybHuL-_xK6qiea7w@mail.gmail.com>
Subject: Re: [Xenomai] Building with hard float: cannot open shared object
 file libpthread_rt.so.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve B <sbattazzo@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Mar 18, 2015 at 05:42:02PM -0700, Steve B wrote:
> Hello again, all.
> It turns out that when I ran without Xenomai and with the -mhard-float
> option enabled, the pow() function was only returning one of the original
> arguments as a result, and thus wasn't working properly!
> 
> Without the -mhard-float option in my compile, it seems that the gnueabihf
> case actually has worse timing than the regular gnueabi, which is kind of
> puzzling. This is definitely not a Xenomai issue though so I will check
> with some other software folks on site and see if they have any thoughts.

Well it is possible the FPU is so bad at that function, that the software
implementation using intergers only can be faster.

Which CPU are you running this on?  I remember the Cortex-A8 is known for
having a horribly slow FPU (neon code generally runs quite a bit faster,
which isn't true of later Cortex-A designs, where the FPU is usually
faster than neon or at least equal).

-- 
Len Sorensen

