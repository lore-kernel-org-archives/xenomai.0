MIME-Version: 1.0
Sender: had2006@gmail.com
Date: Fri, 10 Apr 2015 09:36:08 +0100
Message-ID: <CAKk99t1XUV4-0YUcQFZbJudxfPgM1qB26gTA8KemjqVGoqmGQA@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] It is possible to control Interrupt propagation on ipipe
	with xenoami 3.x?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Since the RT_INTR API is no longer implemented It is possible to control
Interrupt propagation down the ipipe with xenoami 3.x. In kernel or user
space?

I took a look at Cobalt functions but I didn't find some similar to the
RT_INTR API (maybe I miseds something)

My goal is to show how to implement a shield between the RT and Linux
domains, as described in Xenomai white papers.

thanks,

Helder
