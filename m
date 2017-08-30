References: <CAF06wtj2YM_Ue0Hzw5+LChWtve_3ta390aAu0CixsCQd+12bwg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <04c0f132-1d4a-4c7e-c273-56d09da07696@xenomai.org>
Date: Wed, 30 Aug 2017 09:20:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAF06wtj2YM_Ue0Hzw5+LChWtve_3ta390aAu0CixsCQd+12bwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Issues building old drivers under Xenomai 3.0.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jlangston@panurgyinc.com, xenomai@xenomai.org

On 08/30/2017 03:17 AM, Jim Langston wrote:
> Hi all,
> 
> I'm having trouble getting an old driver originally built for Xenomai 2.4
> to build under Xenomai 3.0.5.  The code won't build under Ubuntu 16.04
> patched with Xenomai 3.0.5 and kernel 4.9.24 and the IPipe patch for 4.9.24.
> 
> The problem seems to revolve around include pathing, and the simplest case
> I can put together is as follows:
> 

<snip>

> Does anyone have a driver that they could post up that uses the heap
> functions, a sample 'Makefile' with different flags/include options, or any
> suggestions on how to resolve the include file mess here?
> 

The former "native" API of Xenomai 2.x is no more available in kernel
space with Xenomai 3.x, as hosting application code there is discouraged.

With the latter, the only kernel space API is RTDM, for writing drivers.
If you need a real-time allocator in kernel space to ease your port,
there is still the option of tapping into the Cobalt core inner
interface, using the xnheap_* services.

-- 
Philippe.

