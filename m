Message-ID: <51695D5C.6020105@xenomai.org>
Date: Sat, 13 Apr 2013 15:27:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1358809464.75419.YahooMailNeo@web140601.mail.bf1.yahoo.com>
	<1358883137.7479.YahooMailNeo@web140606.mail.bf1.yahoo.com>
In-Reply-To: <1358883137.7479.YahooMailNeo@web140606.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] x86 Linux with xenomai and i915 graphics stall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: A User <t02446@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/22/2013 08:32 PM, A User wrote:

> When we run latency, we still get about 10 usec on a quiet system.
> When we run glxgears and make the window size  600x600 pixels, and we
> use the mouse to drag the glxgears window quickly around on the
> desktop, the max latency goes to about 250 usec (with gnome-3
> fallback and compiz).
> 
> So, it looks like we are ok for now with this configuration, unless
> that latency is unusual. glxgears in a window that is not being
> dragged has lower latency.


Hi,

I have been able to spend some time on this issue. It seems the time 
gets spent in the "__gen6_gt_force_wake_get" function.

I modified the function as such:

void __gen6_gt_force_wake_get(struct drm_i915_private *dev_priv)
{
	unsigned long flags;
	int count;
	count = 0;
	while (count++ < 50 && (I915_READ_NOTRACE(FORCEWAKE_ACK) & 1))
		udelay(10);

	ipipe_trace_special(50, native_apic_mem_read(APIC_TMCCT));
	I915_WRITE_NOTRACE(FORCEWAKE, 1);
	ipipe_trace_special(51, native_apic_mem_read(APIC_TMCCT));
	POSTING_READ(FORCEWAKE);
	ipipe_trace_special(52, native_apic_mem_read(APIC_TMCCT));

	count = 0;
	while (count++ < 50 && (I915_READ_NOTRACE(FORCEWAKE_ACK) & 1) == 0)
		udelay(10);
}

And I get the following trace:
(...)
:|  # event   tick@-56    -154	  0.036  xntimer_next_local_shot+0x9d (xntimer_tick_aperiodic+0x154)
(...)
:    #func                 -79	  0.103  __gen6_gt_force_wake_get+0x7 [i915] (i915_read32+0x5f [i915])
:    #(0x32)	0x00000093   -79	  0.738  __gen6_gt_force_wake_get+0x56 [i915] (i915_read32+0x5f [i915])
:    #(0x33)	0x0000008e   -78!  66.706  __gen6_gt_force_wake_get+0x79 [i915] (i915_read32+0x5f [i915])
:|   #begin   0x000000ef   -12	  0.257  apic_timer_interrupt+0x6a (__gen6_gt_force_wake_get+0x84 [i915])

The second hexadecimal value in the trace is the value of the APIC 
current counter register. The APIC timer runs on my machine at 6249609Hz.
This means that:
- before I915_WRITE_NOTRACE(FORCEWAKE, 1), there are
0x93 * 1000000 / 6249609 = 23us remaining before the timer tick.
- after I915_WRITE_NOTRACE(FORCEWAKE, 1), which lasted for 67us, there are
0x8e * 1000000 / 6249609 = 22us remaining before the timer tick.

The only explanation I see for this behaviour, is that the APIC timer clock 
stops during the write to the FORCEWAKE register.

I have tried the usual graphic driver workaround:
set "Option NoAccel" in /etc/X11/xorg.conf, it did not work.

However, installing the debian packet xserver-xorg-video-fbdev, and
replacing "Driver "intel"" with "Driver "fbdev"" does the trick for me.

Regards.

-- 
                                                                Gilles.

