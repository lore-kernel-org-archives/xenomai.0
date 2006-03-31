Message-ID: <442D8580.9020507@domain.hid>
Date: Fri, 31 Mar 2006 14:39:44 -0500
From: Randy Smith <rsmith@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Questions porting existing rtai-24.1.12 app to
	xenomai
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

Hello list,

I'm confused and I hope someone can illuminate a path to enlightenment.  
Please be gentle. :-)

I have inherited some linux 2.4.25 kernel module code for a powerpc that 
uses rtai-24.1.12.  In my xenomai enabled kernel, I have disabled native 
support and enabled the RTAI emulator.  This works as far as I know.  I 
can insmod it at least but to test it, I need some user mode code and 
that is where I am running into problems.

The kernel module runs as a periodic task and uses kernel mode shared 
memory to communicate with the user mode application.  The user mode 
application uses rtai_malloc to allocate the shared memory that the 
kernel module created with rtai_kmalloc.  My application fails to link 
since librtai.so cannot resolve the call to rtai_malloc.  What should I 
migrate the rtai_malloc call to in order to use the rtai skin with xenomai??

Can I not communicate kernel to user via shared memory in that skin?

I get the feeling that this is an old api that xenomai doesn't support, 
is this the case?

Any help would be appreciated.

Thanks,

-Randy Smith
Software Engineer
ImageMap, Inc.

