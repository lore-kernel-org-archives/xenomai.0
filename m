Date: Sat, 28 Nov 2015 07:33:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151128063341.GB10399@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] Xenomai build test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

the Xenomai build test script was updated for Xenomai 3.0:
- it is now run in a cron job every night;
- it runs "make distcheck" for every toolchain, both for cobalt and
mercury thus verifying that Xenomai user-space support builds
correctly for every architecture;
- it is run for both Xenomai 3.x stable-3.0.x and next branches;
- it generates somewhat nicer reports
(http://xenomai.org/build-test-next vs
http://xenomai.org/build-test)

The new reports URLs are:
http://xenomai.org/build-test-stable/ for the stable-3.0.x branch
http://xenomai.org/build-test-next/ for the next branch

Regards.

-- 
					    Gilles.
https://click-hack.org

