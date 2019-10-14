From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 0/1] add commit sha to kernel build 
Date: Mon, 14 Oct 2019 15:28:39 +0200
Message-Id: <20191014132840.27249-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <a4c48259-2ffc-0bf9-d545-cacde8672bac@siemens.com>
References: <a4c48259-2ffc-0bf9-d545-cacde8672bac@siemens.com>
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

We could add somthing like this to the kernel build. 

Quirin Gylstorff (1):
  kernel/linux: Add git commit sha to build

 recipes-kernel/linux/linux-xenomai.inc | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.20.1


