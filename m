Message-ID: <3f027d060706241451g70504604o6f4cfb7e1997398e@domain.hid>
Date: Sun, 24 Jun 2007 23:51:34 +0200
From: "Zany Super Chimp" <zanychimp@domain.hid>
In-Reply-To: <18046.43281.454448.814965@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_112284_24802659.1182721894216"
References: <f48df4840706240643j2046afa0pd69452874264fb1f@domain.hid>
	<18046.43281.454448.814965@domain.hid>
Subject: Re: [Xenomai-help] Problem building and running demos
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_112284_24802659.1182721894216
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/6/24, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
> Bruno Rouchouse wrote:
> > Hi Xeno users !
> >
> > just trying to play with Xenomai's demos but I'm having some problems
> > compiling and running some of them.
> >
> > Satch for the native skin
> > ==============
> >
> > I have some troubles here compiling satch.
> >
> > bruno@domain.hid$ make
> > cc -o satch satch.c -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
> > -D__XENO__ -L/usr/xenomai/lib -lpthread -lnative
> > /usr/lib/gcc/i486-linux-gnu/4.1.2/../../../../lib/crt1.o: In function
> > `_start':
> > ../sysdeps/i386/elf/start.S:115: undefined reference to `main'
> > collect2: ld returned 1 exit status
> >
> > Satch for the posix skin
> > ==============
> >
> > Building process works fine but running satch fails :
> > My .runinfo file looks like:
> > satch:posix:!./satch_rt;popall:control_c
> >
> > bruno@domain.hid$ xeno-load ./:satch
> > *
> > *
> > * Type ^C to stop this application.
> > *
> > *
> > Satch: producer module not running, please launch producer module before
> > launching consumer application.
> > __xeno_user_init: 2
> >
> > I understand from xenomai/ksrc/skins/posix/demos/Kbuild and going
> quickly
> > through satch.c code that there should be a first module to insmod
> before
> > using the consumer module but how/when is the producer module supposed
> to be
> > built? I don't find any other module in my xenomai built tree or in my
> > /lib/modules/*-ipipe kernel.
>
> You are supposed to run:
> make -C /path/to/your/kernel/sources M=$PWD modules
> because you know how to compile kernel modules outside of the kernel
> tree. You then have a ksatch.ko kernel module. It does not even work
> with 2.4 kernels.


Well, shame  on me then because I'm not too familiar with kernel module
build process ;)

I get some warnings though which prevent me from insmoding ksatch.koafterwards:

bruno@domain.hid$ make -C /usr/src/linux-
2.6.20.14-ipipe M=$PWD modules
make: Entering directory `/usr/src/linux-2.6.20.14-ipipe'
  CC [M]  /home/bruno/xenomai/ksrc/skins/posix/demos/satch.o
  LD [M]  /home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.o
  Building modules, stage 2.
  MODPOST 1 modules
WARNING: "shm_unlink" [/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko]
undefined!
WARNING: "mmap" [/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko]
undefined!
WARNING: "ftruncate" [/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko]
undefined!
WARNING: "pse51_shm_close"
[/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko] undefined!
WARNING: "shm_open" [/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko]
undefined!
WARNING: "munmap" [/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko]
undefined!
  CC      /home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.mod.o
  LD [M]  /home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko
make: Leaving directory `/usr/src/linux-2.6.20.14-ipipe'

Something missing in the Kbuild file? How to reference symbols of the posix
lib?

And then of course, insmoding ksatch.ko fails...

sudo modprobe xeno_posix

sudo insmod ./ksatch.ko

tail -f /var/log/message

Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol munmap
Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol shm_open
Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol pse51_shm_close
Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol ftruncate
Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol mmap
Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol shm_unlink

This was more intended as a test for posix shared memory and
> message queues support, than as a real demo for users. I just did not
> find anywhere else to put it.


An interesting use case in fact.

What we could do is to compile the default version with -DPRODUCER
> -DCONSUMER so that it would be standalone.


Well from my point of view  a short README on how to build the application
would be just fine.
I'll document that in my short "getting started guide" anyway.

Thanks a lot.

--Bruno

--
>
>
>                                             Gilles Chanteperdrix.
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

------=_Part_112284_24802659.1182721894216
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">2007/6/24, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Bruno Rouchouse wrote:<br> &gt; Hi Xeno users !<br> &gt;<br> &gt; just trying to play with Xenomai&#39;s demos but I&#39;m having some problems<br> &gt; compiling and running some of them.<br> &gt;<br> &gt; Satch for the native skin
<br> &gt; ==============<br> &gt;<br> &gt; I have some troubles here compiling satch.<br> &gt;<br> &gt; bruno@domain.hid$ make<br> &gt; cc -o satch satch.c -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
<br> &gt; -D__XENO__ -L/usr/xenomai/lib -lpthread -lnative<br> &gt; /usr/lib/gcc/i486-linux-gnu/4.1.2/../../../../lib/crt1.o: In function<br> &gt; `_start&#39;:<br> &gt; ../sysdeps/i386/elf/start.S:115: undefined reference to `main&#39;
<br> &gt; collect2: ld returned 1 exit status<br> &gt;<br> &gt; Satch for the posix skin<br> &gt; ==============<br> &gt;<br> &gt; Building process works fine but running satch fails :<br> &gt; My .runinfo file looks like:
<br> &gt; satch:posix:!./satch_rt;popall:control_c<br> &gt;<br> &gt; bruno@domain.hid$ xeno-load ./:satch<br> &gt; *<br> &gt; *<br> &gt; * Type ^C to stop this application.<br> &gt; *<br> &gt; *
<br> &gt; Satch: producer module not running, please launch producer module before<br> &gt; launching consumer application.<br> &gt; __xeno_user_init: 2<br> &gt;<br> &gt; I understand from xenomai/ksrc/skins/posix/demos/Kbuild and going quickly
<br> &gt; through satch.c code that there should be a first module to insmod before<br> &gt; using the consumer module but how/when is the producer module supposed to be<br> &gt; built? I don&#39;t find any other module in my xenomai built tree or in my
<br> &gt; /lib/modules/*-ipipe kernel.<br><br>You are supposed to run:<br>make -C /path/to/your/kernel/sources M=$PWD modules<br>because you know how to compile kernel modules outside of the kernel<br>tree. You then have a 
ksatch.ko kernel module. It does not even work<br>with 2.4 kernels.</blockquote><div><br>Well, shame&nbsp; on me then because I&#39;m not too familiar with kernel module build process ;)<br><br>I get some warnings though which prevent me from insmoding 
ksatch.ko afterwards:<br><br>bruno@domain.hid$ make -C /usr/src/linux-2.6.20.14-ipipe M=$PWD modules<br>make: Entering directory `/usr/src/linux-2.6.20.14-ipipe&#39;<br>&nbsp; CC [M]&nbsp; /home/bruno/xenomai/ksrc/skins/posix/demos/satch.o
<br>&nbsp; LD [M]&nbsp; /home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.o<br>&nbsp; Building modules, stage 2.<br>&nbsp; MODPOST 1 modules<br>WARNING: &quot;shm_unlink&quot; [/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko] undefined!
<br>WARNING: &quot;mmap&quot; [/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko] undefined!<br>WARNING: &quot;ftruncate&quot; [/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko] undefined!<br>WARNING: &quot;pse51_shm_close&quot; [/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko] undefined!
<br>WARNING: &quot;shm_open&quot; [/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko] undefined!<br>WARNING: &quot;munmap&quot; [/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko] undefined!<br>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.mod.o
<br>&nbsp; LD [M]&nbsp; /home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko<br>make: Leaving directory `/usr/src/linux-2.6.20.14-ipipe&#39;<br><br>Something missing in the Kbuild file? How to reference symbols of the posix lib?<br>
<br>And then of course, insmoding ksatch.ko fails...<br><br>sudo modprobe xeno_posix<br><br>sudo insmod ./ksatch.ko<br><br>tail -f /var/log/message<br><br>Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol munmap<br>
Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol shm_open<br>Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol pse51_shm_close<br>Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol ftruncate<br>Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol mmap
<br>Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol shm_unlink<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">This was more intended as a test for posix shared memory and
<br>message queues support, than as a real demo for users. I just did not<br>find anywhere else to put it.</blockquote><div><br>An interesting use case in fact.<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
What we could do is to compile the default version with -DPRODUCER<br>-DCONSUMER so that it would be standalone.</blockquote><div><br>Well from my point of view&nbsp;  a short README on how to build the application would be just fine.
<br></div>I&#39;ll document that in my short &quot;getting started guide&quot; anyway.<br><br>Thanks a lot.<br><br>--Bruno<br><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
--<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix.<br><br>_______________________________________________<br>Xenomai-help mailing list<br><a href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid
</a><br><a href="https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/listinfo/xenomai-help</a><br></blockquote></div><br>

------=_Part_112284_24802659.1182721894216--

