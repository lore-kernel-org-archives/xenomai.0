Message-ID: <4506F853.6060502@domain.hid>
Date: Tue, 12 Sep 2006 14:11:31 -0400
From: Randy Smith <rsmith@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Proper module_cleanup procedure
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

Hello,

I am running the 2.4 kernel with Xenomai-2.1.0 native skin and I have a 
kernel module that creates 2 shared memory heaps and then creates a a 
periodic realtime task to do some interesting things.  This periodic 
realtime task communicates with a linux user mode task through the 
shared memory that gains access to it through rt_heap_bind/rt_heap_alloc 
calls.  Things go along swimmingly.

I now want to be able to do an "rmmod" on the module and in its cleanup 
routine, right now I just have rt_heap_delete calls for the two shared 
memory heaps.  This completes successfully, but if I then try to install 
another version (debug for instance) of the module with "insmod", I get 
a memory error. 

Is this is due to the fact that I didn't suspend the periodic realtime 
task and then delete it before deleting the heaps?  Is this necessary?  
Are there any use counts or other signs that I could check to ensure 
that everyone was finished with the heaps so that I can delete them?

Is there any consequence to the user mode task due to jerking the rug 
out from under it?

Thanks,

Randy Smith
Software Engineer
ImageMap, Inc.

