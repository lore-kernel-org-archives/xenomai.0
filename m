From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [PATCH 0/2] Debian build
Date: Mon,  9 Sep 2019 17:28:40 +0200
Message-Id: <20190909152842.1326-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add missing dependencies for xeno-test and add missing
 bootstrap step to build a debian package.

Quirin Gylstorff (2):
  debian/control: Add dependencies for xenomai-testsuite
  debian/rules: Add missing bootstrap step

 debian/control | 2 +-
 debian/rules   | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.20.1


