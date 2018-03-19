References: <6aedc4bc-74b5-4a9f-5c38-036a3d7850b9@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <bae60b94-363c-f1ff-9cee-ea0aed5ff7c7@xenomai.org>
Date: Mon, 19 Mar 2018 17:45:59 +0100
MIME-Version: 1.0
In-Reply-To: <6aedc4bc-74b5-4a9f-5c38-036a3d7850b9@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL] ipipe 4.4 updates
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 03/09/2018 05:51 PM, Jan Kiszka wrote:
> The following changes since commit 5618f90d33b17ab0ee9352705610a5e9f00f9964:
> 
>   Revert "ipipe: printk: defer dev_printk() output to safe context" (2017-12-15 18:10:01 +0100)
> 
> are available in the git repository at:
> 
>   git://git.xenomai.org/ipipe-jki for-upstream/4.4-update
> 
> for you to fetch changes up to c6de6878f74e4b079066eddc373f3e8c125fdaa7:
> 
>   Merge tag 'v4.4.120' into for-upstream/4.4-update (2018-03-08 18:49:28 +0100)
> 
> 
> I-pipe specific commits:
> 
> Jan Kiszka (5):
>       arm/ipipe: Avoid open-coded __ipipe_call_mayday

This one is useless, although it does not hurt. As a matter of fact,
__ipipe_exit_irq is only called from contexts running with hard IRQs
disabled, otherwise the pipeline core would be just fundamentally
broken. Merged it anyway.

>       x86/ipipe: Deny JUMP_LABEL over I-pipe
>       Merge tag 'v4.4.109' into for-upstream/4.4-update
>       x86/ipipe: Disable access_ok context under I-pipe
>       Merge tag 'v4.4.120' into for-upstream/4.4-update
> 

Merged, thanks.

-- 
Philippe.

