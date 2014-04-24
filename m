Message-ID: <53593685.3010900@xenomai.org>
Date: Thu, 24 Apr 2014 18:06:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1WdM0c-0000RW-Gi@sd-51317.dedibox.fr>
In-Reply-To: <E1WdM0c-0000RW-Gi@sd-51317.dedibox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum : cobalt/kernel:
 generalize use of safe *snprintf()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, xenomai-git@xenomai.org

On 04/24/2014 05:56 PM, git repository hosting wrote:
> Module: xenomai-forge
> Branch: rtdm-api-waitqueues
> Commit: f8490220177c0c007ae98dac4a956ecd0de89120
> URL:    http://git.xenomai.org/?p=xenomai-forge.git;a=commit;h=f8490220177c0c007ae98dac4a956ecd0de89120
>
> Author: Philippe Gerum <rpm@xenomai.org>
> Date:   Thu Apr 17 11:44:08 2014 +0200
>
> cobalt/kernel: generalize use of safe *snprintf()
>
> Make sure to have the destination string null-terminated on character
> overflow.

snprintf already adds the null, systematically, even in case of overflow.

-- 
					    Gilles.

