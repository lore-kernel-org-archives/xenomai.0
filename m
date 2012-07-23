Date: Mon, 23 Jul 2012 10:48:17 +0200
From: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20120723084817.GA30335@localhost.localdomain>
References: <CE2E43470FE5444A811B580382FE5EDF2113D8D95A@KEMPMAIL2.woodward.com>
	<5009A292.4060508@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5009A292.4060508@grandegger.com>
Subject: Re: [Xenomai] Xenomai installation on P1020RDB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On Fri, Jul 20, 2012 at 08:25:22PM +0200, Wolfgang Grandegger wrote:
> 
> I tested Xenomai recently on a P2020 with mainline Linux 3.2.x with the
> new iPipe-Patch and got very good latency results, especially with CPU
> isolation: 65 us without and *8* us with CPU isolation. [I'm still puzzled
> about the good results with CPU isolation. Maybe that's due to the new
> iPipe-Patch. Need to re-test when time permits). I have listed the results
> below.

Almost a year ago, around Linux 2.6.38 or so, I measured 13 us maximum
latency on the P2020 RBD when using CPU isolation.

Thanks,
Richard

