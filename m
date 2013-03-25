Message-ID: <514FFFCF.3010102@xenomai.org>
Date: Mon, 25 Mar 2013 08:42:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPRNvtSqfrtXW1L=W6_OTtenk+YyR_RWbPjrwRXYqEwN00P1rQ@mail.gmail.com>
	<514F79C2.6080807@xenomai.org>
	<CAPRNvtQBTNRLxsTmnkwo18+xd3KKi=Ja+YSjvCegO++LpqSoAg@mail.gmail.com>
In-Reply-To: <CAPRNvtQBTNRLxsTmnkwo18+xd3KKi=Ja+YSjvCegO++LpqSoAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] CAN bus on beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Davide Faconti <faconti@icarustechnology.com>
Cc: xenomai <xenomai@xenomai.org>

On 03/25/2013 12:25 AM, Davide Faconti wrote:

> Hi,


Hi,

> 
> I tried but the output isn't very different (I hope I did everything
> correctly...)
> 
> 
>> mode: start (0x1)
>> Can't get interface index for rtcan0, code = -19


The patch is supposed to fix the issue "Socket: protocol not supported"
you would get when trying to use linux socketcan interface with a
program compiled with xenomai posix skin flags. Which is why my answer
quoted this error message.

> 
> By the way, I also get this:
> 
>> [ 4477.943935] Xenomai: RTDM: closing file descriptor 0.


You get that because you exit from the program without closing the RTDM
file descriptor 0.

-- 
                                                                Gilles.

