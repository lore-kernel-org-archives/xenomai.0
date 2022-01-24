Message-ID: <3ff02ee4-2eef-384a-6fdb-6ff9c80187a8@siemens.com>
Date: Mon, 24 Jan 2022 18:25:20 +0100
MIME-Version: 1.0
Subject: Re: Logging for real-time tasks.
Content-Language: en-US
References: <CAAvDm6Y1DaeR==TZo-3pkWiQNKobro3JkYPsRdyHqxS3Tm7QBQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAAvDm6Y1DaeR==TZo-3pkWiQNKobro3JkYPsRdyHqxS3Tm7QBQ@mail.gmail.com>
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
To: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 18.01.22 07:35, 孙世龙 sunshilong via Xenomai wrote:
> Hi, lists
> 
> And I clearly know that writing to file could not be guaranteed
> to be completed in a limited duration(i.e. before a specific
> deadline).
> 
> Since logging information during the execution of real-time
> tasks can help me understand what lead to a bug or crash,
> so my question is how can I  write neccerary logs for
> real-time tasks?
> 
> As far as I know, I can achieve this goal by
> 
> 1. write the log in real-time thread by XDDP
>     or
>     write the log to a block of already allocated memory
> 2. read out the said log in non-real-time thread and write them to a file
> 
> Is there any better method?
> Thank you for your attention to this matter.

You could also use fprintf() or syslog() as provided by libcobalt. That 
will provide the required decoupling from the RT thread providing the 
message and a non-RT writer thread dumping it to a non-RT output 
channel. One difference to the XDDP-based approach is that it is 
event-driven while printf & Co. uses a polling non-RT thread to empty 
the queue. Both approaches have pros and cons, depending on your workload.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

