Message-ID: <4F09FEA8.9080001@domain.hid>
Date: Sun, 08 Jan 2012 20:38:00 +0000
From: Jakub Nowacki <j.s.nowacki@domain.hid>
MIME-Version: 1.0
References: <000301cccaed$80667540$81335fc0$@soterem.fr>	<4F046865.9000408@domain.hid>	<000001cccafd$1c6046b0$5520d410$@soterem.fr>	<4F049054.4000302@domain.hid>
	<4F062D33.3060606@domain.hid> <4F06C191.1090704@domain.hid>
In-Reply-To: <4F06C191.1090704@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] unresolved symbol - check
	the	xenomai	installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 06/01/12 09:40, Gilles Chanteperdrix wrote:
 > This is not the same issue as Gregory. Gregory missing symbols were from
 > libnative, and we know that examples makefiles include -lnative, so,
 > libnative is probably not installed in the place where the linker looks
 > for it: that is an installation issue.
 > On the other hands, the symbols from the errors you show us are defined
 > in libxenomai.so. So, the RTXI build system is likely using hardcoded
 > flags instead of the flags returned by xeno-config: that is a makefile
 > issue.
 >

OK, maybe my problem is not similar but I still get unresolved 
reference. Below I show the full listing when compilation fails

/bin/bash ../libtool --tag=CXX   --mode=link g++ -pipe -Wall 
-I/usr/share/qt3/include -DQT_THREAD_SUPPORT  -O2  -L/usr/share/qt3/lib 
-lqt-mt  -lSM -lICE  -lX11 -lXext -lXmu -lXt -lXi  -lgsl -lgslcblas -lm 
  -L/usr/xenomai/lib -lxenomai -lpthread -lrt -lnative  -o rtxi 
cmdline.o daq.o default_gui_model.o event.o fifo.o io.o main.o 
main_window.o mutex.o plugin.o rt.o rtfile.o rwlock.o sem.o settings.o 
workspace.o  rt_os-xenomai.o  moc_default_gui_model.o moc_main_window.o 
moc_plugin.o  -rdynamic
libtool: link: g++ -pipe -Wall -I/usr/share/qt3/include 
-DQT_THREAD_SUPPORT -O2 -o rtxi cmdline.o daq.o default_gui_model.o 
event.o fifo.o io.o main.o main_window.o mutex.o plugin.o rt.o rtfile.o 
rwlock.o sem.o settings.o workspace.o rt_os-xenomai.o 
moc_default_gui_model.o moc_main_window.o moc_plugin.o -rdynamic 
-L/usr/share/qt3/lib /usr/lib/libqt-mt.so -lSM -lICE -lX11 -lXext -lXmu 
-lXt -lXi -lgsl -lgslcblas -lm -L/usr/xenomai/lib 
/usr/xenomai/lib/libxenomai.so -lpthread -lrt 
/usr/xenomai/lib/libnative.so -Wl,-rpath -Wl,/usr/xenomai/lib -Wl,-rpath 
-Wl,/usr/xenomai/lib
/usr/xenomai/lib/libnative.so: undefined reference to `xeno_current'
/usr/xenomai/lib/libnative.so: undefined reference to `xeno_sem_heap'
/usr/xenomai/lib/libnative.so: undefined reference to 
`xeno_sigshadow_install_once'
/usr/xenomai/lib/libnative.so: undefined reference to `xeno_set_current'
/usr/xenomai/lib/libnative.so: undefined reference to `xeno_map_heap'
/usr/xenomai/lib/libnative.so: undefined reference to `xnarch_tsc_to_ns'
/usr/xenomai/lib/libnative.so: undefined reference to 
`xeno_handle_mlock_alert'
/usr/xenomai/lib/libnative.so: undefined reference to `xeno_fault_stack'
/usr/xenomai/lib/libnative.so: undefined reference to 
`xeno_set_current_mode'
/usr/xenomai/lib/libnative.so: undefined reference to `xeno_bind_skin_opt'
/usr/xenomai/lib/libnative.so: undefined reference to `xeno_current_mode'
/usr/xenomai/lib/libnative.so: undefined reference to `xnarch_ns_to_tsc'
collect2: ld returned 1 exit status
make[1]: *** [rtxi] Error 1
make[1]: Leaving directory `/usr/src/rtxi-1.31/rtxi'
make: *** [all-recursive] Error 1

I use xeno-config to get flags, as you can see in the above libtool 
command. I'm not the expert on autotools, but everything seems to look 
OK. I even tried to add xenomai LD_LIBRARY_PATH, but the result is still 
the same. I think I give it a go with 2.5.6 and see if the error is 
there; I installed xenomai 2.5.6 for RTXI a couple of times on different 
machines and I don't recall this problem. Just to be absolutely clear, 
I'm suing Ubuntu 11.04 with GCC 4.6 (I checked 4.5 and I get the same 
thing).

Best wishes,

Jakub



