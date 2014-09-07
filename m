Message-ID: <540C85F1.4070809@gatech.edu>
Date: Sun, 07 Sep 2014 12:21:05 -0400
From: "Yogi A. Patel" <yapatel@gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] mlockall and dlopenskins?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi -

I used to provide --enable-posix-auto-mlockall --enable-dlopen-skins as 
options to the configure script when compiling user space support. 
However in 2.6.3 I get a warning saying those are unrecognized options.

Now. I was looking online at the documentation and found the following:

/Xenomai libraries only invoked mlockall if a special option was passed 
to the configure script when compiling Xenomai user-space support. So, 
applications which did not want to depend on this configuration had to 
call mlockall by themselves, before using any Xenomai service, by using://
//
//mlockall(MCL_CURRENT | MCL_FUTURE);/

This is slightly vague and hard to understand. The warnings make it 
obvious that the enable-posix-auto-mlockall call does nothing when used 
during compile. Does this mean that in 2.6.3 and above mlockall is 
included in user space libraries by default (requring no changes to our 
software besides removing that flag from the compile)?

And what about enable-dlopen-skins? I can't find any documentation 
online on that changing in 2.6.3.

Thanks!

-- 
Yogi
