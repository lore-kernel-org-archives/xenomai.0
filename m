MIME-Version: 1.0
In-Reply-To: <CA+C+_XS5KxwQ=YKXD6YZ_T41+xdh8q+ag4Xh-Me6EoHLHJ3-Dg@mail.gmail.com>
References: <CA+C+_XS5KxwQ=YKXD6YZ_T41+xdh8q+ag4Xh-Me6EoHLHJ3-Dg@mail.gmail.com>
Date: Wed, 18 Feb 2015 13:49:09 -0600
Message-ID: <CA+C+_XSY4AoZn9J2UV1UF15zbnBv-abC7k=BkLSjUwNzCfQb=A@mail.gmail.com>
From: Mathew Benson <mathew.benson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Remote debugging problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Sorry.  Typo.

- gdbserver 7.4.1-debian

On Wed, Feb 18, 2015 at 1:45 PM, Mathew Benson <mathew.benson@gmail.com>
wrote:

> I converted my code from pthreads to real time Xenomai threads.  My code
> works perfectly, as far as I can tell, but I can't use the remote debugger.
>
>
> Host
> -  Fedora 21, 3.18.6-200.fc21.x86_64
> -  Eclipse 4.4.1
> -  g++ 4.9.2
> -  gdb 4.9.2
>
> Target
> -  Beaglebone Black, 3.8.13
> -  Xenomai 2.6.3
> -  gdbserver 2.6.3
>
> Before I put more details up, is there anything with the configuration
> above that stands out as being a problem?  Specifically, the gdb and
> gdbserver versions?
>
