Date: Tue, 13 Jan 2015 21:39:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150113203958.GL21032@hermes.click-hack.org>
References: <CAPozGfnFbPgfhi-ennhT2Ba=HJqs25W3WWVewXjBVbo87D81iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPozGfnFbPgfhi-ennhT2Ba=HJqs25W3WWVewXjBVbo87D81iQ@mail.gmail.com>
Subject: Re: [Xenomai] Negative latencies
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Sini <jhnsini@gmail.com>
Cc: xenomai@xenomai.org

On Tue, Jan 13, 2015 at 06:01:54PM +0100, John Sini wrote:
> Hello,
> 
> 
> I was trying to boot linux with Xenomai on the Zedboard from Xilinx. When I
> run the latency test I get negative values. I tried to calibrate my system
> by running the following
> echo 1 > /proc/xenomai/latency
> 
> 
> But then when I run
> 
> cat latency - I get 0. I also get 0 if I put 2 or 3ns. If I put 4 i.e.
> 
> echo 4 > /proc/xenomai/latency and then do:
> 
> cat latency - I get 3.
> 
> Is there a possibility to calibrate my system to 1ns? Can the calibration
> be done without echo 1 > /proc/xenomai/latency somehow in latency.c. Before
> doing any calibration latency that I get is 9498.

See:
https://xenomai.org/pipermail/xenomai/2007-May/009063.html

-- 
					    Gilles.

