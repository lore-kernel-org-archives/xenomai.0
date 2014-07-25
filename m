Message-ID: <53D21EFF.1050404@ma-info.de>
Date: Fri, 25 Jul 2014 11:10:23 +0200
From: Frede Florian <florian.frede@ma-info.de>
MIME-Version: 1.0
References: <53D0AC77.8070606@ma-info.de>
 <20140724135603.GD17765@csclub.uwaterloo.ca>
In-Reply-To: <20140724135603.GD17765@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How to use Xenomai in Eclipse
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

Thanks for the fast help,

seems to work for me I used the wrong directory in the includes... also 
the arm cross compiler seems to work.

Regards Florian

> You usually have to explicitly specify /usr/include/xenomai as an include
> directory when working with xenomai, given the xenomai files don't put
> the xenomai part of the path in the #include statements.
>
> Of course if cross compiling you would have to have the header files
> for your target in the correct place and add that to the include path.
>
> Using pkg-config would pretty much just take care of it for you of course.
>
> For example:
> root@omap5:~# pkg-config --cflags libxenomai_native
> -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -I/usr/include/xenomai
>
> So you would make sure your makefile had:
>
> CFLAGS += $(shell pkg-config --cflags libxenomai_native)
> LIBS += $(shell pkg-config --libs libxenomai_native)
>
> I can't remember the syntax for using pkg-config for cross compiling at
> the moment, but I remember there is one.  I almost never cross compile
> so I don't remember it.
>


