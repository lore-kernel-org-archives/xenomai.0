MIME-Version: 1.0
Date: Fri, 28 Mar 2014 16:41:40 -0700
Message-ID: <CADoY7i8=SSBVO6R7eiGtMLb9ZnAsXj+mC4L_pDRs3-zDBaP7aQ@mail.gmail.com>
From: Newell Jensen <newell.jensen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] IRQ Handler latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I have successfully created an RTDM driver that uses the EPIT timer on the
i.mx6dl-sabresd board.  The reason I created this driver is I wanted to see
what the hard interrupt latency is using Xenomai.

AFAIK, I am using the RTDM skin in the proper way.  However, I wanted to
run my code by the experts (you guys), to see if there is any improvements
that I can make.

Here is a link to my code:  http://pastebin.com/TFWLq9mq

My questions are:

1. Is there anything that I am not doing in my code that I should be to
reduce interrupt latency?

2. Is there a way to set the priority for a kernel module like the one I
have?

3. Is there an easy way to see the priorities of all irqs both in Xenomai
and Linux?

Essentially we want to get a core as isolated as possible so that only our
one time critical interrupt handler is running on that at the highest
priority.

Thanks,

Newell
