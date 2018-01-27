References: <73ef1d0b-0a83-4351-e4b5-2a544956af86@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <c0f2a070-01fd-7045-d2d4-e1e92f63e997@xenomai.org>
Date: Sat, 27 Jan 2018 11:25:04 +0100
MIME-Version: 1.0
In-Reply-To: <73ef1d0b-0a83-4351-e4b5-2a544956af86@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] cobalt/intr: Move IRQ exit trace point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 01/26/2018 07:32 PM, Jan Kiszka wrote:
> It can be confusing for people reading a trace when a context switch due
> to a wake up in the IRQ handler comes before the handler was left. Move
> the exit instrumentation before the schedule, just like we already do in
> the clock handler.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Merged, thanks.


-- 
Philippe.

