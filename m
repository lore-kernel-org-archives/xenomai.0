Message-ID: <434E1CCB.4010809@domain.hid>
Date: Thu, 13 Oct 2005 10:37:31 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <1CFEB358338412458B21FAA0D78FE86D02CABCA8@domain.hid>	<434CFDFF.2090201@domain.hid>
	<434D06C9.3030802@domain.hid> <434D0D2D.4010606@domain.hid>
	<434D2006.1060908@domain.hid>
In-Reply-To: <434D2006.1060908@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: 2.4 vs 2.6 in embedded space
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 10/12/2005 04:39 PM Philippe Gerum wrote:
> Wolfgang Grandegger wrote:
>> We have linux-2.4.14-rc3 running on all AMCC eval boards (see
>> http://www.denx.de). But the kernel supported by RTAI/Fusion,
>> linuxppc-2.6.10rc3, does not boot on Ebony. The main problem is the
>> missing support for U-Boot but there might be others. And it's simply
>> not worth the effort to port it, I think.
> 
> Open question: to your opinion, is 2.6 on low-end embedded hw doomed "by design" 
> and why, or do you think that part of the reluctance to move to 2.6 is mostly 
> explained because 2.4 is just fine and up to the task, IOW it's kind of a "don't 
> fix if it ain't broken" perception?

As Wolfgang (Denk) already pointed out, 2.6 is less attractive on low
end systems, because it's bigger, slower, ... This is also true for
Xenomai (RTAI/fusion). It's difficult to beat the latency value of the
old RTAI/RTHAL under 2.4. You need more CPU power and resources, that's
how thing are going. Nevertheless, compared to the realtime preemption
patch, Xenomai is _lightweight_ :-).

Furthermore I think, that part of the reluctance is also due to
"development in progress" including features like the realtime
preemption patch, especially on embedded PowerPC systems. People are
waiting that things get available and stable.

Wolfgang.


