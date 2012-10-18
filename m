Message-ID: <507F876F.7080406@xenomai.org>
Date: Thu, 18 Oct 2012 06:37:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <507E9424.8060800@siemens.com>
In-Reply-To: <507E9424.8060800@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] nucleus: Convert intrlock to a sleeping Linux
 lock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 10/17/2012 01:19 PM, Jan Kiszka wrote:

> All users of this lock are supposed to run over Linux context already.
> Moreover, latest I-pipe patches complain that ipipe_virtualize_irq is
> called with the Xenomai domain stalled. So convert this lock to a
> sleeping Linux variant to avoid that alarm.


Do we really really want such a change in the stable branch?

-- 
                                                                Gilles.

