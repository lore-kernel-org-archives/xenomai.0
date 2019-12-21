Subject: Re: [PATCH] powerpc: ipipe: Do full exit checks after
 __ipipe_call_mayday
References: <d93a6092-b340-b74b-ff3d-51ac5c438c25@siemens.com>
 <fd31a72f-ac46-034b-bfc6-4e125b4fde78@siemens.com>
 <6045179.LjjW8XADSc@omoikane>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c1a54128-c65f-3737-92e7-d85fc9755702@siemens.com>
Date: Sat, 21 Dec 2019 13:09:11 +0100
MIME-Version: 1.0
In-Reply-To: <6045179.LjjW8XADSc@omoikane>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steven Seeger <steven.seeger@flightsystems.net>
Cc: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

On 21.12.19 00:38, Steven Seeger wrote:
> On Thursday, December 19, 2019 11:53:36 AM EST Jan Kiszka wrote:
>>> Ho, ho, this is an early X-mas gift.
> 
> Jan,
> 
> I got "gdb ok" when I removed the block I had in the entry_32.S I sent you
> around the recheck/do_user_signal path. I was pretty sure I didn't need the
> intret there.
> 
> Do you remember if you did that as well on your board?

Nope, I don't. But one of the blocks was indeed redundant, if not worse.

> 
> This s the first time the test has passed for me without the extra trace
> prints in smokey's gdb.c. In fact I got the latest xenomai next branch and
> tested with that.
> 
> Some good news: your uclibc fix worked beautifully and I can now build the
> stock xenomai distro with my board without any of my other patches.
> 
> I'm going to look at the mayday/DoSyscall issue you suggested now. I'll be
> checking in a cleaned up entry_32.S as well. Will probably be Monday or so but
> expect 20 more emails from me until then as per my usual pattern. (You cc'd
> the list, so now the list must suffer the consequences of your actions.)

Perfect!

Jan

