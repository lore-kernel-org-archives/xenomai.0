Message-ID: <c024fefc0811120041l71143d5dic1980a06d89a1317@domain.hid>
Date: Wed, 12 Nov 2008 17:41:14 +0900
From: "Adrian Boeing" <me@domain.hid>
Sender: aboeing@domain.hid
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4589_25638191.1226479274863"
Subject: [Xenomai-help] Xenomai Kernel Module & Watchdogs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_4589_25638191.1226479274863
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm new to Xenomai, and wanted to know how to create a watchdog. It is my
understanding that high priority periodic watchdog alarms need to be created
in kernel mode.

I would like to know:
1. Are there any tutorials/examples for Xenomai? I am aware of the examples
at:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/index.html
and
http://www.captain.at/xenomai.php

2. How do I create a kernel module? (what is the compiler command?)
If I try defining "__KERNEL__" and "MODULE" then I get a large number of
errors in the xenomai/linux includes.

I would like to create a simple 'hello world' module:

#include <nucleus/module.h>
#include <native/task.h>

int init_module(void) {
 printk("<1>Hello World 1.\n");
 return 0;
}

void cleanup_module(void) {
 printk(KERN_ALERT,"Goodbye world 1.\n");
}
(The first error I recieve on compiling is "error: variable or field
'xnpod_declare_tbase_proc' declared void", using
g++ hello.c -c -I/usr/include/xenomai -D_GNU_SOURCE -D_REENTRANT -D__XENO__
)

Thanks!
-Adrian

------=_Part_4589_25638191.1226479274863
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I&#39;m new to Xenomai, and wanted to know how to create a
watchdog. It is my understanding that high priority periodic watchdog
alarms need to be created in kernel mode.<br><br>I would like to know:<br>1. Are there any tutorials/examples for Xenomai? I am aware of the examples at:<br>
<a href="http://www.xenomai.org/documentation/branches/v2.4.x/html/api/index.html" target="_blank">http://www.xenomai.org/documentation/branches/v2.4.x/html/api/index.html</a><br>and<br><a href="http://www.captain.at/xenomai.php" target="_blank">http://www.captain.at/xenomai.php</a><br>

<br>2. How do I create a kernel module? (what is the compiler command?)<br>If I try defining &quot;__KERNEL__&quot; and &quot;MODULE&quot; then I get a large number of errors in the xenomai/linux includes.<br><br>I would like to create a simple &#39;hello world&#39; module:<br>

<br>#include &lt;nucleus/module.h&gt;<br>#include &lt;native/task.h&gt;<br><br>int init_module(void) {<br>&nbsp;printk(&quot;&lt;1&gt;Hello World 1.\n&quot;);<br>&nbsp;return 0;<br>}<br><br>void cleanup_module(void) {<br>&nbsp;printk(KERN_ALERT,&quot;Goodbye world 1.\n&quot;);<br>

}<br>(The first error I recieve on compiling is &quot;error: variable or field &#39;xnpod_declare_tbase_proc&#39; declared void&quot;, using <br>g++ hello.c -c -I/usr/include/xenomai -D_GNU_SOURCE -D_REENTRANT -D__XENO__ )<br>
<br>
Thanks!<br>-Adrian<br>

------=_Part_4589_25638191.1226479274863--

