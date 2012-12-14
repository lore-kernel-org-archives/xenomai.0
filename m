Message-ID: <50CB364C.70706@wanadoo.fr>
Date: Fri, 14 Dec 2012 15:23:08 +0100
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Init issue with rtcan_flexcan
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Wolfgang Grandegger <wg@grandegger.com>

Hi,
some days ago I have posted a patch for the rtcan_flexcan to be
correctly probed on the iMX6q

It is functional, but I have not tested it enough, I am sorry about that.
It only works if the linux flexcan driver module has been used once before.

Else I have got IRQs but no packet go to the upper layer, I think it is
stuck in passive state, I am investigating on it.

Regards
Thierry

