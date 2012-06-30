Message-ID: <4FEF2EB1.3050600@logilin.fr>
Date: Sat, 30 Jun 2012 18:52:01 +0200
From: Christophe Blaess <mailist@logilin.fr>
MIME-Version: 1.0
References: <CAKKWdte1Yg5fEUN=jqVgyTkRTHwY62WrMdw99ZgqOZZdAnAm+w@mail.gmail.com>
	<4FEED882.9070307@xenomai.org>
In-Reply-To: <4FEED882.9070307@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] question: XENO_OPT_TIMING_SCHEDLAT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 30/06/2012 12:44, Gilles Chanteperdrix wrote:
>
>> /proc/xenomai/latency is an estimation of the minimum scheduling latency
>> on your system. In order to know what to put there you should do:
>>
>> echo 0 > /proc/xenomai/latency
>>
>> Run latency under load for several hour

Is it necessary to run the test under heavy load?
We're looking for the minimal latency, not the worst.

I thought that in this case a normal, even light load would be sufficient.

>>
>> echo minimum_latency > /proc/xenomai/latency
>>
>> The value put there is then subtracted to timers deadline, so that
>> timers wake up a little bit early to compensate for the time it takes to
>> return to user-space.
>>



