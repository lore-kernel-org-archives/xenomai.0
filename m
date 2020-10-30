MIME-Version: 1.0
References: <CAMjL99JLBO7m5Qr71QQm9eMWtLX3rm415UEcLWcB=CSdnz+ywA@mail.gmail.com>
 <1589007407.7310720.1603993217961.JavaMail.zimbra@telenet.be>
In-Reply-To: <1589007407.7310720.1603993217961.JavaMail.zimbra@telenet.be>
From: John Ho <johnho26@gmail.com>
Date: Fri, 30 Oct 2020 09:41:08 +0100
Message-ID: <CAMjL99LBPNaNoqVYJ53WgK6rCR6Jqy74PfFfbDEDDr9zz1i_LQ@mail.gmail.com>
Subject: Re: Xenomai (master/next) unable to use orocos-corba
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: g.strobbe@telenet.be, xenomai@xenomai.org

Hi Gino,

I understand, but thank you so much for the help thus far! I guess I have
to see if there is any other ways to communicate with my other pc! But
still being able to communicate with the EtherCAT slaves over RTNET was a
major turning point for my project!
I will try to ask the other website to see if they know anyway to resolve
this issue!

yours sincerely,
John


On Thu, Oct 29, 2020 at 6:40 PM <g.strobbe@telenet.be> wrote:

> Hi John,
>
> I'm really happy to hear that you are now able to communicate with your
> EtherCAT slaves over RTNET.
>
> I never played with corba so I can't help you there.
>
> I also think you are on the wrong mailing list for Orocos deployer related
> questions.
> The proper mailing list used to be "Orocos Users" <
> OROCOSUSERS@LS.KULEUVEN.BE> but it is already years really low traffic.
> They are however in the middle of a reviving attempt as you can read here:
>
> https://discourse.ros.org/t/updates-on-orocos-ros-1-and-2-integration/15146/4
> All most up to date links are there as well.
>
> Best Regards,
>
> Gino
>
> ----- On Oct 28, 2020, at 9:41 PM, xenomai xenomai@xenomai.org wrote:
>
> > Hi all, I apologise for posting this again, but i was testing some stuff
> > with xenomai and orocos, and i am not sure if i have encountered a wall
> > with my progress. With special thanks to Gino, I was able to get the
> i219v
> > drivers patched and rtnet running. As such I was able to get information
> > from my Ethercat slaves on my university's robot.  I installed orocos 2.9
> > with a custom branch of rtt from rtt-lwr. Although I was successful in
> > compilation, and was able to use deployer-xenomai, I encountered an issue
> > with deployer-corba / deployer-corba-xenomai. It only displays the memory
> > available and nothing else.
> >
> > After changing the branch of xenomai to stable-v 3.0.x or even v3.0.10, I
> > was able to start deployer-corba-xenomai/ deployer-corba again. I am not
> > sure if it is something to do with my kernel configuration that is
> causing
> > this issue or something else.
> >
> > I will greatly appreciate any help I can get with this regard.
>
