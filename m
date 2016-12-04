Date: Sun, 4 Dec 2016 16:51:00 +0000 (UTC)
From: Giulio Moro <giuliomoro@yahoo.it>
Message-ID: <927861158.10199114.1480870260376@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <927861158.10199114.1480870260376.ref@mail.yahoo.com>
Subject: [Xenomai] cannot open autotune device / issue tracker
Reply-To: Giulio Moro <giuliomoro@yahoo.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

if you have compiled with 
CONFIG_XENO_OPT_AUTOTUNE=mthen when you run autotune you get 
./autotune: cannot open autotune device: No such file or directory

The error message is not very informative and should suggests `modprobe xeno_autotune`.

Is there an issue tracker somewhere?
What is the best way to submit patches?

