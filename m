Message-ID: <53C66222.7060502@xenomai.org>
Date: Wed, 16 Jul 2014 13:29:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <freemail.20140716132305.70554.1@fmxmldata05.freemail.hu>
In-Reply-To: <freemail.20140716132305.70554.1@fmxmldata05.freemail.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Memory paging trouble
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paal Tamas <paal_to@freemail.hu>, xenomai@xenomai.org

On 07/16/2014 01:23 PM, Paal Tamas wrote:
> Dear All, I am using Xeno 2.6.3 together with a 3.0.15 Linux kernel
> on an i.MX6 ARM hardware. I am using the Posix skin.I have a memory
> paging problem inmy user mode app. I don&#39;t get any error message,
> only the contents of my memory buffer gets messed up. I try to
> describe what I see and what I suspect in as less words as possible:
> I allocate (using malloc) a buffer which is  more then 3 memory pages
> long (a page is 4096bytes in my case). I write a few bytes to the
> beginning, then a few bytes to the end, save the contents ina file.
> After that I fill the rest of the buffer from the beginning till the
> end and save the contents again into a file. I write unsigned int
> values into it starting with zero counting up to 3999.After this
> procedure the buffer should look like this (I indicate the memory
> page boundaries according to my test app):
> Page1.0.833Page2834.1857Page31858.2881Page42882.3905Page53906.3999
> But the content of the buffer looks like this:
> Page1.0.833Page22882.3905Page3288 2.3905Page42882.3905Page53906.3999
> It seems that the second and third pages, which were not added to the
> virtual memory of the process in the first cycle (because I wrote
> data only into the address ranges of the first and  fourth pages
> then) are &#39;missing", and the content of the fourth page show up
> on the address range of the second and third page. I see this strange
> behaviour only if I allocate this buffer in a Xenomai thread. If I do
> the allocation in the main thread of the process (e.g. in the main()
> function) the memory will not be corrupt!If I compile the same source
> code to native Linux and running on the same hardware, on the same
> kernel, it works fine, no memory corruption can be seen this time
> either. I found the following workarounds:WA1.: Initialize the buffer
> from the beginning to the end in a linear fashion after allocation
> (e.g. writing the bytes one after the other, ensure to add the memory
> pages one afte the other to the process).WA2.: Use calloc() instead
> of mal loc() which is the same workaround as WA1 wa! s. I am
> struggling with this issue since a week. Please help me where to
> search for the problem. In Xenomai, in the Linux kernel or in the
> stdlib? One more strange thing that I am not sure if it has anything
> to do with this issue. I do not get any runtime error if I DON&#39;T
> call mlockall()! Why is that? I read somewhere that some libraries
> call mlockall() during initialization. Is it true? Thank you,Tamas 

Quite frankly, your mail is unreadable. Could you try and post a clear
and readable mail, preferably with a piece of code allowing to
reproduce the issue you meet?
-- 
                                                                Gilles.

