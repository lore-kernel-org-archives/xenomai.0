From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-help] Error: cat: /proc/xenomai/stat: Cannot allocate
	memory
Date: Mon, 5 Feb 2007 16:05:01 +0000
References: <19981456.1170405795640.JavaMail.ngmail@domain.hid>
	<b647ffbd0702040554m4f9569f1u4b976bc292c6f94c@domain.hid>
	<b647ffbd0702040601x4352c3acya1dd1ae1d5dc63e6@domain.hid>
In-Reply-To: <b647ffbd0702040601x4352c3acya1dd1ae1d5dc63e6@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702051605.01163.paul_c@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

On Sunday 04 February 2007 14:01, Dmitry Adamushko wrote:
> ok, could somebody post 2 snapshots of /proc/meminfo taken :
>
> [1] a few seconds after starting the test;
>
> [2] quite some time later when the memory leak is already noticeable
> (but the test is still running)

Sixteen minutes of logs at 
http://zathras.tuxcnc.org/vmstats/procmeminfo.log.bz2 - Was running a cat 
of /proc/ipipe/Linux on an x86_64 patched 2.6.19.2. Looks like there may well 
be a problem there..

 Shortly after terminating the test, I experienced a serious OOM kill when 
starting up a memory testing utility - Don't quite know what happened, but 
ended up having to reboot and then running fcsk on a corrupted root 
partition.


Regards, Paul.


