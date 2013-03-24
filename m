Message-ID: <514F79C2.6080807@xenomai.org>
Date: Sun, 24 Mar 2013 23:10:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPRNvtSqfrtXW1L=W6_OTtenk+YyR_RWbPjrwRXYqEwN00P1rQ@mail.gmail.com>
In-Reply-To: <CAPRNvtSqfrtXW1L=W6_OTtenk+YyR_RWbPjrwRXYqEwN00P1rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] CAN bus on beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Davide Faconti <faconti@icarustechnology.com>
Cc: xenomai@xenomai.org

On 03/24/2013 11:01 PM, Davide Faconti wrote:

>> Socket: Protocol not supported
> 
> Is there anyone that as any idea of what is going on and how I could
> fix it?


Hi,

could you try the following patch?

diff --git a/src/skins/posix/rtdm.c b/src/skins/posix/rtdm.c
index aa23737..c6326f0 100644
--- a/src/skins/posix/rtdm.c
+++ b/src/skins/posix/rtdm.c
@@ -87,7 +87,7 @@ int __wrap_socket(int protocol_family, int socket_type, int protocol)
 				protocol_family, socket_type, protocol);
 	if (ret >= 0)
 		ret += __pse51_rtdm_fd_start;
-	else if (ret == -EAFNOSUPPORT || ret == -ENOSYS) {
+	else if (ret == -EAFNOSUPPORT || ret == -EPROTONOSUPPORT || ret == -ENOSYS) {
 		ret = __real_socket(protocol_family, socket_type, protocol);
 
 		if (ret >= __pse51_rtdm_fd_start) {

You need to recompile xenomai user-space support after
applying it.

Regards.

-- 
                                                                Gilles.

