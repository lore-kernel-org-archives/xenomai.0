Subject: Re: [PATCH] copperplate: heapmem: Handle size == 0 cleanly for
 heapobj_init_array_private
References: <a671814f-93a9-9ca7-2c8a-cf12e55156bd@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <dd7e81b2-b2ba-daa0-208d-0133a697c517@xenomai.org>
Date: Thu, 17 Oct 2019 21:05:00 +0200
MIME-Version: 1.0
In-Reply-To: <a671814f-93a9-9ca7-2c8a-cf12e55156bd@siemens.com>
Content-Type: text/plain; charset=utf-8
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 10/17/19 8:00 PM, Jan Kiszka via Xenomai wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Reported by clang-9 scan-build: When size is 0, we will shift 1 beyond
> the size of 'size'. That's undefined behavior.

size == 0 is invalid call for this internal interface, any caller passing zero is broken. A simple assert() would suffice.

-- 
Philippe.

