Message-ID: <500D298C.6080601@xenomai.org>
Date: Mon, 23 Jul 2012 12:38:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6B3AC2788014DD49B43AF9611365BBAA21B0B94DE9@mary.at.omicron.at>
	<5009902B.7070705@xenomai.org>
	<6B3AC2788014DD49B43AF9611365BBAA21B0B954F3@mary.at.omicron.at>
In-Reply-To: <6B3AC2788014DD49B43AF9611365BBAA21B0B954F3@mary.at.omicron.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai 2.6.1 on ixp4xx hangs on boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Lausch <michael.lausch@omicron.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/23/2012 12:28 PM, Michael Lausch wrote:

> Hi,
> Yep this fixes the boot error.


Good news. 

We have a pending issue on ixp4xx however: ixp4xx is the only arm SOC 
port not  using the "kuser" tsc emulation. It still works with xenomai 
2.6, but xenomai 3.x requires the arm SOC ports to use the kuser tsc.

I had done the necessary modifications at some point in the past:
http://git.denx.de/ipipe.git/?p=ipipe.git;a=commit;h=cbd591ed5797f105ff45e04cca3bc939388624ea

But it did not work, so we decided to revert it. Now, it would be nice 
if you could try it again and see if it still does not work.


-- 
                                                                Gilles.

