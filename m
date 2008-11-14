Message-ID: <c024fefc0811131650l1b6bca81xeefcff87a398df59@domain.hid>
Date: Fri, 14 Nov 2008 09:50:06 +0900
From: "Adrian Boeing" <me@domain.hid>
Sender: aboeing@domain.hid
In-Reply-To: <491C5844.2060306@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_928_3686671.1226623806757"
References: <c024fefc0811120041l71143d5dic1980a06d89a1317@domain.hid>
	<491B367A.1050207@domain.hid>
	<c024fefc0811130016u526a45a9q4f587679e75c381c@domain.hid>
	<491C5844.2060306@domain.hid>
Subject: Re: [Xenomai-help] Xenomai Kernel Module & Watchdogs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

------=_Part_928_3686671.1226623806757
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Giles,

You need to enable xenomai debugging.
>

Ok, thanks.



> I repeat myself: "you have to get the module compiled by Linux kernel
> makefiles. See Documentation/kbuild/modules.txt in the kernel sources."
>

Yes, sorry. The problem I am having was in including Xenomai into the kernel
module.
I have figured out how to do this, below is the solution:

If I compile a vanilla linux kernel, I do this:

hello.c:
#include <linux/module.h>
#include <linux/kernel.h>

int init_module(void) {
 printk(KERN_INFO "Hello World 1.\n");
 return 0;
}

void cleanup_module(void) {
 printk(KERN_INFO "Goodbye world 1.\n");
}

Makefile:
obj-m += hello.o

all:
        make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

commands:
make
sudo insmod ./hello.ko
lsmod |grep hello

To include xenomai calls, add:
#include <nucleus/module.h>
#include <native/task.h>

to the kernel module 'hello.c' source listed above.

and modify the makefile to include
EXTRA_CFLAGS = -I/usr/include/xenomai -D_GNU_SOURCE -D_REENTRANT -D__XENO__

And it works now.

Please do not drop the mailing list from the CC.

Sorry, missed it.

------=_Part_928_3686671.1226623806757
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Giles,<br><br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>You need to enable xenomai debugging.</div>
</blockquote><div><br>Ok, thanks. <br><br> </div><div>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I repeat myself: &quot;you have to get the module compiled by Linux kernel<br>


<div>makefiles. See Documentation/kbuild/modules.txt in the kernel sources.&quot;</div></blockquote><div><br>Yes, sorry. The problem I am having was in including Xenomai into the kernel module.<br>
I have figured out how to do this, below is the solution:<br><br>If I compile a vanilla linux kernel, I do this:<br><br>hello.c:<br>#include &lt;linux/module.h&gt;<br>#include &lt;linux/kernel.h&gt;<br><br>int init_module(void) {<br>

&nbsp;printk(KERN_INFO &quot;Hello World 1.\n&quot;);<br>&nbsp;return 0;<br>}<br><br>void cleanup_module(void) {<br>&nbsp;printk(KERN_INFO &quot;Goodbye world 1.\n&quot;);<br>}<br><br>Makefile:<br>obj-m += hello.o<br><br>all:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules<br>

<br>commands:<br>make<br>sudo insmod ./hello.ko<br>lsmod |grep hello<br><br>To include xenomai calls, add:<br>#include &lt;nucleus/module.h&gt;<br>#include &lt;native/task.h&gt;<br><br>to the kernel module &#39;hello.c&#39; source listed above.<br>

<br>and modify the makefile to include <br>EXTRA_CFLAGS = -I/usr/include/xenomai -D_GNU_SOURCE -D_REENTRANT -D__XENO__<br><br>And it works now.<br><br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Please do not drop the mailing list from the CC.</blockquote><div>Sorry, missed it.</div>

</div>

------=_Part_928_3686671.1226623806757--

