Date: Thu, 29 Oct 2020 10:44:51 +0800
From: Fino Meng <fino.meng@linux.intel.com>
Subject: Re: Xenomai (master/next) unable to use orocos-corba
Message-ID: <20201029024451.GA29721@linux.intel.com>
References: <CAMjL99JLBO7m5Qr71QQm9eMWtLX3rm415UEcLWcB=CSdnz+ywA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMjL99JLBO7m5Qr71QQm9eMWtLX3rm415UEcLWcB=CSdnz+ywA@mail.gmail.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Ho <johnho26@gmail.com>
Cc: xenomai@xenomai.org

On Wed, Oct 28, 2020 at 09:41:28PM +0100, John Ho via Xenomai wrote:
> Hi all, I apologise for posting this again, but i was testing some stuff
> with xenomai and orocos, and i am not sure if i have encountered a wall
> with my progress. With special thanks to Gino, I was able to get the i219v
> drivers patched and rtnet running. As such I was able to get information
> from my Ethercat slaves on my university's robot.  I installed orocos 2.9
> with a custom branch of rtt from rtt-lwr. Although I was successful in
> compilation, and was able to use deployer-xenomai, I encountered an issue
> with deployer-corba / deployer-corba-xenomai. It only displays the memory
> available and nothing else.
> 
> After changing the branch of xenomai to stable-v 3.0.x or even v3.0.10, I
> was able to start deployer-corba-xenomai/ deployer-corba again. I am not
> sure if it is something to do with my kernel configuration that is causing
> this issue or something else.
> 
> I will greatly appreciate any help I can get with this regard.

Hi John,

I am not familiar with orocos, if it is in ROS releated stack, does it
already using Preempt-RT Linux kernel as realtime solution? 

BR fino

