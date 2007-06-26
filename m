Message-ID: <4680ADF3.9050102@domain.hid>
Date: Tue, 26 Jun 2007 08:10:59 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <467FBC67.8030805@domain.hid>	<cbe23c50706250904i57afbc0xfbce52fdb9dccc66@domain.hid>
	<cbe23c50706250905r38f1471ak72d82bc58c31b259@domain.hid>
In-Reply-To: <cbe23c50706250905r38f1471ak72d82bc58c31b259@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Fwd:  Xenomai and mlockall
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Eric Noulard wrote:
> 2007/6/25, Johan Borkhuis <j.borkhuis@domain.hid>:
>   
>> I am trying to run my Xenomai application as non-root. I disabled
>> XENO_OPT_SECURITY_ACCESS to allow non-root users to run Xenomai
>> applications. However, this causes my application to exit with the error:
>>
>> Xenomai: process memory not locked (missing mlockall?)
>>
>> Is there a way to avoid this error? I am running on an embedded system
>> without swap and without disk, so there is no real need for mlock or
>> mlockall.
>>     
>
> I may be wrong but even on embedded system without
> mlockall(MCL_FUTURE) how can you be sure the memory you get from from
> a dynamically allocated memory (malloc/calloc etc...) is
> currently allocated in PHYSICAL memory?
>   
I disabled swap, and also I don't have a physical disc connected to the 
system. The system boots from a TFTP server, and the root file system is 
mounted using NFS. So I think I can be pretty sure that all allocated 
memory is in physical memory :-)

>> Is there a way to "tweak" the CAP_IPC_LOCK capability of the system or
>> the task so that I can run mlockall call,
>>     
>
> May be you can use 'sudo' to run the task?
>   

That is a possibility, but I prefer application to run as a regular user 
and not as root.

I did find another way/hack around this problem. After looking in the 
kernel I found out that the maximum amount of locked memory is limited 
to 32 kbyte (= 8 pages) for a regular user (see also "ulimit -a") and 
this limit is hard-coded into the kernel. My application asked to lock 
just over 600 pages, so this was not allowed
After increasing this allowed amount to a much larger value the mlockall 
succeeded and the application runs OK:

==============
--- linux-2.6.14/include/linux/resource.h 2005-10-28 02:02:08.000000000 
+0200
+++ linux-2.6.14-mot/include/linux/resource.h 2007-06-25 
15:46:16.622475000 +0200
@@ -59,7 +59,7 @@
* GPG wants 32kB of mlocked memory, to make sure pass phrases
* and other sensitive information are never written to disk.
*/
-#define MLOCK_LIMIT (8 * PAGE_SIZE)
+#define MLOCK_LIMIT (4096 * PAGE_SIZE)

/*
* Due to binary compatibility, the actual resource numbers
==============

Kind regards,
Johan Borkhuis

