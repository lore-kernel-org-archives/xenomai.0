MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 19 Jul 2019 12:26:09 +0200
Message-ID: <CAFLxGvwmtY6MD1LLJ9PbjXOp9a_7nNnVRCOKRkJQ1VA-d_QM2Q@mail.gmail.com>
Subject: Asynchronous notify?
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi!

Is there a way in Xenomai 3 to have a signal alike notification?

The Xenomai 2 code base I work on needs a way to get exceptions such
as #DB and #BP
delivered to a RT_TASK in real time context.
For Xenomai 2 they implemented a subset of regular RT-signals which
work in real time context.
So the RT_TASK could register a signal handler for #DB on x86.

Before I start porting this feature to Xenomai 3 (I'll happily publish
these patches) I want
to sort out whether this can be achieved with stock features or
minimal adoptions.

-- 
Thanks,
//richard

