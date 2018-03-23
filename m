MIME-Version: 1.0
From: Ivid Suvarna <ivid.suvarna@gmail.com>
Date: Fri, 23 Mar 2018 21:38:32 +0530
Message-ID: <CABXF_ADnHHUgBZ=RzCSzA-mJpShF=gwXyAarWXs4zLgRx1GC5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] FUSE package error while doing configure for xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: xenomai@xenomai.org

Hi Pintu-san,

> I am trying to install xenomai-3 again.
> # ./script/bootstrap
>
> After this, when I do configure, it is stopped at FUSE
> # ./configure
> ....
> ....
> checking whether the registry should be enabled... no
> ./configure: line 13838: syntax error near unexpected token `FUSE,'
> ./configure: line 13838: `      PKG_CHECK_MODULES(FUSE, fuse)'
>
> How to solve this problem ?
> If anybody have come across this problem?

Try installing libfuse-dev after installing libfuse2

Regards,
IVID

