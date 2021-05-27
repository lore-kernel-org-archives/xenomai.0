References: <BN9PR11MB522741D310EA498FDA56B742F2249@BN9PR11MB5227.namprd11.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Can we port latmon from zephyr to xenomai 3.2 for measuring
 gpio latency.
In-reply-to: <BN9PR11MB522741D310EA498FDA56B742F2249@BN9PR11MB5227.namprd11.prod.outlook.com>
Date: Thu, 27 May 2021 16:54:35 +0200
Message-ID: <87zgwgjkgk.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Hi Hongzhan,

Chen, Hongzhan <hongzhan.chen@intel.com> writes:

> Hi Philippe
>
> I have tried different ways and different X86 boards to co-work with FRDM K64F to get correct GPIO latency
> for latmus test but failed because of voltage mismatch( 1.8V <-> 3.3V) or bad signal  of gpio connection between X86 boards 
> and FRDM K64F triggering lots of invalid gpio interrupts after run.
>

Yeah, too bad the PI-X designers did not stick with the pretty common
3.3 voltage. Any ARM-based PI can give us 3.3V on the GPIO pins
AFAICS. But I guess this might not be on the table, right?

> Can we port latmon from zephyr to xenomai so that we can set up latmus and latmon on same type of board
> which both run xenomai to measure gpio latency to avoid voltage mismatch or bad signal caused by platform 
> difference?  It would also provide more options for user to setup latmon to measure gpio latency.  How do you think?
>

Benchmarking Xenomai with Xenomai might raise some validity concerns in
theory, hence the reason for going for a distinct and fairly basic
Zephyr-based solution for monitoring latency.

Practically speaking, this could be done and should work for sure. In
this case, I would have the basic measurement code running in a RTDM
driver (e.g. extending the latmus driver?) so that no extra cost is
involved due to memory contexts switches, pushing the data to userland,
which would in turn collect it and deal with the TCP stream.

-- 
Philippe.

