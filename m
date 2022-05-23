From: Gunter Grau <guntgrau@bbl.ma.philips.com>
Subject: Support nxp fec driver in 32Bit architectures 
Date: Mon, 23 May 2022 16:19:27 +0200
Message-Id: <20220523141929.2633409-1-guntgrau@bbl.ma.philips.com>
Reply-To: Gunter Grau <gunter.grau@philips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

we are using xenomai/ipipe on the imx6/7 platform. We were happy to see
progress on the fec driver support in Xenomai 3.2 and ported / tested it
on our hardware. Since it worked very well here is the patchset to
activate it for 32 Bit platforms and to fix out of tree builds for this
module.
Would be nice if it could also make it to the stable xenomai 3.2 branch.

Thanks in advance,
Gunter



