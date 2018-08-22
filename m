MIME-Version: 1.0
References: <CAOuPNLgkFZ7wwBM2N3HXYSh0fkGce8GytJdKHnbsmBN4zfwcFg@mail.gmail.com>
 <CAOuPNLiXWVRRpn_39VfakbSHZH4K8Vc9wM8aRrgpwhAqtYZFoQ@mail.gmail.com>
 <CALLqZ8QVh2dtRe13PudQ2n1bGm2ZheO9d4Hp4TWVNrcXYrNyow@mail.gmail.com>
 <CAOuPNLipXN+iji4m91kkpegBYy_2q8BXyp2LRtLfXdA2j9No1Q@mail.gmail.com>
 <CALLqZ8QpWDnvGkKUGV7BYCXRw_ebxTq7+y7zGC973NqqFaYekA@mail.gmail.com>
 <CAOuPNLjHXLi6OsS9eqvqD-Fc7t7aHbA4kz31zoyrbF5KLVqxEQ@mail.gmail.com>
 <CAOuPNLiL=U1jzEm5a4Ymcgog=K9g=fXQDeW3VKU_8Wna2DCZ7A@mail.gmail.com>
 <CALLqZ8T-C_v=A+95pFZ4_EE0OggXmbGTPD9sK=M9ShfNhsThbQ@mail.gmail.com>
 <CAOuPNLg-L9U1AwuO_wKNsOWvvFMx93-knLQwz3NQ7Gb5h7UAyA@mail.gmail.com>
 <CALLqZ8QmNg6R1ExH=KmDqwjwPyOpknb3s-QYSXVmAtqCJpAnEA@mail.gmail.com>
In-Reply-To: <CALLqZ8QmNg6R1ExH=KmDqwjwPyOpknb3s-QYSXVmAtqCJpAnEA@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Wed, 22 Aug 2018 14:07:49 +0530
Message-ID: <CAOuPNLj3DbjBqFz8TFnOQ4GahhF6w7sZ02pfzxhjxSL-7Mcm_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] message pipe stream test application
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Aug 22, 2018 at 10:49 AM Greg Gallagher <greg@embeddedgreg.com> wrote:
>
>
> For your example, you are sending a message in rt_pipe_stream not a
> stream of bytes.  You'll need to change what you are sending in the
> rt_pipe_stream call.  I have a rough example working, I should have
> time to post it hopefully in the next few days.
>

Dear Greg, Thank you so much for the clue.
Yes, I could able to make it working, by changing the following:
ret = rt_pipe_stream(&mpipe, msg.value + i, 1);

Thus, each char is being streamed in the loop.
After both the loop terminates, I could read the whole stream messages
using single read command.

If you feel this could be one important demo. I can plan to contribute.
Similarly I developed 4 different patterns.

Thanks,
Pintu



> -Greg

