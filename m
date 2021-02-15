Subject: Re: Where is <mercury/wrappers.h>?
References: <9b5a8f4bb2b90758bc94f4fa7c7d96a4c3a0040a.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8ccbb99e-c389-d172-b53d-ea073f9df46b@siemens.com>
Date: Mon, 15 Feb 2021 20:22:35 +0100
MIME-Version: 1.0
In-Reply-To: <9b5a8f4bb2b90758bc94f4fa7c7d96a4c3a0040a.camel@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 15.02.21 18:49, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> Hi all,
> 
> I'm currently inspecting the code base regarding Y2038 problem (=
> overflow of 32 bit time_t in January 2038) and trying to list /
> summarize all affected APIs / drivers / ...
> 
> In include/copperplate/wrappers.h we have:
> #include <mercury/wrappers.h>
> 
> I guess this is broken since
> 1fbf0f398064 ("lib/boilerplate: introduce ancillary service layer").
> Right?
> 

I would rather blame f058f3c2c12fa882e97aed931416c8a34e389767 here.

include/copperplate/wrapper.h, seems like dead code. It's not used in-
tree, and if someone tried it out-of-tree, we would have received 
complaints over the past 8 years.

> Background:
> I'm trying to find the right expansion for __RT() used by the alchemy
> library, e.g. in lib/alchemy/pipe.c. I found two possibilities so far:
> 
> - include/cobalt/wrappers.h

This one is in use, for cobalt.

> - include/mercury/boilerplate/wrappers.h

This one contains what is expected by include/copperplate/wrappers.h.

> 
> Which one is being used by the alchemy library? I was not able to find
> my way through all the include directories and include paths...
> 

Thanks for reporting. I suspect the quick fix would be

diff --git a/include/copperplate/wrappers.h b/include/copperplate/wrappers.h
index a7c68f5cb8..06b94b5e4c 100644
--- a/include/copperplate/wrappers.h
+++ b/include/copperplate/wrappers.h
@@ -24,7 +24,7 @@
 #ifdef CONFIG_XENO_COBALT
 #include <cobalt/wrappers.h>
 #else /* CONFIG_XENO_MERCURY */
-#include <mercury/wrappers.h>
+#include <mercury/boilerplate/wrappers.h>
 #endif /* CONFIG_XENO_MERCURY */
 
 #endif /* _COPPERPLATE_WRAPPERS_H */


But that won't change the fact that this header is likely unused, thus
untested.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

