From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <44lhyrmuw9.fsf@be-well.ilk.org> <52CC62A0.3090108@xenomai.org>
 <44lhyqgkip.fsf@lowell-desk.lan> <52CDDCEC.6030205@xenomai.org>
Date: Mon, 13 Jan 2014 19:15:37 -0500
In-Reply-To: <52CDDCEC.6030205@xenomai.org> (Gilles Chanteperdrix's message of
 "Thu, 09 Jan 2014 00:19:08 +0100")
Message-ID: <44r48bpgeu.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] Altera Cyclone V
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:

> No, every ARM SOC has its own clocks implementation. This is currently 
> changing with the switch to device tree, but not all SOCs are 
> converted, at least not all of them were last time I checked. Anyway, 
> if your SOC uses device tree, adding a clock may simply be a matter of 
> adding it to the device tree.

It was already in the device tree. What I had missed was that the
frequency wasn't being set in the device tree, because there's a clock
manager block separate from the Cortex A9 block, so it wasn't inheriting
the master clock. I set it separately, but I'd prefer to tie it to the
clock manager numbers if I can figure out a way to do that.

I'm now puzzling through interrupt mapping. The BSP doesn't have a
handle_irq function, and I'm not sure whether I need to write one or
not.

Be well.

