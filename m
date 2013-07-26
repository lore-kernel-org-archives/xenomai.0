Message-ID: <51F2D6E9.5080108@xenomai.org>
Date: Fri, 26 Jul 2013 22:07:05 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAH9k9C-uqb3Y2j9UzGdKv-p67X2Vz11yiidb_oYuB5MiQ0y03A@mail.gmail.com>
In-Reply-To: <CAH9k9C-uqb3Y2j9UzGdKv-p67X2Vz11yiidb_oYuB5MiQ0y03A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Queue issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?UmljYXJkbyBBbcOpenF1aXRh?= <ramezquitao@cihologramas.com>
Cc: xenomai@xenomai.org

On 07/26/2013 09:28 PM, Ricardo Amézquita wrote:
> Hello All
>
> I'm writing a simple wrapper in python to be able to control some real-time
> processes. To communicate between the real-time process, and the python
> process I'm using native queues. Sending messages from the python process
> to the realtime process is working fine, but when I try to send a message
> from the realtime process to the python process, I'm having problems. Using
> rt_queue inquire, I know that the message is in the queue, but the receive
> function in the python side, never receives it.
>
> Is there a limitation that apply to my application? I have tested with
> pipes, and it works, but I want to implement everything using queues.
>

If your python process is not supposed to run Xenomai services at all, 
i.e. mere Linux application not even linked with the Xenomai libraries, 
then message pipes are definitely what you are looking for. Queues won't 
work, since the python side won't be allowed to receive from a real-time 
queue.

-- 
Philippe.

