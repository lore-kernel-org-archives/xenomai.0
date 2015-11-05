Date: Thu, 5 Nov 2015 21:46:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151105204655.GA31487@hermes.click-hack.org>
References: <OF6134003B.3BB84DA5-ONC1257EF4.002BF1E4-C1257EF4.002EC9DB@zodiacaerospace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF6134003B.3BB84DA5-ONC1257EF4.002BF1E4-C1257EF4.002EC9DB@zodiacaerospace.com>
Subject: Re: [Xenomai] Xenomai on Linux 3.18 on Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe.Corbel@zodiacaerospace.com
Cc: xenomai@xenomai.org

On Thu, Nov 05, 2015 at 09:31:02AM +0100, Philippe.Corbel@zodiacaerospace.com wrote:
> Hi All!
> 
> I just subscribe to the mailing list to ask you for a few insight on my 
> potential problem.
> 
> I'm having the same behaviour that Andreas Galauner observed on his board 
> and since there have been no news since April, I'm restarting this 
> thread...

The mail you quote (unfortunately, not using the "reply" function of
your mail, which would have made finding back the original thread
easy), talks about a percpu issue that is fixed in recent I-pipe
patches. I suspect, however, that the percpu issue has nothing to do
with the stall issue you observe.

> 
> I'm currently developping for a custom designed board based on a Zynq 
> 7c020 and hoped to use Xenomai 3.0 on it.

Could you try the latest release, xenomai 3.0.1 ?

-- 
					    Gilles.
https://click-hack.org

