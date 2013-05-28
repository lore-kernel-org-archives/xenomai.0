Message-ID: <51A4A22D.2090308@siemens.com>
Date: Tue, 28 May 2013 14:25:17 +0200
From: Gernot Hillier <gernot.hillier@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] compiler error due to __extension__ attribute in POSIX
	skin headers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi there!

The recent commit "posix: allow headers compilation with GCC pedantic 
flag" added the "__extension__" attribute in front of #include_next 
directives, likely to flag them as GNU extensions. This, however, 
introduced compiler errors for us when we include those headers from C++ 
code.

This can be easily reproduced with the following code snippet using the 
POSIX skin:

--------
extern "C" {
# include <signal.h>
}
int main() {}
--------

At least with gcc 4.6 (which is the most current version available in 
Ubuntu 12.04 LTS), this gives:

# g++ `xeno-config --skin posix --cflags --ldflags` test.cpp
test.cpp:3:1: error: expected unqualified-id before '}' token

Having a closer look (e.g. by looking at the preprocessor output with 
-E), we found that the __extension__ attribute is not understood by the 
preprocessor and thus not removed when resolving #include_next. So after 
the preprocessor run, #include_next is replaced by the actual content of 
the signal.h header, but __extension__ stays there.

Usually, this doesn't harm too much as some code will likely follow from 
the included header which is accepted after __extension__.

In the special case of signal.h, however, as it has two subsequent 
#include_next<signal.h> statements, the latter is replaced by an empty 
string, so that __extension__ ends up right in front of the } token of 
the extern "C" block. Thus, we see the compiler error cited above.

Even if it doesn't harm in most cases, I think that  __extension__ is 
not the correct way to tag GNU preprocessor extensions (you don't see 
this in libstdc++ neither wget or other popular code snippets using 
#include_next).

The "official" way I found is to tell the compiler that your header is a 
system header - in that case, #include_next is also accepted in pedantic 
mode. This is either reached by using -isystem for the search path of 
such headers or by adding this line to the header:

#pragma GCC system_header

Both solutions worked for me and prevented any warning in gcc pedantic 
mode. However, I'm not really sure about other possible side effects 
they could have, so any further insight is greatly welcome...

-- 
Regards,
Gernot

Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux


