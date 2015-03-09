MIME-Version: 1.0
Date: Mon, 9 Mar 2015 10:23:57 +0100
Message-ID: <CABrBNa37KKSvy9UP1cF7ovicMh1m_OEOjar-yQyqujdMUn5=8w@mail.gmail.com>
From: Sergi Ruiz <sergi.ruiz06@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Real-time inter-task communication
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

I'm working on implementing a library that contains two tasks. One has to
be a rt task running in primary mode. The second one could be a rt task
running in primary mode or a Linux thread. And between this two task is
needed some mechanism of communication.

So the user could choose between having a communication NRT-RT or RT-RT.
The communication in the first choice (NRT-RT) is done using xddp sockets.
And now I'm trying to implement something similar but for two real-time
tasks. So what could be the best solution to communicate two real-time
tasks having a similar behavior as sockets?

I tried to use message queues services limiting queues to 1 message but I
don't obtain what I expected. I would want that the message was overwritten
as sockets because the tasks can have different periods and I only want to
read the last data written in the queue, socket or whatever was the method
used.

Thanks in advance.

Sergi
