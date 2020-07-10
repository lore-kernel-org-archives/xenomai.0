From: Caffreyfans <Caffreyfans@163.com>
Subject: [BUG] copperlate/eventobj.c ->>> eventobj_inquire(), don't work
Message-ID: <e371ebd5-519a-cf6e-998e-b2591d4f1c48@163.com>
Date: Fri, 10 Jul 2020 14:04:25 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi sir,

     I'm trying to make another skin for xenomai.  When I do something 
about "event". I use `eventobj_inquire()` to get event flags. But no 
matter what value I post, I always get 0.

     I find that eventobj_inquire() is not working. I know 
`alchemy/event` also use `eventobj`. So I write a test code by using 
alchemy skin. I am curious whether it is my own problem or there is an 
error in xenomai.

Test code:

```

     struct RT_EVENT event;

     struct RT_EVENT_INFO info;

     ret = rt_event_create(&event, "EVENT", 0, EV_FIFO);

     rt_event_signal(&event, 0x2);

     rt_event_inquire(&event, &info);

     printf("info.value = %d\n", info.value);

     printf("info.name = %s\n", info.name);

     printf("info.nwaiters = %d\n", info.nwaiters);

```

Result:

```

     info.value = 0

     info.name = "EVENT"

     info.nwaiters = 0

```

Environment:

       xenomai-3.1、Linux-4.19.114、--core cobalt.





