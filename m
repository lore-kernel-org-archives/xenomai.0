MIME-Version: 1.0
Date: Thu, 17 Sep 2015 10:44:33 -0700
Message-ID: <CAJqUr7zcv-09ZcNLQDSOj0A3zbv3vVwH1nnQ=2=H+MagCBCvBA@mail.gmail.com>
From: Don Mahurin <don@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] [pull request] xenomai/arm64: Use empty mayday
	implementation for arm64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The following changes since commit 17095784c6d3d44dc7f1512ffab9bb957e298466:

  cobalt/arm64: leave mm tracking to the pipeline (2015-09-17 15:08:34
+0200)

are available in the git repository at:

  http://gitlab.mperpetuo.com/it/xenomai-3.git arm64

for you to fetch changes up to 6f09555dcb047ed5d31138fd5a0b978b5fe76f65:

  cobalt/arm64: Use empty mayday implementation for arm64. (2015-09-17
10:33:03 -0700)

----------------------------------------------------------------

Don Mahurin (1):
      cobalt/arm64: Use empty mayday implementation for arm64.

 kernel/cobalt/arch/arm64/mayday.c | 86 +
---------------------------------------
1 file changed, 1 insertion(+), 85 deletions(-)
