References: <884477039.8840647.1480697545181.ref@mail.yahoo.com>
 <884477039.8840647.1480697545181@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <daba9179-e8ae-9eea-325f-fc7735aee1ea@xenomai.org>
Date: Sat, 3 Dec 2016 18:08:12 +0100
MIME-Version: 1.0
In-Reply-To: <884477039.8840647.1480697545181@mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FAILURE rt_thread_body:116: no
 SIGDEBUG_MIGRATE_PRIOINV received on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <giuliomoro@yahoo.it>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12/02/2016 05:52 PM, Giulio Moro wrote:
> Hello,
> freshly installed Cobalt 3.0.3 on a BeagleBone Black (ARM Cortex-A8) with kernel 4.4.35 (rcn: 
> https://github.com/RobertCNelson/ti-linux-kernel-dev/tree/ti-linux-xenomai-4.4.y ).
> 
> When runnig xeno-test I get the below error.
> Note that latency test works ok (though the values are a bit higher than expected).

Then maybe it does not work as expected. Could you elaborate on:

- the figures reported by latency
- whether you enabled debug (--enable-debug) when building the user libs
and programs?
- did you run the autotuner to calibrate the core clock?

You may also want to make sure that debug options like
XENO_OPT_DEBUG_LOCKING are disabled, vanilla kernel debug options
likewise (DEBUG_LIST, IPIPE_TRACE and so on).

> Any suggestions?
> 
> FAILURE rt_thread_body:116: no SIGDEBUG_MIGRATE_PRIOINV received
> 

That one is a known pending issues with the smoke tests exercising the
some Xenomai debug features, but won't affect the measurement performed
by the "latency" program.

-- 
Philippe.

