Message-ID: <45c36ddf13bd0bd3bdc199be436c8325.squirrel@www.xenomai.org>
In-Reply-To: <50918734.3090605@ruggedcom.com>
References: <50918734.3090605@ruggedcom.com>
Date: Wed, 31 Oct 2012 23:50:26 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Improper closure of rt pipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Makarand Pradhan <makarandpradhan@ruggedcom.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Makarand Pradhan wrote:
> Hi All,
>
> While working with rt pipes I noticed that:
>
>  > When a process that is writing to the real time pipe is killed, I am
> not able to write to the pipe again after restarting the process.
>  > When the pipe is closed properly with an fclose, then everything works.
>  > The only way to recover the rt pipe was to reboot the system.
>
> Would highly appreciate if you can comment on this behaviour.
> Is it the expected behaviour?
> Is there a way to recover the rt pipe without rebooting? Anything that
> can be done, on the other side of the pipe after detecting closure? I
> have tried deleting and recreating the pipe with no luck. I am running
> in user space so cannot flush the pipe.
>
> Am attaching code that can be used to reproduce this issue.
>
> I am running linux 3.0.0 on MPC8360.

Since it looks like a Xenomai bug, the really important information is the
version of Xenomai you are using. Anyway, this looks like a bug that was
reported a long time ago and fixed recently. Could you try the current HEAD
of the "master" branch in xenomai 2.6 git?

git://git.xenomai.org/xenomai-2.6.git

-- 
                    Gilles.


