Date: Sun, 19 Jun 2016 08:45:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160619064531.GL18433@hermes.click-hack.org>
References: <5763C908.6010007@gmail.com>
 <20160617100728.GK32532@hermes.click-hack.org>
 <5763DEE9.1000801@gmail.com>
 <CABYaVQ3ehQpYsjfB7oQnfTUKXBs+RNR04G0gScJzciVNMeRArw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABYaVQ3ehQpYsjfB7oQnfTUKXBs+RNR04G0gScJzciVNMeRArw@mail.gmail.com>
Subject: Re: [Xenomai] need help to Xenomai Cobalt RTnet socket UDP recvfrom
 non blocking
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: laurent LEQUIEVRE <laurent.lequievre@gmail.com>
Cc: "laurent.lequievre" <laurent.lequievre@univ-bpclermont.fr>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Jun 17, 2016 at 03:04:54PM +0200, laurent LEQUIEVRE wrote:
> Hi Gilles,
> 
> It works fine with :
> int64_t timeout = 3e09;  // 3 seconds to test
> int return_ioctl = ioctl(udp_socket,RTNET_RTIOC_TIMEOUT,&timeout);
> 
> but it needed to add these 'includes' to compile :
> #include <asm/ioctl.h>
> #include <rtdm/rtdm.h>
> #define RTIOC_TYPE_NETWORK      RTDM_CLASS_NETWORK
> #define RTNET_RTIOC_TIMEOUT     _IOW(RTIOC_TYPE_NETWORK,  0x11, int64_t)
> 
> I read in the documentation that rtnet is included in xenomai 3, why there
> is no rtnet.h file installed with the xenomai include files 

I simply forgot that part. I have used the headers for programs in
Xenomai sources only, where the headers are available. This needs a
cleanup, as the headers mix kernel and user declarations, and in
3.x, the RTDM drivers headers no longer start with rt. So rtnet.h
would probably become rtdm/net.h, and some part of it would have to
move to rtdm/uapi/net.h.

-- 
					    Gilles.
https://click-hack.org

