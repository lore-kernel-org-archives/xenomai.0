References: <1789140873.1763769.1480678735123.JavaMail.zimbra@hs-harz.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <bf4439ee-3195-279f-732a-1d4de62b1d94@xenomai.org>
Date: Fri, 2 Dec 2016 13:26:00 +0100
MIME-Version: 1.0
In-Reply-To: <1789140873.1763769.1480678735123.JavaMail.zimbra@hs-harz.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] porting xenomai2 modules to xenomai3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Wisse <mwisse@hs-harz.de>, xenomai@xenomai.org

On 12/02/2016 12:38 PM, Michael Wisse wrote:
> Hello,
> 
> I try to get compiled some xemomai2 kernel modules with native-api to xenomai3 alchemy.
> I have build a single kernel xenomai configuration (mercury) with a centos 3.10.0 kernel.
> 
> The Makefile from xenomai2 does not work anymore. The Makefiles from xenomai3 demo directory are very complex. Can I use therm for compiling an own module?
> 

You must be looking at the autoconf-generated Makefiles, the original
template (Makefile.am) is only 20 lines long. Those Makefiles are part
of Xenomai's internal build system to produce the demos automatically,
they are not intended to inspire user application Makefiles. Please
refer to the generic documentation for building kernel modules:
https://www.kernel.org/doc/Documentation/kbuild/modules.txt

> The most important question is, will this generally work, alchemy kernel modules with xenomai mercury? 

No.

- there can't be such things as alchemy kernel modules, since xenomai3
discontinued support for user APIs in kernel space.

- using the mercury core with Xenomai means going for a single kernel
system, not a dual kernel configuration. In this case, you fully depend
on the real-time capabilities of the underlying Linux kernel. The other
option is using Xenomai's cobalt core, which implements a co-kernel
matching the one you had with xenomai2. In any case, alchemy is only
available from user-space, you can't write kernel modules with such API.

> My modules work with pipes and the alchemy/pipe.h includes a pipe.h from cobalt/uapi/kernel, so I am afraid not.   
> What can I do with manageable effort?

You could give details about the general architecture of your software,
such as which part runs in kernel space and why does it have to
(functionally speaking). This should normally cover the topic of using
message pipes, giving people some clues to answer your question.

You may want to read this document too:
http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/

-- 
Philippe.

