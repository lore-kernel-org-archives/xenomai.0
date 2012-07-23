Message-ID: <500D3D2D.2010107@grandegger.com>
Date: Mon, 23 Jul 2012 14:01:49 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <CE2E43470FE5444A811B580382FE5EDF2113D8D95A@KEMPMAIL2.woodward.com>
	<5009A292.4060508@grandegger.com>
	<20120723084817.GA30335@localhost.localdomain>
In-Reply-To: <20120723084817.GA30335@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai installation on P1020RDB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Cochran <richardcochran@gmail.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 07/23/2012 10:48 AM, Richard Cochran wrote:
> On Fri, Jul 20, 2012 at 08:25:22PM +0200, Wolfgang Grandegger wrote:
>>
>> I tested Xenomai recently on a P2020 with mainline Linux 3.2.x with the
>> new iPipe-Patch and got very good latency results, especially with CPU
>> isolation: 65 us without and *8* us with CPU isolation. [I'm still puzzled
>> about the good results with CPU isolation. Maybe that's due to the new
>> iPipe-Patch. Need to re-test when time permits). I have listed the results
>> below.
> 
> Almost a year ago, around Linux 2.6.38 or so, I measured 13 us maximum
> latency on the P2020 RBD when using CPU isolation.

OK. Tests with FSL 2.6.35 on a P1025 showed latencies up to 40 us with
CPU isolation (an 65 us without). Similar results I measured with an ARM
i.MX6Q board.

Wolfgang.


