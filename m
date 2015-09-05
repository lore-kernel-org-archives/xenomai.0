Date: Sat, 5 Sep 2015 14:42:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150905124226.GC10704@hermes.click-hack.org>
References: <CANWkrRNJ1576NNq7zqbn-VZTZKrRmiSTTZjyaBXw5R=gQDQckw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANWkrRNJ1576NNq7zqbn-VZTZKrRmiSTTZjyaBXw5R=gQDQckw@mail.gmail.com>
Subject: Re: [Xenomai] RTNet rtcfg - system hang
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Smith <2michael.smith@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Sep 04, 2015 at 11:44:52AM +0200, Michael Smith wrote:
> Hi all.
> I am trying to get RTNet to work, but the system keeps on crashing
> when rtcfg is called.
> I'm working on  Xenomai-3.0 rc5.
> 
> I have traced the crash to kernel/drivers/net/stack/rtcfg/rtcfg_event.c:151
> This is in function rtcfg_main_state_off() where the rtdm_task_init()
> is called. This thread creation call completely locks up the system.
> 
> Is there any fix for this yet? Or any advice on how to fix it myself?

I believe this is a known issue, we have a few pending ones with
rtnet. Search the archive to see if someone has investigated that (I
remember the original reporter simply avoided using rtcfg).

-- 
					    Gilles.
https://click-hack.org

