Subject: Re: rt_buffer_read, error #24 ("Too Many Files" ?)
From: LOCHE Daniel <dloche@laas.fr>
References: <1a966c5c-6779-a527-07d5-61a8a2b283b9@laas.fr>
Message-ID: <fb3023b1-8bc5-7dc2-58e4-3693ab1d8faa@laas.fr>
Date: Tue, 3 Mar 2020 17:34:58 +0100
MIME-Version: 1.0
In-Reply-To: <1a966c5c-6779-a527-07d5-61a8a2b283b9@laas.fr>
Content-Language: fr
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Okay... my bad... I just found out why.

Just loosed 2 day, to notice that my /sizeof(MessageStructure) = 24... 
/thus it wasn't a error ID, but just the size of the message...

Erm... I propose just to forget this episode. ahah

Daniel

Le 03/03/2020 à 15:59, LOCHE Daniel a écrit :
> Hello,
>
> I am quite confused.
>
> I have several real-time tasks created from a fork + rt_task_shadow.
> My app uses a shared buffer where 1 to multiple processes can write 
> to, and a process with a task dedicated to read the buffer content.
>
> - I manage to create the buffer :
>
> struct MessageStructure { int ID; RTIME time; bool state; };
> rt_buffer_create(&_buff, "BUFFER_NAME", 20*sizeof(MessageStructure), 
> B_FIFO);
>
> (=> return value is 0.)
> - I also manage to bind to it from the other processes :
>
> rt_buffer_bind(&_buff, "BUFFER_NAME", 500*1000);
>
> (=> return value is 0 too.)
>
> - Issue is, even with only 2 processes (one Writer and the Reader), 
> when the first Read is executed, it returns me a Error #24.
>
> MessageStructure msg;
> rt_buffer_read(&_buff, &msg, sizeof(MessageStructure), TM_INFINITE);
>
> => return value is 24.
>
>
> From syserror(), I get that this is a "Too many open files" error, but 
> I don't understand why... Any clue ?
> Do other Alchemy objects enter into account for the "file count" that 
> I should mention..?
>
> Daniel
>
> PS : I managed to solve my last issue with rt_task_bind and shared 
> objects. I'l make a summary about it when time permits me. :)
>
