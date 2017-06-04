References: <CAF06wtgV=DewshLh48CMNFy3J7SzBk06ToJjaQsXpF2+TkBqoA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6f55db98-0988-3b9f-f1dc-6f393211af4d@xenomai.org>
Date: Sun, 4 Jun 2017 18:43:47 +0200
MIME-Version: 1.0
In-Reply-To: <CAF06wtgV=DewshLh48CMNFy3J7SzBk06ToJjaQsXpF2+TkBqoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Issues with Xenomai 3.0.5...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jlangston@panurgyinc.com, xenomai@xenomai.org

On 06/04/2017 06:34 PM, Jim Langston wrote:
> Hello,
> 
> I am attempting to run Xenomai 3.0.5 on an embedded system.
> 
> It is being built using Buildroot 2017.02.2, Xenomai 3.0.5, Kernel 4.1.18,
> Adeos patch 4.1.18 #9.

I cannot infere the CPU architecture from this information.

> The resultant image boots, and I can see that Xenomai is running:
> 

[snip]

> > Any ideas on where i could start looking about?  I don't see any causality
> here...
> 

Could you run the latency utility over gdb and get a stack backtrace
when it breaks?

For the backtrace to be meaningful, you will need to pass
--enable-debug=symbols to the configure script for building Xenomai's
user-space libs and programs.

-- 
Philippe.

