From: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Message-ID: <d2ae02b5-5df7-5d84-dc79-c491897e30a9@mperpetuo.com>
Date: Thu, 9 Feb 2017 14:27:09 -1000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Build error with XENO_OPT_DEBUG=y
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I've noticed that if I have XENO_OPT_DEBUG=y and XENO_OPT_DEBUG_LOCKING=n, 
I get build errors with an undefined reference to `xnlock_stats'.

In the Kconfig, XENO_OPT_DEBUG_LOCKING is enabled by default for SMP and 
XENO_OPT_DEBUG, but there is no hard dependency.

The use case here is if I want to debug something else and don't want to 
incur the overhead of lock debugging.

This looks like a bug to me, and I just want to confirm that.

Thanks,
Dmitriy

