From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Thu, 27 Jun 2013 11:09:22 +0200
References: <201306260906.22955.leo@alaxarxa.net>
	<51CB231E.8030600@xenomai.org>
In-Reply-To: <51CB231E.8030600@xenomai.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201306271109.22749.leo@alaxarxa.net>
Subject: Re: [Xenomai] Xenomai warn_upon_switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

A Dimecres, 26 de juny de 2013, Gilles Chanteperdrix va escriure:
> On 06/26/2013 09:06 AM, Leopold Palomo-Avellaneda wrote:
> 
> > Hi,
> > 
> > since 2.6.x the Orocos users have difficulties (or simple cannot) use 
Xenomai. 
> > Despite of some bug in the Orocos code, xenomai emits a warn_upon_switch 
that 
> > makes the user to use a console program - deployer - (basically for the 
orocos 
> > philosofy) to launch rt programs.
> > 
> > I think that this signal must be treated in some way by the Orocos code, 
but 
> > it's not developed yet. Since then, there's a way to silent this signal, 
or 
> > simple that doesn't overflow the console but thousand of messages like 
this:
> 
> 
> In case it is a bug which has already been fixed, could you try xenomai
> 2.6 git?

I don't understand that it could be a Xenomai bug. It's a Orocos bug IMHO. In 
the orocos list they commented that:

>AFAICS you've enabled the warn_upon_switch signal, AFAIK the printouts all
>refer to code paths that are causing mode switches.


......
> Real-time memory: 517920 bytes free of 524288 allocated.
> /opt/orocos-toolchain/install/lib/liborocos-rtt-
> xenomai.so.2.6(warn_upon_switch+0x15)[0x7fda1b2fb295]
> /lib/x86_64-linux-gnu/libpthread.so.0(+0xf030)[0x7fda19bdd030]
> /usr/lib/libnative.so.3(rt_mutex_release+0xbb)[0x7fda19ff431b]
> /opt/orocos-toolchain/install/lib/liborocos-rtt-
> xenomai.so.2.6(_ZN3RTT2os6ThreadD1Ev+0x11d)[0x7fda1b2f730d]
> /opt/orocos-toolchain/install/lib/liborocos-rtt-
> xenomai.so.2.6(_ZN3RTT8ActivityD2Ev+0x37)[0x7fda1b2add27]
> /opt/orocos-toolchain/install/lib/liborocos-rtt-
> xenomai.so.2.6(_ZN3RTT8ActivityD0Ev+0x9)[0x7fda1b2add79]
> /opt/orocos-toolchain/install/lib/liborocos-rtt-
>
> 
xenomai.so.2.6(_ZN5boost10shared_ptrIN3RTT4base17ActivityInterfaceEEaSERKS4_+0x4e)
> [0x7fda1b2b9cde]
> /opt/orocos-toolchain/install/lib/liborocos-rtt-
>
> 
xenomai.so.2.6(_ZN3RTT11TaskContext11setActivityEPNS_4base17ActivityInterfaceE+0x72)
> [0x7fda1b2aecb2]
> /opt/orocos-toolchain/install/lib/liborocos-ocl-deployment-
> xenomai.so.2.6.0(_ZN3OCL19DeploymentComponent11setActivityERKSsdii+0x127)
> [0x7fda1a9f8997]
> /opt/orocos-toolchain/install/lib/liborocos-ocl-deployment-
>
> xenomai.so.2.6.0(_ZNK5boost9function4IbRKSsdiiEclES2_dii+0x18)
[0x7fda1aa4dd68]
> /opt/orocos-toolchain/install/lib/liborocos-ocl-deployment-
>

AAnd I don't know how to silent (or if is possible) this messages.

Regards,

Leo

-- 
--
Linux User 152692
Catalonia

