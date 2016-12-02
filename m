Date: Fri, 2 Dec 2016 12:38:55 +0100 (CET)
From: Michael Wisse <mwisse@hs-harz.de>
Message-ID: <1789140873.1763769.1480678735123.JavaMail.zimbra@hs-harz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] porting xenomai2 modules to xenomai3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I try to get compiled some xemomai2 kernel modules with native-api to xenomai3 alchemy.
I have build a single kernel xenomai configuration (mercury) with a centos 3.10.0 kernel.

The Makefile from xenomai2 does not work anymore. The Makefiles from xenomai3 demo directory are very complex. Can I use therm for compiling an own module?

The most important question is, will this generally work, alchemy kernel modules with xenomai mercury? 
My modules work with pipes and the alchemy/pipe.h includes a pipe.h from cobalt/uapi/kernel, so I am afraid not.   
What can I do with manageable effort?
 
Thanks for support and regards
Michael

