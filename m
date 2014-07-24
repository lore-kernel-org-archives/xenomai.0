From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 24 Jul 2014 09:56:03 -0400
Message-ID: <20140724135603.GD17765@csclub.uwaterloo.ca>
References: <53D0AC77.8070606@ma-info.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53D0AC77.8070606@ma-info.de>
Subject: Re: [Xenomai] How to use Xenomai in Eclipse
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frede Florian <florian.frede@ma-info.de>
Cc: xenomai@xenomai.org

On Thu, Jul 24, 2014 at 08:49:27AM +0200, Frede Florian wrote:
> Hello,
> 
> We plan to use Xenomai in our new project. So now I tried to prepare
> a Eclipse-Project with Xenomai. First I compiled the Debian packages
> from Xenomai 2.6.3
> <http://www.xenomai.org/index.php/Building_Debian_packages> for my
> System.  After that I install the libxenomai1 and libxenomai-dev
> 
> After that I have create a new empty project. There I can include
> the Xenomailib (#include <xenomai/native/task.h>).
> 
> First issue: While compiling the code with Eclipse I get an*fatal
> error: nucleus/sched.h: file or directory not found*...
> 
> I try to find a answer in the endless world wide web :-) but I
> didn't found a solution.
> 
> Second issue: When I change to the compiler for my target platform
> (arm-cortexa8-linux-gnueabihf-gcc) I can not include the Xenomai
> library?
> 
> I use following Software on my System: Eclipse Version: Luna Release
> (4.4.0), Debian GNU/Linux 7.6 (wheezy), Xenomai 2.6.3,
> OSELAS.Toolchain-2013.12.2 <http://www.pengutronix.de/oselas/toolchain/download/OSELAS.Toolchain-2013.12.2.tar.bz2>

You usually have to explicitly specify /usr/include/xenomai as an include
directory when working with xenomai, given the xenomai files don't put
the xenomai part of the path in the #include statements.

Of course if cross compiling you would have to have the header files
for your target in the correct place and add that to the include path.

Using pkg-config would pretty much just take care of it for you of course.

For example:
root@omap5:~# pkg-config --cflags libxenomai_native
-D_GNU_SOURCE -D_REENTRANT -D__XENO__ -I/usr/include/xenomai  

So you would make sure your makefile had:

CFLAGS += $(shell pkg-config --cflags libxenomai_native)
LIBS += $(shell pkg-config --libs libxenomai_native)

I can't remember the syntax for using pkg-config for cross compiling at
the moment, but I remember there is one.  I almost never cross compile
so I don't remember it.

-- 
Len Sorensen

