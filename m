Message-ID: <e4ef24880710250033x31c7ba0y8f28ddc6f30d2635@domain.hid>
Date: Thu, 25 Oct 2007 00:33:04 -0700
From: "Robert Gubler" <rgubler@domain.hid>
In-Reply-To: <472043C1.1040506@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_172_17426131.1193297584944"
References: <e4ef24880710241635p102f5f44i3f5e5e88bc0e4b02@domain.hid>
	<472043C1.1040506@domain.hid>
Subject: Re: [Xenomai-help] Problems building Xenomai 2.4-rc4 and linux
	2.6.23
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_172_17426131.1193297584944
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Well, sadly I don't have it with me.  I can post it tomorrow, But,
essentially the config is whatever the default is.  I didn't change any
options when I ran `make menuconfig`.

The other configurations I tried were:

linux-2.6.23.1.tar.bz2
xenomai-2.4-rc4.tar.bz2
adeos-ipipe-2.6.23-i386-1.10-10.patch


And,

linux-2.6.23.1.tar.bz2
xenomai-2.3.4.tar.bz2
adeos-ipipe-2.6.23-i386-1.10-10.patch


-Rob


On 10/25/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Robert Gubler wrote:
> > Hello,
> >
> > I am trying to build a kernel that supports xenomai, but every
> combination
> > of xenomai releases, adeos-ipipe patches, and linux kernels don't seem
> to
> > build successfully for me.  First, I'd like to know if someone
> recommends a
> > particular version of all of these that is known to work for you?? Right
> now
> > I am trying to use:
> >
> > linux-2.6.23.tar.bz2  (from kernel.org)
> > xenomai-2.4-rc4.tar.bz2
> > adeos-ipipe-2.6.23-i386-1.10-10.patch
> >
> >
> > Heres is what I am doing:
> >
> > # ./prepare-kernel.sh --linux=~/incoming/linux-
> 2.6.23--adeos=~/incoming/adeos-
> > ipipe-2.6.23-i386-1.10-10.patch --arch=i386
> >
> > ..... (no indication of failure) ....
> >
> > # cd ~/incoming/linux-2.6.23
> >
> > # make clean distclean mrproper
> >
> > # make menuconfig
> >
> > # make
> >
> > ......
> >
> >
> >   AS      arch/i386/boot/compressed/head.o
> >   CC      arch/i386/boot/compressed/misc.o
> > In file included from include/linux/ipipe_base.h:29,
> >                  from include/linux/kernel.h:17,
> >                  from include/asm/system.h:4,
> >                  from include/asm/processor.h:18,
> >                  from include/asm/thread_info.h:16,
> >                  from include/linux/thread_info.h:21,
> >                  from include/linux/preempt.h:9,
> >                  from include/linux/spinlock.h:49,
> >                  from include/linux/vmalloc.h:4,
> >                  from arch/i386/boot/compressed/misc.c:14:
> > include/asm/ipipe_base.h:26:25: error: irq_vectors.h: No such file or
> > directory
> > make[2]: *** [arch/i386/boot/compressed/misc.o] Error 1
> > make[1]: *** [arch/i386/boot/compressed/vmlinux] Error 2
> > make: *** [bzImage] Error 2
>
> This should not happen anymore. Could you post your .config so that we
> can try to reproduce the error?
>
> >
> >
> > I've read the included README.INSTALL and TROUBLESHOOTING docs included
> with
> > xenomai, but they didn't seem to help me in this case.  If anyone has
> > recommendations for me that would be great!
> >
> > Thanks,
> >
> > Rob
> >
>
> Are there more combinations that do not build? Note that the issue above
> is 2.6.23-specific.
>
> Jan
>
>
>

------=_Part_172_17426131.1193297584944
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Well, sadly I don&#39;t have it with me.&nbsp; I can post it tomorrow, But, essentially the config is whatever the default is.&nbsp; I didn&#39;t change any options when I ran `make menuconfig`. <br><br>The other configurations I tried were:
<br><br>linux-2.6.23.1.tar.bz2<br>xenomai-2.4-rc4.tar.bz2<br>adeos-ipipe-2.6.23-i386-1.10-10.patch<br><br><br>And,<br><br>linux-2.6.23.1.tar.bz2<br>xenomai-2.3.4.tar.bz2<br>
adeos-ipipe-2.6.23-i386-1.10-10.patch<br><br><br>-Rob<br><br><br><div><span class="gmail_quote">On 10/25/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:
</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Robert Gubler wrote:<br>&gt; Hello,<br>&gt;<br>&gt; I am trying to build a kernel that supports xenomai, but every combination
<br>&gt; of xenomai releases, adeos-ipipe patches, and linux kernels don&#39;t seem to<br>&gt; build successfully for me.&nbsp;&nbsp;First, I&#39;d like to know if someone recommends a<br>&gt; particular version of all of these that is known to work for you?? Right now
<br>&gt; I am trying to use:<br>&gt;<br>&gt; linux-2.6.23.tar.bz2&nbsp;&nbsp;(from <a href="http://kernel.org">kernel.org</a>)<br>&gt; xenomai-2.4-rc4.tar.bz2<br>&gt; adeos-ipipe-2.6.23-i386-1.10-10.patch<br>&gt;<br>&gt;<br>&gt; Heres is what I am doing:
<br>&gt;<br>&gt; # ./prepare-kernel.sh --linux=~/incoming/linux-2.6.23--adeos=~/incoming/adeos-<br>&gt; ipipe-2.6.23-i386-1.10-10.patch --arch=i386<br>&gt;<br>&gt; ..... (no indication of failure) ....<br>&gt;<br>&gt; # cd ~/incoming/linux-
2.6.23<br>&gt;<br>&gt; # make clean distclean mrproper<br>&gt;<br>&gt; # make menuconfig<br>&gt;<br>&gt; # make<br>&gt;<br>&gt; ......<br>&gt;<br>&gt;<br>&gt;&nbsp;&nbsp; AS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/i386/boot/compressed/head.o<br>&gt;&nbsp;&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/i386/boot/compressed/misc.o
<br>&gt; In file included from include/linux/ipipe_base.h:29,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from include/linux/kernel.h:17,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from include/asm/system.h:4,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from include/asm/processor.h:18,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from include/asm/thread_info.h:16,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from include/linux/thread_info.h:21,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from include/linux/preempt.h:9,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from include/linux/spinlock.h:49,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from include/linux/vmalloc.h:4,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from arch/i386/boot/compressed/misc.c:14:<br>&gt; include/asm/ipipe_base.h:26:25: error: irq_vectors.h: No such file or<br>&gt; directory<br>
&gt; make[2]: *** [arch/i386/boot/compressed/misc.o] Error 1<br>&gt; make[1]: *** [arch/i386/boot/compressed/vmlinux] Error 2<br>&gt; make: *** [bzImage] Error 2<br><br>This should not happen anymore. Could you post your .config so that we
<br>can try to reproduce the error?<br><br>&gt;<br>&gt;<br>&gt; I&#39;ve read the included README.INSTALL and TROUBLESHOOTING docs included with<br>&gt; xenomai, but they didn&#39;t seem to help me in this case.&nbsp;&nbsp;If anyone has
<br>&gt; recommendations for me that would be great!<br>&gt;<br>&gt; Thanks,<br>&gt;<br>&gt; Rob<br>&gt;<br><br>Are there more combinations that do not build? Note that the issue above<br>is 2.6.23-specific.<br><br>Jan<br>
<br><br></blockquote></div><br>

------=_Part_172_17426131.1193297584944--

