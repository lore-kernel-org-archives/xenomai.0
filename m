MIME-Version: 1.0
In-Reply-To: <20141002014902.GL4435@csclub.uwaterloo.ca>
References: <CANgF67Q+ZneJM-osJT07NS45AWaZEPetHjUL5EBc5SvW0Dc7rQ@mail.gmail.com>
 <20141001213611.GI4435@csclub.uwaterloo.ca> <542C789F.4090309@xenomai.org>
 <20141002014902.GL4435@csclub.uwaterloo.ca>
From: =?UTF-8?Q?Hasret_Sar=C4=B1yer?= <hsrtsryr@gmail.com>
Date: Thu, 2 Oct 2014 11:20:46 +0300
Message-ID: <CABVE6k0Zh_5sXboLFf0KoBE0c8a1ezFBhGpPosCVLQTNwEDEOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] nucleus/sched.h: No such file or directory
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Xenomai <xenomai@xenomai.org>

2014-10-02 4:49 GMT+03:00 Lennart Sorensen <lsorense@csclub.uwaterloo.ca>:

> On Wed, Oct 01, 2014 at 11:56:47PM +0200, Gilles Chanteperdrix wrote:
> > Why is is unfortunate, if I may ask? It also depends on how you run the
> > configure script, you get includes in /usr/include/xenomai if you passed
> > --includedir=/usr/include/xenomai
>
> Well only unfortunate in that you can't compile without adding to the
> include path with the path the xenomai headers use internally.
>
> Quite common of course for many libraries.
>
> --
> Len Sorensen
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


@Lennart, I am grateful to you for your help.When I added
-I/usr/include/xenomai
to my compile line , the compilation was nice.
