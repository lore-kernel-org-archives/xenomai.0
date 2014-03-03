Message-ID: <5314CDDA.4030308@xenomai.org>
Date: Mon, 03 Mar 2014 19:45:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1392993075.52404.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530766CD.3060707@xenomai.org>
 <1393198348.29895.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530A862C.1060805@xenomai.org>
 <1393204287.98060.YahooMailNeo@web140606.mail.bf1.yahoo.com>
 <530B374B.1080507@xenomai.org>
 <1393298793.43978.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530C6AC6.6030200@xenomai.org>
 <1393335358.33826.YahooMailNeo@web140603.mail.bf1.yahoo.com>
 <530C9D87.60805@xenomai.org>
 <1393871535.96739.YahooMailNeo@web140604.mail.bf1.yahoo.com>
In-Reply-To: <1393871535.96739.YahooMailNeo@web140604.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] User Space Problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bruno Tunes de Mello <bruno_v05_2005@yahoo.com.br>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/03/2014 07:32 PM, Bruno Tunes de Mello wrote:
> Hi Gilles,
> 
> I did the tests you said to verify the system's behavior with load .
> 
> I executed some tests using commands 'stress', cpuburn for Cortex A8 and dohell with LTP, for more than 20 minutes each one.
> I printed 3 results using some of these tools together: http://pastebin.com/VFavnaxW
> In each test it's indicated the commands used to generate load.
> 
> It's just to confirm if it's all right.

71us may be a bit high, but have you run xeno-test and latency at the 
same time? xeno-test runs latency, so, if you also run the latency test 
separately, one latency test will perturb the results of the other.

Also, something I noted on omap4, I have no explanation, but it seems 
latency is better on cpu 0, also, running dohell with all the options 
should provide a harder load.

I use:
xeno-test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp" -c 0 -p 100 -g histo

Where 192.168.0.5 has the "discard" service enabled in inetd.conf (the 
discard service is not enabled by default).

And an USB key is mounted on /mnt.

The generated "histo" files can be used with scripts/histo.gp to generate
histograms like:
http://sisyphus.hd.free.fr/~gilles/core-3.10-latencies/panda.png

Note that since the feedback from mx6 users about the L2 "write-allocate" 
bit, the panda board latency dropped down to about 25us.

-- 
                                                                Gilles.

