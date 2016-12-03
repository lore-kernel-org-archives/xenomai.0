References: <8612d9e224a0f91950a3.1480491048@devws148.be.alcatel-lucent.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <561d42f3-a35f-b076-fdee-c09a695912a4@xenomai.org>
Date: Sat, 3 Dec 2016 18:18:27 +0100
MIME-Version: 1.0
In-Reply-To: <8612d9e224a0f91950a3.1480491048@devws148.be.alcatel-lucent.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] copperplate/mercury: introduce weak function
 to get OS max thread priority
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, xenomai@xenomai.org

On 11/30/2016 08:30 AM, Ronny Meeus wrote:
> This patch introduces a weak function in the mercury copperplate code
> that allows to put an upper limit on the priority used by the created thread
> objects.
> 
> Before this patch the complete OS scheduler's FIFO range was used and it was
> not possible to restrict it. Restricting it can be useful in case other
> activities (typically platform related things) need to get a higher priority
> than the application threads.
> 
> The example below shows what needs to be implemented in the application to
> restrict the range.

This looks weird. Any reason not to fix up the priority of your
application threads?

-- 
Philippe.

