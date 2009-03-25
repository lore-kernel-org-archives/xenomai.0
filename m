From: Vandana Sasidharan <vandana.sasidharan@domain.hid>
MIME-Version: 1.0
Sender: Vandana Sasidharan <vandana.sasidharan@domain.hid>
Date: Wed, 25 Mar 2009 19:48:37 +0530
Message-ID: <OF5B5E5AC3.6A0C34CA-ON65257584.004E9C1C-65257584.004E9C2A@tcs.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Xenomai-help]  Error in adapter.cc during the "make" of xenosim
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


HI,

Following the below query posted yesterday,
I tried using previous versions of xenosim(as per the reply), but still
could not resolve the below errors in adapter.cc.
Just to go forward I commented the lines in adapter.cc where I found
errors.

Further when I started recompiling, I got errors in queue.h and heap.h in
under native skin,
This is what I am getting:

2.4.7/../include/nucleus/pod.h:34,

from /usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/module.c:31:
/usr/include/bits/pthreadtypes.h:69: warning: unnamed struct/union that
defines no instances
In file included
from /usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/module.c:44:
/usr/src/xenomai-2.4.7/xenosim-2.4.7/../include/native/queue.h:136: syntax
error before `*'
In file included
from /usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/module.c:45:
/usr/src/xenomai-2.4.7/xenosim-2.4.7/../include/native/heap.h:122: syntax
error before `*'
make[2]: *** [module.o] Error 1
make[2]: Leaving directory
`/usr/src/xenomai-2.4.7/xenosim-2.4.7/sim_bld/skins/native'
make[1]: *** [all-recursive] Error 1


Please can you help and let me know where I am going wrong?

Thanks & regards,
Vandana

---------------------------------------------------------------------------

Hi,

First of all sorry for mailing to Xenomai-core.

Can you please tell me whether I should switch to the older distribution of
xenosim, Linux or Tix, I am a bit confused regarding the same and it would
be be really great if you you could clarify it. In case if
it is Tix where can I get the download? Thanks in advance.

For those who dont know what error I am getting:-

an error occurs when I am trying to "MAKE" Xenosim- 2.4.7.
I have already installed Xenomai- 2.4.7 along with libelf -0.8.10 , Tcl
8.3.5, Tk 8.3.5 , Tix 4.1.0.007 and an adeos patch that is adeos-ipipe
-2.6.25-x86-2.0-08.patch on a linux kernel which we built which has a
version Linux 2.6.25.11.
after configuring Xenosim along with the gcc -2.95.3 tar .gz when I try to
"make" the xenosim I'm getting an error :

xenomai-2.4.7/xenosim-2.4.7/adapter/adapter.cc: 65: error :too few
arguments
xenomai-2.4.7/xenosim-2.4.7/adapter/adapter.cc: 67: error :too few
arguments

Kind Regards,
Vandana.

=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you




