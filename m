From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17401.48496.769816.273046@domain.hid>
Date: Mon, 20 Feb 2006 14:00:32 +0100
Subject: Re: [Xenomai-help] binding to memory heap from user space
In-Reply-To: <20060220105519.81962.qmail@domain.hid>
References: <20060220105519.81962.qmail@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cedric Herreman <glocker50@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Cedric Herreman wrote:
 > Hello,
 >  
 >  I have created a memory heap in the init_module routine of a kernel module : 
 >  rt_heap_create(&heap_data,"RT_LOG_HEAP",sizeof(ttv_log_data),H_FIFO|H_SHARED);
 >  and 
 >  rt_heap_alloc(&heap_data,0,TM_NONBLOCK,&loc_ptr);
 >  Both calls return succesful.
 >  
 >  When i try to bind to this memory in an user space application :
 >  rt_heap_bind(&rt_heap,"RT_LOG_HEAP",TM_NONBLOCK);
 >  the call returns with error -2, this error does not seem to be documented (i test on all the constants defined in the html API docs, xenomai v2.0).
 >  
 >  Can anyone give me a hint on what's wrong here ?

-2 is -ENOENT, no such file or directory.

You are probably missing the /dev/rtheap file. In order to create it,
run "make devices" with root privileges.

-- 


					    Gilles Chanteperdrix.

