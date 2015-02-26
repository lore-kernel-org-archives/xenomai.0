From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <44siduq7us.fsf@be-well.ilk.org> <54EE07A9.4040702@xenomai.org>
 <444mq9lo5c.fsf@be-well.ilk.org> <44vbipk8m9.fsf@be-well.ilk.org>
 <54EF014A.9000902@xenomai.org> <447fv4sk55.fsf@lowell-desk.lan>
 <54EF5E45.30907@xenomai.org> <44a900eaqu.fsf@lowell-desk.lan>
 <20150226201100.GB434@hermes.click-hack.org>
 <441tlce3o1.fsf@lowell-desk.lan>
 <20150226223750.GF434@hermes.click-hack.org>
Date: Thu, 26 Feb 2015 18:12:23 -0500
In-Reply-To: <20150226223750.GF434@hermes.click-hack.org> (Gilles
 Chanteperdrix's message of "Thu, 26 Feb 2015 23:37:50 +0100")
Message-ID: <44sidsclns.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] interrupt service
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

> On Thu, Feb 26, 2015 at 04:58:06PM -0500, Lowell Gilbert wrote:
>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:
>> > So, to be clear, does the ISR run on CPU0 and the thread doing the
>> > reads run on CPU1? If no, does it work if you do it that way? To
>> 
>> The other way around, but that's pretty much what I have set up. CPU0
>> handles work that doesn't need to be real-time, and CPU1 handles only
>> the real-time work.
>
> That is the part I do not understand. Since the read method is
> real-time as well as the ISR, you mean you run them on the same cpu?
> If yes, have you tried running them on different cpus ?

Sorry, my phrasing was quite misleading there. My network-reading task
is on CPU0 and the IRQ is on CPU1.

The network reading is a real-time task because it accesses the RTDM
device, but it doesn't have any latency requirements. I don't really
care whether it runs in primary mode, as long as it can manage better
than 2 megabytes per second of throughput. It has tens of megabytes of
buffering available to let it get ahead of the real-time work. Also, it
doesn't need to access the device very often. Instead of writing to the
device, it maps in a big chunk of kernel memory and writes to that.

Be well.

