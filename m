Message-ID: <4EA67872.30609@domain.hid>
Date: Tue, 25 Oct 2011 10:50:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1319494779.40265.YahooMailNeo@domain.hid>
In-Reply-To: <1319494779.40265.YahooMailNeo@domain.hid>
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

On 10/25/2011 12:19 AM, makarand pradhan wrote:
> (...) I'm
> assuming that the ROOT thread captures the %CPU spent in
> Linux/secnodary and each xenomai thread listed, captures the %CPU in
> primary domain. If a thread transitions to the secondary, then I'm
> assuming that the %util in secondary domain will get accounted
> against ROOT and the actual % usage in primary will get accounted
> against the thread.

You are assuming wrong, the CPU utilization measures the activity of the
linux kernel as a whole, including its idle task. So, the sum of all the
primary mode tasks and of the ROOT task is always 100%.

> Question:
> 
> If the linux process is sleeping, why do I see a CPU util against the
> process? Why is the CPU % util vary based on the activity I do in the
> primary domain?

rt_printf is a primary mode service which causes activity in secondary
mode: the actual printf is done by a plain linux task.


-- 
					    Gilles.

