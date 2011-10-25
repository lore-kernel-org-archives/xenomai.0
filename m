Message-ID: <4EA6D2E5.100@domain.hid>
Date: Tue, 25 Oct 2011 17:16:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1319494779.40265.YahooMailNeo@domain.hid>
	<4EA67872.30609@domain.hid>
	<1319552289.52870.YahooMailNeo@domain.hid>
In-Reply-To: <1319552289.52870.YahooMailNeo@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] CPU utilization question
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: makarand pradhan <makarand_u_pradhan@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/25/2011 04:18 PM, makarand pradhan wrote:
> [MP]: Yes. I've noticed that the sum of all tasks is always 100. My
> question was specifically about a xenomai task that transitions in
> secondary.
> 
> e.g. Assume a xenomai task that uses a total of 20% CPU. Of this
> assume that 10% is spent executing system calls in secondary domain
> and 10% is spent in the primary domain. I believe that from an
> accounting perspective, 10% would get accounted against ROOT and the
> xenomai task will show a CPU util of 10%. Is this accurate?

Yes.

-- 
					    Gilles.

