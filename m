From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <abaf774b0904090253t229e5fd1w6ed30a1e1199a02f@domain.hid>
References: <abaf774b0904090253t229e5fd1w6ed30a1e1199a02f@domain.hid>
Content-Type: text/plain
Date: Thu, 09 Apr 2009 12:21:49 +0200
Message-Id: <1239272509.7007.58.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] SIGSEGV Segmentation fault during malloc within
 Xenomai POSIX thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve <sbxenomai@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2009-04-09 at 10:53 +0100, Steve wrote:
> Hi,
> 
> I am new to Xenomai (and mailling lists), and have been porting a
> working c++ RTAI program so that it runs on Xenomai using POSIX
> threads, sempahores, etc.  I have succeeded in getting the new version
> of the application running and starting to initialise its various
> components, part of which involves creating threads through a common
> function.  However it seg faults part way through the main thread when
> instantiating an object with the 'new' keyword, and the stack trace
> shows that malloc is the last identifiable call before the fault:
> 
> Call Stack:
> 0xb7ac6f3c ??() /lib/tls/i686/cmov/libc.so.6
> 0xb7ac8cad malloc() /lib/tls/i686/cmov/libc.so.6
> 0xb7da3097
> ObjectName::CurrentFunction(this=0x0b70a531c) /path-to-file/file.cpp
> ...
> 
> I can't post the entire code here, but have not been able to replicate
> this with a simpler example.  However, I can reproduce it exactly
> using malloc in the lines before the call.  I have put an example that
> creates threads and schedules them in a way similar to the full
> program at the end of this email for reference.  The actual call that
> faults is:
> Object *Instance = new Object(StringVar.c_str(), Pointer);

> The same fault was replicated on the line before by inserting:
> char *testWord;
> testWord = (char *) malloc(1000 * sizeof(char));
> 
> Or by inserting:
> char *testWord;
> testWord = (char *) malloc(500 * sizeof(char));
> testWord = (char *) malloc(500 * sizeof(char));
> 
> Or by inserting:
> char *testWord;
> testWord = (char *) malloc(500 * sizeof(char));
> free(testWord);
> testWord = (char *) malloc(500 * sizeof(char));
> 
> The last of these confuses me the most, because in theory the memory
> has been freed and so the second call is no worse off than the first,
> but it seg faults.  This is made worse by the fact that I can call
> malloc and free as many times as I like (i.e. more than 10) on memory
> blocks of size 100*(sizeof(char)), and can call malloc on 11 blocks of
> size 100*(sizeof(char)) without freeing it before the 12th call seg
> faults.
> 
> I am out of ideas - I cannot use Valgrind because Xenomai and Valgrind
> don't play well yet - and am positing this issue here because the
> faulty piece of code worked fine before the Xenomai port.  My only
> thought is that it might be caused by some sort of paging error as a
> result of using MLockAll(), but if so I do not know what to do about
> it.
> 

The port may have uncovered some hidden issue in your code as well.
Using glibc's built-in malloc debug features, I would suggest to:

export MALLOC_CHECK_=1
then run your app; you might get more information.

export MALLOC_CHECK_=2
will trigger an abort() when/if any heap corruption is detected.

Calling mcheck() to verify whether the heap is still fine is another
option.

-- 
Philippe.



