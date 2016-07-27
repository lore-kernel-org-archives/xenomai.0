References: <CAL7Yi3Q+zWjueMj84vxOv4J633nBe_JmENnW=Pi8e_nnwth-QA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4dd9bd1e-3fd3-4c70-aac6-be6e012738fc@xenomai.org>
Date: Wed, 27 Jul 2016 17:24:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAL7Yi3Q+zWjueMj84vxOv4J633nBe_JmENnW=Pi8e_nnwth-QA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai ported to ARMv8 NXP QorIQ SDK?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tracy Smith <tsmithdsc99@gmail.com>, Xenomai@xenomai.org

On 07/27/2016 04:23 PM, Tracy Smith wrote:
>  Has Xenomai been ported to ARMv8?  Or, in particular the NXP/Freescale
> QorIQ family of products SDK 1.0 or 2.0, for example the LS1021?
>

It has been ported to LS1021A already (over Linux 3.14 IIRC).

> We are using the LS1043 SDK 2.0, which is a new product and wanted to see
> if we could download, compile, and bring-up xenomai for evaluation
> alongside the 4.1.8 PREEMPT_RT kernel in the NXP SDK 2.0.   Or, will this
> require porting it over?
> 

This will require backporting the interrupt pipeline patch Xenomai uses
from mainline 4.1.18 to 4.1.8+rt, which will include a few easy fixups
for merging with -rt.

-- 
Philippe.

