From: Steve Hartmann <shartmann@cnt.canon.com>
Date: Tue, 21 Oct 2014 20:29:26 +0000
Message-ID: <D06C2B92.195DA%shartmann@cnt.canon.com>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <DC2A603C74985147A815A24EB75A48D3@mex06.mlsrvr.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] /proc/xenomai/sched
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>



On 10/21/14 3:11 PM, "Steve Hartmann" <shartmann@cnt.canon.com> wrote:

>Can someone please point me in the direction of a writeup of how to
>interpret /proc/xenomai/sched?  I have searched around, but cannot find
>what I am looking for.  Specifically, I want to know what it means when I
>see a "D" in the "STAT" column, and what the number in the "TIMEOUT"
>column means.
>
>I did find one post that said the "D" means "Delayed (without any other
>wait condition).". Maybe I'm just dense, but I'm not positive on what
>that means.  I think it might mean that the task should be running, but
>it is delayed because it could not be scheduled because of some reason
>perhaps another higher priority task is bumping it?  Or am I way off base?
>
>Also, in xenomai 2.4.7, the TIMEOUT column is expressed in a number with
>no units; what is the unit?
>
>Thanks,
>
>Steven
>_______________________________________________
>Xenomai mailing list
>Xenomai@xenomai.org
>http://www.xenomai.org/mailman/listinfo/xenomai


So one other observation =8A the tasks which seem to very often show a "D"
status, are periodic tasks.  Perhaps this is just a state where it is
simply waiting on nothing other than time to pass before it gets scheduled
to run?

Thanks again,

Steven


