From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <CAC66z970=X8fWVf1kCB=cuVnwaH5ryWEL3e8zLi=bx+2jVKb=w@mail.gmail.com>
Date: Tue, 08 Jul 2014 13:15:44 -0400
In-Reply-To: <CAC66z970=X8fWVf1kCB=cuVnwaH5ryWEL3e8zLi=bx+2jVKb=w@mail.gmail.com>
 (yogesh garg's message of "Mon, 7 Jul 2014 16:59:48 +0530")
Message-ID: <44oawzixfj.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] How to debug xenomai source
Reply-To: xenomai@xenomai.org
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: yogesh garg <yogesh.garg1983@gmail.com>
Cc: xenomai@xenomai.org

yogesh garg <yogesh.garg1983@gmail.com> writes:

> I am using Xenomai to create my kernel module. But I am getting some errors.
> To debug more on issues I want to print Xenomai debug messages("
> *trace_mark*").
> Please help me what I need to configure or enable to see *trace_mark *
> messages.

Is there a particular problem with using printk() like you would in any
normal kernel module? Most of the time, that's been enough for me to do
the sort of debugging you want.

