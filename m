Date: Tue, 11 Oct 2005 07:26:06 -0700
Subject: Re: [Xenomai-core] rt_timer_ticks2ns
From: Steven Seeger <steve@domain.hid>
Message-ID: <BF71198E.17D1%steve@domain.hid>
In-Reply-To: <17227.51979.437655.440790@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Do you have to ask? :)

rt_timer_start(125000);


On 10/11/05 7:24 AM, "Gilles Chanteperdrix"
<gilles.chanteperdrix@xenomai.org> wrote:

> Steven Seeger wrote:
>> In periodic mode, rt_timer_ticks2ns should convert ticks to periodic
>> jiffies. However, it always seems to return 0.
> 
> Did you call rt_timer_start before rt_timer_tick2ns ?


