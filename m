Date: Fri, 23 Mar 2018 12:42:15 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180323124215.53d92406@mmd1pvb1c.ad001.siemens.net>
In-Reply-To: <CAOuPNLh0inmNY6Vi6CDDranrF3iRv8zKeokfppbZCnoAVz=ZBQ@mail.gmail.com>
References: <CAOuPNLh0inmNY6Vi6CDDranrF3iRv8zKeokfppbZCnoAVz=ZBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Am Fri, 23 Mar 2018 11:36:48 +0530
schrieb Pintu Kumar <pintu.ping@gmail.com>:

> Hi,
> 
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

Yes, it is known. You will have to install "pkg-config", or the
equivalent if you are not on Debian.

Henning

> I tried installing : fuse, libfuse2, but it did not help.
> 
> Please help!
> 
> 
> Thanks,
> Pintu
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


