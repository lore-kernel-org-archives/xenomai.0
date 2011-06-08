Message-ID: <4DEF2D3D.9090409@domain.hid>
Date: Wed, 08 Jun 2011 10:05:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <737283.11182.qm@domain.hid>
In-Reply-To: <737283.11182.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai-Driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: sanjay anvekar <sanjayanvekar@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/08/2011 04:22 AM, sanjay anvekar wrote:
>      rt_task_yield() - To allow execution of other tasks.

It is a bit hard to answer without seeing any code, but there is a
simple remark we can make: rt_task_yield does not "allow execution of
other tasks", rt_task_yield only allows execution of tasks with same
priority as the current task. Your real-time tasks have to let Linux run
from time to time if you want the serial port and graphic display to run
correctly, and in order to do this they have to get suspended,
rt_task_yield will definitely not do that.

-- 
                                                                Gilles.

