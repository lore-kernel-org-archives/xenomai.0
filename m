MIME-Version: 1.0
In-Reply-To: <CANWkrROgE=AVv_Qq9hkvS+kJ+Wx1zepOjJQ2gAX7qwNYJqhYBw@mail.gmail.com>
References: <CANWkrRN=ExZ4qgcXp8+d2NOzBHUvWb2u6Zu8twmr8Vo2VZnnqg@mail.gmail.com>
 <53EBC4D9.9040402@xenomai.org>
 <CANWkrROgE=AVv_Qq9hkvS+kJ+Wx1zepOjJQ2gAX7qwNYJqhYBw@mail.gmail.com>
Date: Thu, 14 Aug 2014 09:02:45 +0200
Message-ID: <CANWkrRPUP8MucXuHWzOEvwgoT2XwUn--6hf2FB+Zf+-jxxAW5g@mail.gmail.com>
From: Michael Smith <2michael.smith@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Fwd:  RTDM !xnpod_unblockable_p() question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

On Wed, Aug 13, 2014 at 10:04 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 08/13/2014 02:28 PM, Michael Smith wrote:
> > but there is just not enough information in the code
> > or documentation for me to solve it.
>
> Actually, the information can very well be found in the source code.
>
> #define xnpod_unblockable_p() \
>     (xnpod_asynch_p() || xnthread_test_state(xnpod_current_thread(),
> XNROOT))
>
> If you had digged a bit, you would have found that the failing test was
> !xnthread_test_state(xnpod_current_thread(), XNROOT)
>
> Which clearly means that you were calling rtdm_mutex_lock() from the
> context of the root thread and that the root thread is unblockable.
>
> Now, if you do not understand what the root thread is, or why it can
> not be suspended from Xenomai's scheduler point of view, clearly, there
> are a thing or two you have not taken the time to understand about
> Xenomai. So, please do not reverse the roles: you are the one who has
> not read enough documentation, please do not accuse us of not having
> written enough.
>
> --
>                                                                 Gilles.
>

Hi Gilles
You have misunderstood the meaning of my email.
It was in no way a stab at the documentation of Xenomai, or the work that
anybody has done.
I have gone down to that level of the code up the the XNROOT definition,
believe me I have spent hours
scouring the existing documentation as well as the code, as well as mailing
lists.
So I have not come into this with no understanding.
All I asked was for an explanation of a portion I did not understand.
And as Philipe explained "By "kernel based task", the doc always implicitly
means kernel-based
_Xenomai_ task" I did not know about that assumption, maybe it is something
that
is obvious if you have coded the Xenomai source code for years, for me it
was not.

Regards
Michael.
