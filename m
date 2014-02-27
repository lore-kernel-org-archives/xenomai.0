Message-ID: <530F45FC.3060902@mitrol.it>
Date: Thu, 27 Feb 2014 15:04:44 +0100
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rtdm_event_wait seldom return -EINTR
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: "Maurizio.Macchi" <maurizio.macchi@mitrol.it>

Hi to all.
I have an embedded system with arm.
- kernel 2.6.31.8
- xenomau 2.5.6
Unfotunately it is very difficult for me to try a more recent version 
because kernel is not vanilla.

I run a test on my system.
Sporadically, after some days (sometimes also 2 weeks) of work, a 
rtdv_event_wait in a rtdm driver return -EINTR.

I read a lot about this problem.
If I understand correctly in this case I have to return -EINTR.
If I return -EINTR the flow of code should returns to user-space, than 
re-enter in xenomai rtdm-driver.

================================================================================
static ssize_t rteth_recvmsg(struct rtdm_dev_context *context, 
rtdm_user_info_t *user_info, struct msghdr *msg, int flag{
         ...
         rv = rtdm_event_wait(&priv->rx_event);
         if (rv == -EINTR)
                 return -EINTR;
         ...
================================================================================

I'd like to know why rtdm_event_wait return -EINTR.
 From documentation seems that rt-task received a signal.
To be clear I'm not working with gdb (debugger). I think no one sent a 
signal to my rt-task.
Maybe a signal is sent by xenomai to switch to/from primary/secondary mode.

What is the fair way to overcome this problem ?

Thanks in advance,
Paolo Minazzi


