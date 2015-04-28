Date: Tue, 28 Apr 2015 10:24:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150428082434.GA1993@hermes.click-hack.org>
References: <CAKC9m6eKP5fvSx7ximsehOYKxZhm15EFaWeRhqUcUozWM-pjLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKC9m6eKP5fvSx7ximsehOYKxZhm15EFaWeRhqUcUozWM-pjLw@mail.gmail.com>
Subject: Re: [Xenomai] Porting the I-pipe core to ARM big.LITTLE architecture
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongfei Cheng <hongfei@mperpetuo.com>
Cc: xenomai@xenomai.org

On Tue, Apr 28, 2015 at 01:08:12AM -0700, Hongfei Cheng wrote:
> Searching the mailing list archives, I don't see mentioning of ARM's
> big.LITTLE architecture. The list of the supported SoCs doesn't appear
> to include any SoC based on ARM's big.LITTLE architecture.
> 
> Are there any special considerations for porting the I-pipe core to
> such big.LITTLE architecture?

I would say this sounds like cpufreq:
- migrating a task from an A15 to an A7 will have a huge impact on
latencies
- the speed difference will have a huge impact on the timings of the
running tasks.

So, if I were to port the I-pipe core to a big/little processor, I
would simply get the system to run on the A15, always, or maybe
allow the system to only run on the A7, if the user knows that his
tasks will be schedulable with the reduced power. Until someone
comes up with the will to implement something else (for something
like 10 years now, it did not happen for cpufreq, so I doubt it will
happen for big/little either).

-- 
					    Gilles.

