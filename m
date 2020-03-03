From: LOCHE Daniel <dloche@laas.fr>
Subject: rt_buffer_read, error #24 ("Too Many Files" ?)
Message-ID: <1a966c5c-6779-a527-07d5-61a8a2b283b9@laas.fr>
Date: Tue, 3 Mar 2020 15:59:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I am quite confused.

I have several real-time tasks created from a fork + rt_task_shadow.
My app uses a shared buffer where 1 to multiple processes can write to, 
and a process with a task dedicated to read the buffer content.

- I manage to create the buffer :

struct MessageStructure { int ID; RTIME time; bool state; };
rt_buffer_create(&_buff, "BUFFER_NAME", 20*sizeof(MessageStructure), 
B_FIFO);

(=> return value is 0.)
- I also manage to bind to it from the other processes :

rt_buffer_bind(&_buff, "BUFFER_NAME", 500*1000);

(=> return value is 0 too.)

- Issue is, even with only 2 processes (one Writer and the Reader), when 
the first Read is executed, it returns me a Error #24.

MessageStructure msg;
rt_buffer_read(&_buff, &msg, sizeof(MessageStructure), TM_INFINITE);

=> return value is 24.


 From syserror(), I get that this is a "Too many open files" error, but 
I don't understand why... Any clue ?
Do other Alchemy objects enter into account for the "file count" that I 
should mention..?

Daniel

PS : I managed to solve my last issue with rt_task_bind and shared 
objects. I'l make a summary about it when time permits me. :)


