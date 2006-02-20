Message-ID: <20060220105519.81962.qmail@domain.hid>
Date: Mon, 20 Feb 2006 02:55:19 -0800 (PST)
From: Cedric Herreman <glocker50@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-569904435-1140432919=:79484"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] binding to memory heap from user space
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

--0-569904435-1140432919=:79484
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello,
 
 I have created a memory heap in the init_module routine of a kernel module : 
 rt_heap_create(&heap_data,"RT_LOG_HEAP",sizeof(ttv_log_data),H_FIFO|H_SHARED);
 and 
 rt_heap_alloc(&heap_data,0,TM_NONBLOCK,&loc_ptr);
 Both calls return succesful.
 
 When i try to bind to this memory in an user space application :
 rt_heap_bind(&rt_heap,"RT_LOG_HEAP",TM_NONBLOCK);
 the call returns with error -2, this error does not seem to be documented (i test on all the constants defined in the html API docs, xenomai v2.0).
 
 Can anyone give me a hint on what's wrong here ?
 
 Cedric.
 
			
---------------------------------
 Yahoo! Mail
 Use Photomail to share photos without annoying attachments.
--0-569904435-1140432919=:79484
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello,<br> <br> I have created a memory heap in the init_module routine of a kernel module : <br> rt_heap_create(&amp;heap_data,"RT_LOG_HEAP",sizeof(ttv_log_data),H_FIFO|H_SHARED);<br> and <br> rt_heap_alloc(&amp;heap_data,0,TM_NONBLOCK,&amp;loc_ptr);<br> Both calls return succesful.<br> <br> When i try to bind to this memory in an user space application :<br> rt_heap_bind(&amp;rt_heap,"RT_LOG_HEAP",TM_NONBLOCK);<br> the call returns with error -2, this error does not seem to be documented (i test on all the constants defined in the html API docs, xenomai v2.0).<br> <br> Can anyone give me a hint on what's wrong here ?<br> <br> Cedric.<br> <p>
	
		<hr size=1> Yahoo! Mail<br> 
<a href="http://us.rd.yahoo.com/mail_us/taglines/pmall2/*http://photomail.mail.yahoo.com">Use Photomail</a> to share photos without annoying attachments.
--0-569904435-1140432919=:79484--

