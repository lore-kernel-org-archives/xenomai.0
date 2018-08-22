MIME-Version: 1.0
In-Reply-To: <CAOuPNLg-L9U1AwuO_wKNsOWvvFMx93-knLQwz3NQ7Gb5h7UAyA@mail.gmail.com>
References: <CAOuPNLgkFZ7wwBM2N3HXYSh0fkGce8GytJdKHnbsmBN4zfwcFg@mail.gmail.com>
 <CAOuPNLiXWVRRpn_39VfakbSHZH4K8Vc9wM8aRrgpwhAqtYZFoQ@mail.gmail.com>
 <CALLqZ8QVh2dtRe13PudQ2n1bGm2ZheO9d4Hp4TWVNrcXYrNyow@mail.gmail.com>
 <CAOuPNLipXN+iji4m91kkpegBYy_2q8BXyp2LRtLfXdA2j9No1Q@mail.gmail.com>
 <CALLqZ8QpWDnvGkKUGV7BYCXRw_ebxTq7+y7zGC973NqqFaYekA@mail.gmail.com>
 <CAOuPNLjHXLi6OsS9eqvqD-Fc7t7aHbA4kz31zoyrbF5KLVqxEQ@mail.gmail.com>
 <CAOuPNLiL=U1jzEm5a4Ymcgog=K9g=fXQDeW3VKU_8Wna2DCZ7A@mail.gmail.com>
 <CALLqZ8T-C_v=A+95pFZ4_EE0OggXmbGTPD9sK=M9ShfNhsThbQ@mail.gmail.com>
 <CAOuPNLg-L9U1AwuO_wKNsOWvvFMx93-knLQwz3NQ7Gb5h7UAyA@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 22 Aug 2018 01:19:51 -0400
