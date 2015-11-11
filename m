Date: Wed, 11 Nov 2015 17:12:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151111161234.GA1820@hermes.click-hack.org>
References: <BLU437-SMTP3567D7D9516D88AF50AA67F0130@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLU437-SMTP3567D7D9516D88AF50AA67F0130@phx.gbl>
Subject: Re: [Xenomai] Latency test on RP2 vs Odroid-C1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Cc: xenomai@xenomai.org

On Wed, Nov 11, 2015 at 07:40:03AM -0800, Mathieu Rondonneau wrote:
> Hi,
> 
> I finally was able to run the latency test on RPI2.
> 
> the results are showing: lat best of 7.705 and worst 16.605
> with an average of 9.129

I do not know whether you ran the latency test under load, but that
is the only way to get meaningful results (i.e. approaching the
worst case latency). In order to run the latency test under load, we
use the xeno-test script, with the LTP testsuite.

-- 
					    Gilles.
https://click-hack.org

