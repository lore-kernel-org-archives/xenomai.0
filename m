Subject: Re: [Xenomai] [PATCH] cobalt: fcntl uses void* instead of int
References: <20181016103450.3189-1-norbert.lange@andritz.com>
 <457aa74c-8fde-8e95-3065-41d41de0a15e@xenomai.org>
 <d62437da1905437abadb9c24fa9384eb@andritz.com>
 <b8fc3972-99be-eee3-1779-8f1927710ef0@xenomai.org>
 <d0f48a1c927646b489a6ef5b78146305@andritz.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f8aca114-0f8e-4aef-d193-5d13acc1b3d7@xenomai.org>
Date: Wed, 5 Dec 2018 16:30:30 +0100
MIME-Version: 1.0
In-Reply-To: <d0f48a1c927646b489a6ef5b78146305@andritz.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12/4/18 4:51 PM, Lange Norbert wrote:
> To close this up,
> 
> is there anything expected from my side? I am not able to fix up the kernel side, esp. with the x32 API,
> and my disagreement with long vs void*/uintptr_t likely won't end up getting us anywhere.
> 

The kernel patch is on its way. Contributing the userland changes would
help.

-- 
Philippe.

