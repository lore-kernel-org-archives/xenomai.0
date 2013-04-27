Message-ID: <517B553B.6070404@xenomai.org>
Date: Sat, 27 Apr 2013 06:34:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFByoKwLThL56u+CNne+z2fro3DY+WvVevm9Yxk-WgMd9oW7nw@mail.gmail.com>
In-Reply-To: <CAFByoKwLThL56u+CNne+z2fro3DY+WvVevm9Yxk-WgMd9oW7nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] task wake up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: kidd <gong.kidd@gmail.com>
Cc: xenomai@xenomai.org

On 04/27/2013 03:39 AM, kidd wrote:

> Hi
> I have a problem when run test program "latecy". After the latency task is
> suspended with status XNDELAY, it would be never waked up.
> Can someone tell me the task waking up procedure of such condition ?


You keep looking in the wrong direction. You are porting the I-pipe
patch to a new board, do not you think that it is your port that has a
problem rather than the tools you use to test it?

The latency task is waiting for the timer to fire, and it does not. So,
there is something wrong with the way you handle the timer. Check
__ipipe_mach_set_dec
and
__ipipe_mach_acktimer

-- 
                                                                Gilles.

