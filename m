Message-ID: <530C9D87.60805@xenomai.org>
Date: Tue, 25 Feb 2014 14:41:27 +0100
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
In-Reply-To: <1393335358.33826.YahooMailNeo@web140603.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 02/25/2014 02:35 PM, Bruno Tunes de Mello wrote:
> Hi Gilles,
>
> I applied this new patch and I got the results below.
>
> This is the complete boot log: http://pastebin.com/YY5pFyaN

Ok, bit 23 seems enabled in the L2 cache auxiliary register, which is 
what I wanted to see.

>
> I executed latency and xeno-test some times and the results:

This looks much better, you should let the test run longer, and if 
possible using dohell with LTP to generate load during that time.

-- 
					    Gilles.

