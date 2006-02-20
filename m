Message-ID: <20060220145625.46347.qmail@domain.hid>
Date: Mon, 20 Feb 2006 06:56:25 -0800 (PST)
From: Cedric Herreman <glocker50@domain.hid>
Subject: Re: [Xenomai-help] binding to memory heap from user space
In-Reply-To: <17401.48496.769816.273046@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1117652245-1140447385=:44600"
Content-Transfer-Encoding: 8bit
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

--0-1117652245-1140447385=:44600
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote: Cedric Herreman wrote:
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
 > the call returns with error -2, this error does not seem to be documented (i test on all the constants defined in the html API docs, xenomai v2.0).
 >  
 >  Can anyone give me a hint on what's wrong here ?

-2 is -ENOENT, no such file or directory.

You are probably missing the /dev/rtheap file. In order to create it,
run "make devices" with root privileges.

         Gilles Chanteperdrix.
Yes, i was. I added the file on the target system (doesn't have the src tree, so i can't "run make devices")  like this :
 mknod /dev/rtheap b 1 0
 
 Now, it is giving me the error : -EPERM. The doc says the call is made from a context that cannot sleep (interrupt, non-realtime, scheduler locked). Is it not possible to link to shared mem from a non-realtime userspace application in this way ?
 
 Cedric.

		
---------------------------------
Brings words and photos together (easily) with
 PhotoMail  - it's free and works with Yahoo! Mail.
--0-1117652245-1140447385=:44600
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<b><i>Gilles Chanteperdrix &lt;gilles.chanteperdrix@xenomai.org&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Cedric Herreman wrote:<br> &gt; Hello,<br> &gt;  <br> &gt;  I have created a memory heap in the init_module routine of a kernel module : <br> &gt;  rt_heap_create(&amp;heap_data,"RT_LOG_HEAP",sizeof(ttv_log_data),H_FIFO|H_SHARED);<br> &gt;  and <br> &gt;  rt_heap_alloc(&amp;heap_data,0,TM_NONBLOCK,&amp;loc_ptr);<br> &gt;  Both calls return succesful.<br> &gt;  <br> &gt;  When i try to bind to this memory in an user space application :<br> &gt;  rt_heap_bind(&amp;rt_heap,"RT_LOG_HEAP",TM_NONBLOCK);<br> &gt; the call returns with error -2, this error does not seem to be documented (i test on all the constants defined in the html API docs, xenomai v2.0).<br> &gt;  <br> &gt;  Can anyone give me a hint on what's wrong here ?<br><br>-2 is -ENOENT, no such file or directory.<br><br>You are probably
 missing the /dev/rtheap file. In order to create it,<br>run "make devices" with root privileges.<br><br>         Gilles Chanteperdrix.<br></blockquote>Yes, i was. I added the file on the target system (doesn't have the src tree, so i can't "run make devices")&nbsp; like this :<br> mknod /dev/rtheap b 1 0<br> <br> Now, it is giving me the error : -EPERM. The doc says the call is made from a context that cannot sleep (interrupt, non-realtime, scheduler locked). Is it not possible to link to shared mem from a non-realtime userspace application in this way ?<br> <br> Cedric.<br><p>
		<hr size=1>Brings words and photos together (easily) with<br> 
<a href="http://us.rd.yahoo.com/mail_us/taglines/PMall/*http://photomail.mail.yahoo.com">PhotoMail </a> - it's free and works with Yahoo! Mail.
--0-1117652245-1140447385=:44600--

