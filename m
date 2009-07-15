Message-ID: <4A5DDB79.8070004@domain.hid>
Date: Wed, 15 Jul 2009 15:36:57 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A01B1A843@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A01B1A843@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtdm_lock_init does not compile with
 ppc-ipipe-patch 2.0.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

Hi Roderik,

roderik.wildenburg@domain.hid wrote:
> When I try to compile RTnet (for PPC, Xenomai 2.4.8, Ipipe 2.0.1, Kernel
> 2.4.25) I get the following error message :
> 
> In file included from rtdev.c:33:
> ../stack/include/rtskb.h: In function `rtskb_queue_init':
> ../stack/include/rtskb.h:289: error: parse error before '{' token
> ../stack/include/rtskb.h: At top level:
> ../stack/include/rtskb.h:290: error: parse error before '->' token
> ../stack/include/rtskb.h: In function `rtskb_prio_queue_init':
> ../stack/include/rtskb.h:301: error: parse error before '{' token
> rtdev.c: In function `rtdev_alloc':
> rtdev.c:243: error: parse error before '{' token

A similar issue has been reported on the RTnet-users ML by Thomas. What
version of RTnet are you using? 0.9.11 is broken!!! See also:

http://sourceforge.net/mailarchive/forum.php?thread_name=4A4B9610.9080708%40grandegger.com&forum_name=rtnet-users

Wolfgang.

