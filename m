From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Tue, 11 Nov 2014 10:56:42 -0500
Message-ID: <20141111155642.GA24110@csclub.uwaterloo.ca>
References: <CAJt3u5nf_epaPjW=dAjqGMq85dgRYqwn-MKcRGFWby+MXtvong@mail.gmail.com>
 <20141111110937.GY17476@sisyphus.hd.free.fr>
 <20141111153745.GX24110@csclub.uwaterloo.ca>
 <20141111154611.GD17476@sisyphus.hd.free.fr>
 <20141111155212.GZ24110@csclub.uwaterloo.ca>
 <20141111155447.GE17476@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141111155447.GE17476@sisyphus.hd.free.fr>
Subject: Re: [Xenomai] USB3.0 drivers for xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Nov 11, 2014 at 04:54:47PM +0100, Gilles Chanteperdrix wrote:
> With periodic polling, you get bounded response time (and bounded
> IRQ load), so, this is, in fact, the best situation for real-time.

OK, I will agree to that.  So as long as you have no reason to want
faster than 1ms response time, it is better.

-- 
Len Sorensen

