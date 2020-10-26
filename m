Date: Mon, 26 Oct 2020 16:12:39 +0800
From: Fino Meng <fino.meng@linux.intel.com>
Subject: Re: build scripts for the WIP xenomai porting to kernel 5.4
Message-ID: <20201026081238.GA17437@linux.intel.com>
References: <9153481d-6df6-314f-c2c0-f413a34fb815@siemens.com>
 <20201021114329.GA4344@linux.intel.com>
 <88232cd0-0713-4e45-bad2-e22acdeb7632@siemens.com>
 <3a85c6c8-6792-40d1-5ef2-6ee634fc3c91@siemens.com>
 <20201022114938.GA8098@linux.intel.com>
 <39ccbc86-3f64-0941-241b-30e2431468cf@siemens.com>
 <20201022132522.GA9776@linux.intel.com>
 <ae889a3f-40c1-d22e-c97b-807fe2ab7b5f@siemens.com>
 <20201023090407.GA16088@linux.intel.com>
 <6ca34337-dd2f-3727-a014-f76d6721a647@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ca34337-dd2f-3727-a014-f76d6721a647@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Mon, Oct 26, 2020 at 08:35:10AM +0100, Jan Kiszka wrote:
> On 23.10.20 11:04, Fino Meng wrote:
> > be aware of RTNET and RTIPC part still have compile error, I didn't
> > enable them in .config yet. hope can fix them next week.
> 
> Do you have patches for RTnet and Analogy already? RTIPC is fixed in
> next. I'm currently trying to get CI fully running.
> 
> Jan

this morning, I didn't meet error when compile RTnet as module, strange.
for Analogy I didn't try yet, will try it today.

Happy to know RTIPC is done, I was checking it's code and make it pass compile like this:

diff --git a/kernel/drivers/ipc/bufp.c b/kernel/drivers/ipc/bufp.c
index 45c917eb0..024f8f2f1 100644
--- a/kernel/drivers/ipc/bufp.c
+++ b/kernel/drivers/ipc/bufp.c
@@ -830,14 +830,16 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
        if (sopt.level == SOL_SOCKET) {
                switch (sopt.optname) {

-               case SO_RCVTIMEO:
+               case SO_RCVTIMEO_OLD:
+               case SO_RCVTIMEO_NEW:
                        ret = rtipc_get_timeval(fd, &tv, sopt.optval, sopt.optlen);
                        if (ret)
                                return ret;
                        sk->rx_timeout = rtipc_timeval_to_ns(&tv);
                        break;

-               case SO_SNDTIMEO:
+               case SO_SNDTIMEO_OLD:
+               case SO_SNDTIMEO_NEW:
                        ret = rtipc_get_timeval(fd, &tv, sopt.optval, sopt.optlen);
                        if (ret)
                                return ret;
@@ -922,14 +924,16 @@ static int __bufp_getsockopt(struct bufp_socket *sk,
        if (sopt.level == SOL_SOCKET) {
                switch (sopt.optname) {

-               case SO_RCVTIMEO:
+               case SO_RCVTIMEO_OLD:
+               case SO_RCVTIMEO_NEW:
                        rtipc_ns_to_timeval(&tv, sk->rx_timeout);
                        ret = rtipc_put_timeval(fd, sopt.optval, &tv, len);
                        if (ret)
                                return ret;
                        break;

-               case SO_SNDTIMEO:
+               case SO_SNDTIMEO_OLD:
+               case SO_SNDTIMEO_NEW:
                        rtipc_ns_to_timeval(&tv, sk->tx_timeout);
                        ret = rtipc_put_timeval(fd, sopt.optval, &tv, len);
                        if (ret)
diff --git a/kernel/drivers/ipc/iddp.c b/kernel/drivers/ipc/iddp.c
index 2a80eba65..c926b32ac 100644
--- a/kernel/drivers/ipc/iddp.c
+++ b/kernel/drivers/ipc/iddp.c
@@ -712,14 +712,16 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
        if (sopt.level == SOL_SOCKET) {
                switch (sopt.optname) {

-               case SO_RCVTIMEO:
+               case SO_RCVTIMEO_OLD:
+               case SO_RCVTIMEO_NEW:
                        ret = rtipc_get_timeval(fd, &tv, sopt.optval, sopt.optlen);


I also tested hackbench:

while true ; do sudo taskset -c 1 hackbench -s 512 -l 200 -g 20 -f 50 -P ; done

it output errors, but the board is still alive. 


BR fino

> -- 
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux

