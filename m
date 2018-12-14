Subject: Re: Waking up a linux thread from a xenomai thread, without mode
 switch
References: <9716cf94f871edebb580b4010a5c24465299514f.camel@sprinte.eu>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8ea368e9-c5f1-7df5-2634-b796e0a1e3e7@xenomai.org>
Date: Fri, 14 Dec 2018 12:22:28 +0100
MIME-Version: 1.0
In-Reply-To: <9716cf94f871edebb580b4010a5c24465299514f.camel@sprinte.eu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Julien Blanc <julien.blanc@sprinte.eu>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 12/14/18 11:48 AM, Julien Blanc via Xenomai wrote:
> Hi,
> 
> We’re currently using semaphores and a shared buffer to allow
> communication between a xenomai cobalt thread and a linux regular
> thread (the xddp interface has been tested and does not perform well
> for our use case, which is exchanging a lot a very small messages).
> 

Did you try the streaming output mode with MSG_MORE as illustrated in
demo/posix/cobalt/xddp-stream.c? The streaming mode attempts to pack
multiple messages from the rt-side into a single message delivered to
the read() side, until the latter eventually resumes.

IOW, if the rt-side is able to send N messages before the linux side
eventually wakes up, then the latter will receive all the streamed
output packed into a single read().

-- 
Philippe.

