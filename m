Message-ID: <4FE88BF9.10400@xenomai.org>
Date: Mon, 25 Jun 2012 18:04:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtfmd-EbtNro=nueK81gY6HUDJ-X1Qc54LTPXJ13HegQ1Q@mail.gmail.com>
In-Reply-To: <CAKKWdtfmd-EbtNro=nueK81gY6HUDJ-X1Qc54LTPXJ13HegQ1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] question: scheduling latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On 06/25/2012 11:17 AM, ali hagigat wrote:
> What is the meaning of the scheduling latency in Xenomai and Xenomai
> tests like the latency test by the latency utility?
> 
> Is it the time after finishing an interrupt and executing the first
> instruction of a real time task? Or it is the time that each real time
> task is executed below that?

Read the source, what the test does it obvious, it is the time from the
timer interrupt, to the time we return to the measurement thread.

-- 
					    Gilles.

