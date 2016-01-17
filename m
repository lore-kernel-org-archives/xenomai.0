References: <08349b9576164b1daad6e10748bdc0be@mmambx3.global.ad>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <569BC5C9.9030202@xenomai.org>
Date: Sun, 17 Jan 2016 17:48:09 +0100
MIME-Version: 1.0
In-Reply-To: <08349b9576164b1daad6e10748bdc0be@mmambx3.global.ad>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-3.0.1 inter-process rt_queue_receive segfault
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thomas Axelsson <Thomas.Axelsson@cybercom.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: Max Popescu <Max.Popescu@cybercom.com>

On 01/15/2016 05:34 PM, Thomas Axelsson wrote:
> Hi,
> 
> We are trying to use Alchemy RT Message Queues between two different 
> processes in Xenomai 3.0.1. However, our receiving process segfaults 
> when it receives a message. Using gdb, we see that the SIGSEGV occurs in 
> rt_queue_receive_timed() when doing  "ret = (ssize_t)msg->size;" 
> (queue.c:851). Can you help us solve the problem?

The alchemy code is wrong, it should use offset-based references in this
case since the message crosses address spaces. I will have a look and
suggest a patch for testing. Thanks for reporting.

-- 
Philippe.

