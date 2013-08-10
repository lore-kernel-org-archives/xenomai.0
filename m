Message-ID: <5206384B.2000806@xenomai.org>
Date: Sat, 10 Aug 2013 14:55:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52039EC3.4050908@gmail.com>
	<2A0F278E-ED28-46CC-8727-DC97BB89A6D6@mah.priv.at>
	<68671d77.6ce2003b.520526a4.3e2c@o2.pl>
	<52060B80.1080601@gmail.com>
	<ca8c552.13b41e8d.52063223.12f46@o2.pl>
	<5206353E.4070804@xenomai.org>
In-Reply-To: <5206353E.4070804@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Using hardware PWM generators with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Robert <robert-km@o2.pl>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/10/2013 02:42 PM, Gilles Chanteperdrix wrote:
> But it never will cause the thread to transition to secondary mode. Only
> system calls, called by user-space threads do that.

And some exceptional conditions like Linux signals and page faults.

-- 
                                                                Gilles.

