Message-ID: <4D5CF34B.3030905@domain.hid>
Date: Thu, 17 Feb 2011 11:07:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <608520.76294.qm@domain.hid>
In-Reply-To: <608520.76294.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] valgrind and modprobe xeno_posix
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Franz Engel <franz_lambert_engel@domain.hid>
Cc: xenomai@xenomai.org

Franz Engel wrote:
> Hi,
> 
> I'm still doubtful if I installed Xenomai correctly. When I start my QT-Programm 
> it runs correctly and I can see a new process in /proc/xenomai/state with the 
> name of my program. I insert the following lines in my *.pro-File (the draft for 
> my makefile):
> LIBS += -Wl,@usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt 
> -lxenomai -lpthread -lrt -Xlinker -rpath -Xlinker /usr/xenomai/lib
> LIBS += -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__ 
> -I/usr/xenomai/include/posix
> 
> I'm absoult no makefile pro. The two lines are the only thing I changed in my 
> *.pro file. Do I have to make more changes?

Wrong makefile, see:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Compilation_flags


> Futhermore, when I run:
> valgrind --leak-check=yes ./demo
> 
> I get the correct valgrind output, but also a line of xenomai:
> Xenomai: POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled
> (modprobe xeno_posix?)
> 
> Do I use a bad makefile?

Yes, you use a bad makefile, but this is not the reason why your
application does not work with valgrind: Xenomai applications do not
work with valgrind.

Also note that the QT library is compiled to use Linux posix objects,
not Xenomai posix objects, so depending on what you do, mixing some
Xenomai code with QT code will not work. The real-time part of the
application has to clearly been separated from the rest, and only this
part needs to be linked with Xenomai flags, so, the simplest thing to do
is to put the real-time part of the application in a dynamic library,
link-edit this dynamic library with Xenomai posix skin flags, then link
with this dynamic library the rest of the application, without Xenomai
posix skin flags. And in the interface between the library and the
applicaiton, do not put any inline functions calling Xenomai posix skin
services, as this would ruin what you are trying to achieve.

-- 
					    Gilles.