Message-ID: <CALLqZ8QmNg6R1ExH=KmDqwjwPyOpknb3s-QYSXVmAtqCJpAnEA@mail.gmail.com>
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
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Aug 21, 2018 at 1:47 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
> On Tue, Aug 21, 2018 at 9:32 PM Greg Gallagher <greg@embeddedgreg.com> wrote:
>>
>> HI,
>>   I"m not sure if I understand how you are using stream.   Stream
>> stores data in an internal buffer until the reciever wakes up and
>> reads the data.
>
> Yes I read this in the API description.
> But how this is different from normal write.
> I found the same behavior.
>
>> Your telling read just to read one message, usually I
>> loop through the messages until read blocks again.
> Yes this way it works, but then what is the difference here with
> normal read, if we keep reading the message at the same time.
>
>> Are you trying to
>> read all the messages you sent to the pipe using stream in a single
>> read?
> Yes, exactly.
> I though that is the purpose of streaming a messages.
>
> I just want to create a scenario in which rt_pipe_stream works but
> rt_pipe_write cannot.
> Hope to demonstrate this?
>
>> -Greg
>>
>> On Tue, Aug 21, 2018 at 11:06 AM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>> > Hi,
>> >
>> > This is the technique I am using:
>> >
>> > struct pipe_message {
>> >         char value[32];
>> > };
>> >
>> > volatile int terminate = 0;
>> >
>> > realtime_task()
>> > {
>> >      ret = rt_pipe_bind(&mpipe, "pipe", TM_INFINITE);
>> >      while (!terminate) {
>> >           ret = rt_pipe_read(&mpipe, &msg, sizeof(msg), TM_INFINITE);
>> >           printf("%s: rt_pipe_read: value: %c\n", __func__, msg.value[i]);
>> >           ret = rt_pipe_stream(&mpipe, &msg, sizeof(msg));
>> >           i++;
>> >      }
>> >      rt_pipe_unbind(&mpipe);
>> >      pthread_cancel(t_reg);
>> > }
>> >
>> > regular_thread(void *arg)
>> > {
>> >      char string[] = "realtime";
>> >      sprintf(device, "/dev/rtp%d", minor);
>> >      fd = open(device, O_RDWR);
>> >      for (read char by char from a string) {
>> >             msg.value[i] = ch;
>> >             ret = write(fd, &msg, sizeof(msg));
>> >             usleep(SLEEP_INTERVAL * MILLI_SECOND);
>> >             i++;
>> >      }
>> >      terminate = 1;
>> >      ret = read(fd, &msg, sizeof(msg));
>> >      printf("%s: read: value: %s\n", __func__, msg.value);
>> > }
>> >
>> > With this I want to read all the rt_pipe_stream message at once in regular
>> > thread.
>> > Is this the correct way to implement stream ?
>> > Or, please suggest how to modify this code to make stream work, which
>> > behavior should be different from normal rt_pipe_write.
>> >
>> > Currently, with this implement, only the first byte is getting printed after
>> > the read, in regular thread.
>> > I want the the whole stream of characters should be printed at once.
>> >
>> >
>> > Thanks,
>> > Pintu
>> >
>> > On Tue, Aug 21, 2018 at 1:39 PM Pintu Kumar <pintu.ping@gmail.com> wrote:
>> >>
>> >> Dear Greg,
>> >>
>> >> For your information, I already implemented sample application using
>> >> message pipe read/write API over RTIPC.
>> >> For the reference I saw lib/alchemy/testsuite/pipe-1.c
>> >>
>> >> But now I wanted to use rt_pipe_stream and understand how it work.
>> >> Mainly what is the real difference between rt_pipe_write and
>> >> rt_pipe_stream, and how to implement such difference.
>> >> According to my experiment, both behaves almost the same for me.
>> >>
>> >> I have read the description about rt_pipe_stream in the documentation.
>> >> I tried to implement the similar logic, but behavior is not same for me.
>> >>
>> >> My understanding is that:
>> >> Regular thread keeps writing one by one char to rtipc, and the real-time
>> >> task reads one char at a time. Then real-time task call rt_pipe_stream
>> >> which keeps storing all the characters until read is called.
>> >>
>> >> Finally, when regular thread calls "read" then all the data from
>> >> stream will be read by the regular thread at once.
>> >>
>> >> I implemented it in similar way, but in the end regular thread could
>> >> read only one char (first char) in the end.
>> >>
>> >>
>> >> Thanks,
>> >> Pintu
>> >> On Tue, Aug 21, 2018 at 12:12 AM Greg Gallagher <greg@embeddedgreg.com>
>> >> wrote:
>> >> >
>> >> > On Mon, Aug 20, 2018 at 2:02 PM, Pintu Kumar <pintu.ping@gmail.com>
>> >> > wrote:
>> >> > > May be both.
>> >> > > Specially I want to know how to use may use of rt_pipe_steam with a
>> >> > > use case
>> >> > > example.
>> >> > >
>> >> > >
>> >> > > On Mon, 20 Aug 2018, 10:10 pm Greg Gallagher, <greg@embeddedgreg.com>
>> >> > > wrote:
>> >> > >>
>> >> > >> On Mon, Aug 20, 2018 at 9:48 AM, Pintu Kumar <pintu.ping@gmail.com>
>> >> > >> wrote:
>> >> > >> > Dear Greg,
>> >> > >> >
>> >> > >> > If you have any idea can you please explain how rt_pipe_stream
>> >> > >> > works
>> >> > >> > with an example.
>> >> > >> > I need to prepare a demo, to demonstrate the usefulness of
>> >> > >> > rt_pipe_stream API.
>> >> > >> >
>> >> > >> >
>> >> > >> > Thanks,
>> >> > >> > Pintu
>> >> > >> > On Fri, Aug 17, 2018 at 6:56 PM Pintu Kumar <pintu.ping@gmail.com>
>> >> > >> > wrote:
>> >> > >> >>
>> >> > >> >> Hi,
>> >> > >> >>
>> >> > >> >> I wanted to understand how rt_pipe_stream works and how it can be
>> >> > >> >> useful.
>> >> > >> >> I wanted to create a demo application using it.
>> >> > >> >> But currently I could not figure out how to make use of it.
>> >> > >> >>
>> >> > >> >> I saw a sample pipe application under:
>> >> > >> >> lib/alchemy/testsuite/pipe-1.c.
>> >> > >> >> Based on this I am trying to create a new application that uses
>> >> > >> >> rt_pipe_stream.
>> >> > >> >> The rt_pipe_stream is working fine, but I wanted to test the
>> >> > >> >> scenario
>> >> > >> >> based on its description.
>> >> > >> >>
>> >> > >> >> My understanding is that:
>> >> > >> >> Regular thread keeps write one by one char to rtipc, and the
>> >> > >> >> real-time
>> >> > >> >> task reads one char at a time. Then real-time task call
>> >> > >> >> rt_pipe_stream
>> >> > >> >> which keeps storing the char.
>> >> > >> >> Finally, when regular thread calls "read" then all the data from
>> >> > >> >> stream will be read by the regular thread at once.
>> >> > >> >>
>> >> > >> >> Hope my understanding is correct.
>> >> > >> >> I want to prepare a sample application for the same.
>> >> > >> >>
>> >> > >> >> If any reference for rt_pipe_stream is available please let me
>> >> > >> >> know.
>> >> > >> >>
>> >> > >> >>
>> >> > >> >> Thanks,
>> >> > >> >> Pintu
>> >> > >> >
>> >> > >> > _______________________________________________
>> >> > >> > Xenomai mailing list
>> >> > >> > Xenomai@xenomai.org
>> >> > >> > https://xenomai.org/mailman/listinfo/xenomai
>> >> > >>
>> >> > >> HI,
>> >> > >>   Do you want an explaination how they worked in cobalt or an
>> >> > >> exaplaination of how to use them?
>> >> > >>
>> >> > >> Thanks
>> >> > >>
>> >> > >> Greg
>> >> >
>> >> > Start here:
>> >> >
>> >> >
>> >> > https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__pipe.html#ga29521cc898afa0069963964955167aa5
>> >> >
>> >> > I'll see what I can for an example.
>> >> >
>> >> > -Greg

For your example, you are sending a message in rt_pipe_stream not a
stream of bytes.  You'll need to change what you are sending in the
rt_pipe_stream call.  I have a rough example working, I should have
time to post it hopefully in the next few days.

-Greg

