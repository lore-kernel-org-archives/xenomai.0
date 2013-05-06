Message-ID: <51879972.30900@xenomai.org>
Date: Mon, 06 May 2013 13:52:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMDpcBF8cMMB1GWVRGys=43Rtx2kcckPd84YcY8AuRuOGSQHGQ@mail.gmail.com>
In-Reply-To: <CAMDpcBF8cMMB1GWVRGys=43Rtx2kcckPd84YcY8AuRuOGSQHGQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Patch for Cubieboard
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: kunming yang <yangkunming99@gmail.com>
Cc: xenomai@xenomai.org

On 05/06/2013 11:59 AM, kunming yang wrote:

> Hello,
> 
> Has anyone already worked on Cubieboard? I couldn't find any patch for it.


Hi,

what matters more for an I-pipe port is the SOC used rather than the
board. If I understand correctly, the SOC used by the Curbieboard is an
allwinner A10. So, what I can tell you is that Paul Crubillé published a
port to allwinner A13, I do not know how close the two processors are.

http://www.xenomai.org/pipermail/xenomai/2013-February/027801.html

Regards.

-- 
                                                                Gilles.

