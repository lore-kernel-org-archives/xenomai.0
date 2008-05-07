Message-ID: <6132061f0805071046h65ce2f7eme4fade4c404223a9@domain.hid>
Date: Wed, 7 May 2008 14:46:06 -0300
From: "Breno Carneiro Pinheiro" <brenodee@domain.hid>
In-Reply-To: <3d3b73870805061301m4a89029eqa69c17b212274f38@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_13214_6595276.1210182366803"
References: <3d3b73870805061301m4a89029eqa69c17b212274f38@domain.hid>
Subject: Re: [Xenomai-help] Does Xenomai 2.4.x support Xenomm ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

------=_Part_13214_6595276.1210182366803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all, I'm trying to compile a simple Xenomai application.
I did a makefile as showed below:

target =  task_teste
CC := ppc_6xx-gcc
XENO_CONFIG := /home/breno/ELDK/ppc_6xx/usr/local/xenomai/bin/xeno-config
CFLAGS := $(shell $(XENO_CONFIG) --xeno-cflags)
LDFLAGS := -lnative $(shell $(XENO_CONFIG) --xeno-ldflags)
$(target): $(target).c
    $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)

I running on powerpc processor where I embedded a linux kernel-tree form
DENX.

The errror returned is:
ppc_6xx-gcc -o task_teste task_teste.c -I/usr/local/xenomai/include
-D_GNU_SOURCE -D_REENTRANT -lnative -L/usr/local/xenomai/lib -lpthread
/home/breno/ELDK/usr/bin/../lib/gcc/powerpc-linux/4.0.0/../../../../powerpc-linux/bin/ld:
cannot find -lnative
collect2: ld returned 1 exit status
make: *** [task_teste] Error 1

So, why don't it find the -lnative. I already configured my kernel option
with Xenomai and native,posix options.

Thanks,

Breno

------=_Part_13214_6595276.1210182366803
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all, I&#39;m trying to compile a simple Xenomai application.&nbsp; <br>I did a makefile as showed below:<br><br>target =&nbsp; task_teste<br>CC := ppc_6xx-gcc<br>XENO_CONFIG := /home/breno/ELDK/ppc_6xx/usr/local/xenomai/bin/xeno-config<br>
CFLAGS := $(shell $(XENO_CONFIG) --xeno-cflags)<br>LDFLAGS := -lnative $(shell $(XENO_CONFIG) --xeno-ldflags)<br>$(target): $(target).c<br>&nbsp;&nbsp;&nbsp; $(CC) -o $@ $&lt; $(CFLAGS) $(LDFLAGS)<br> <br>I running on powerpc processor where I embedded a linux kernel-tree form DENX.<br>
<br>The errror returned is:<br>ppc_6xx-gcc -o task_teste task_teste.c -I/usr/local/xenomai/include -D_GNU_SOURCE -D_REENTRANT -lnative -L/usr/local/xenomai/lib -lpthread<br>/home/breno/ELDK/usr/bin/../lib/gcc/powerpc-linux/4.0.0/../../../../powerpc-linux/bin/ld: cannot find -lnative<br>
collect2: ld returned 1 exit status<br>make: *** [task_teste] Error 1<br><br>So, why don&#39;t it find the -lnative. I already configured my kernel option with Xenomai and native,posix options.<br><br>Thanks,<br><br>Breno<br>

------=_Part_13214_6595276.1210182366803--

