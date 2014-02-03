Message-ID: <52EF71E0.3080208@xenomai.org>
Date: Mon, 03 Feb 2014 11:39:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtc5QWhvcOwp2fjkUMHB1jTV9gV-hXf+3vzt0McLZ433fQ@mail.gmail.com>
In-Reply-To: <CAKKWdtc5QWhvcOwp2fjkUMHB1jTV9gV-hXf+3vzt0McLZ433fQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] installing a signal handler
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>, xenomai <xenomai@xenomai.org>

On 02/01/2014 01:36 PM, ali hagigat wrote:
> It seems that signal handler does not execute...
> -------------- next part --------------
>> cat /proc/xenomai/sched
> CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
>    0  0      idle    -1      -         master     R          ROOT/0
>    1  0      idle    -1      -         master     R          ROOT/1
>    2  0      idle    -1      -         master     R          ROOT/2
>    3  0      idle    -1      -         master     R          ROOT/3
>    0  0      rt      50      -         master     Df         KTask1
>    0  0      rt      50      -         master     Df         KTask2
>
>
>> dmesg
> notify is successful...
>

This deprecated feature does not wake up the receiving task.

-- 
Philippe.

