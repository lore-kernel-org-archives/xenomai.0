MIME-Version: 1.0
In-Reply-To: <5426DE0A.6070802@xenomai.org>
References: <CABVE6k2Cwx00+g5zTbSqZHTJOqOT6XRPr98KFjOzjpZU=jHW7g@mail.gmail.com>
 <5426DE0A.6070802@xenomai.org>
From: =?UTF-8?Q?Hasret_Sar=C4=B1yer?= <hsrtsryr@gmail.com>
Date: Sat, 27 Sep 2014 19:40:12 +0300
Message-ID: <CABVE6k00qZRn+QURJcF4JcJygMB59NrjLKhbPhanTMd5pnsn7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai: /dev/rtheap is missing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai@xenomai.org

My PC is Ubuntu 12.04. This tutorial is for debian. Some commands contain a
"debian" word.Should I replace "ubuntu"?

2014-09-27 18:55 GMT+03:00 Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org>:

> On 09/27/2014 03:01 PM, Hasret Sar=C4=B1yer wrote:
> > I want to run small code with xenomai. I used this page to  compile
> kernel
> > and install xenomai.
> >
> >
> http://www.stanley.gatech.edu/skelly/uncategorized/installing-xenomai-on-=
ubuntu-12-04/#comment-3379
> >
> > I didn't change configuration options.When I run "sudo
> > ./trivial-periodic",the output is Xenomai: /dev/rtheap is missing
> > (chardev, major=3D10 minor=3D254).
> >
> > In this question, xenomai 2.6.0 was recommended -> .
> > http://www.xenomai.org/pipermail/xenomai/2011-October/024664.html
>
> Please:
> - use the latest stable version, that is Xenomai 2.6.4
> - follow the installation instructions here:
> http://xenomai.org/2014/06/building-debian-packages/
>
>
> --
>                                                                 Gilles.
>
