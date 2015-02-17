MIME-Version: 1.0
In-Reply-To: <CF69ABB4-0370-4AB8-9B04-D3D699B871B8@gatech.edu>
References: <CF69ABB4-0370-4AB8-9B04-D3D699B871B8@gatech.edu>
Date: Tue, 17 Feb 2015 07:32:01 -0800
Message-ID: <CAEMXjGw87iiba4NLNOM7xRS5L=r_+UabL8-oMiz-h2u=dvSpFw@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Definition of latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: xenomai <xenomai@xenomai.org>

Hello Yogi,
Looks to me like the test task is set up as periodic, and after doing a
little bit of number processing each time around, it yields the CPU for
other things to execute (i.e. other Xenomai tasks or the OS), and expects
to wake up again at the next delta T. The latency is then how much time
passed between the mark where the thread was targeted to start up again and
when it actually did start again.
The source is in src/testsuite/latency in the xenomai-2.6.3 tree, so you
can open that up and see for yourself as well! It looks fairly simple so I
think you can verify.

Steve

On Tue, Feb 17, 2015 at 6:58 AM, Yogi A. Patel <yapatel@gatech.edu> wrote:

> Hi -
>
> I am using the latency test provided with xenon on 2.6.3 and am curious
> what exactly the definition of =E2=80=9Clatency=E2=80=9D is.
>
> Are the min, avg, and max values presented the time it took the thread to
> wake up, execute and go back to sleep or something else?
>
> Thanks!
>
> Yogi A. Patel
> @yapatel525 <https://twitter.com/yapatel525>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>
