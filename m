Message-ID: <53E47905.5070402@xenomai.org>
Date: Fri, 08 Aug 2014 09:15:17 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <AE39D2A4-ECC3-481B-AF3B-8A67FA23D2BF@tuebingen.mpg.de>
 <44BE6908-E639-421F-B556-E7B3871402CF@gmail.com>
 <67B7E374-C4D2-4F83-BA40-B289B15867B9@tuebingen.mpg.de>
 <53E3B5E3.3090006@xenomai.org> <oqtx5om90q.fsf@merlin.sez.to>
 <53E3CD23.5040909@xenomai.org> <53E3D084.2000506@tuebingen.mpg.de>
 <53E3D2FF.5000407@xenomai.org> <53E3D50D.7060701@tuebingen.mpg.de>
 <53E3D712.3070801@xenomai.org> <web-589558@tuebingen.mpg.de>
In-Reply-To: <web-589558@tuebingen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] real-time guarantee issues on xenomai 2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ludovic Righetti <ludovic.righetti@tuebingen.mpg.de>, Paul Janzen <pcj@xenomai.sez.to>, xenomai@xenomai.org

On 08/07/2014 10:47 PM, Ludovic Righetti wrote:
>  
>> Just for kicks, could you try this patch ? it does NOT fix anything,
>> only maybe papering over an issue we don't know about yet:
>>
> 
> I just tried it. the issue is not visible anymore.
> 

Ok, instead of this patch, please disable CONFIG_CONTEXT_TRACKING_FORCE
from your Kconfig, the issue should go away. Since 3.14 we switch this
option off automatically, as it is incompatible with interrupt
pipelining in many cases, and solely useful for debugging a very
specific portion of the kernel itself.

-- 
Philippe.

