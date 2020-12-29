Subject: Re: [DOVETAIL] now tracking v5.10
References: <87a6u8wxvh.fsf@xenomai.org>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5FEA8975.2090206@tj.kylinos.cn>+DBB08C56484FB96C
Date: Tue, 29 Dec 2020 09:42:13 +0800
MIME-Version: 1.0
In-Reply-To: <87a6u8wxvh.fsf@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org, "Chen, Hongzhan" <hongzhan.chen@intel.com>

Dear Philippe & Hongzhan,

I was trying to build xenomai3.2 and boot it in my desktop, here is what 
i did:

1, git clone -b dovetail/master git://git.evlproject.org/linux.evl.git
2, git clone -b hongzhan/dovetail 
https://github.com/hongzhanchen/xenomai.git
3, ./xenomai-hongzhan/scripts/prepare-kernel.sh --linux=linux-evl 
--arch=x86_64
4, make

I found there are a lot of ipipe_xxx function calls in xenomai code like 
ipipe_post_irq_root or IPIPE_NR_IRQS, which cause building failed.

As my understanding, dovetail is the replacement of ipipe, as a result, 
ipipe function calls should be replaced by dovetail function calls. Did 
i miss something or did something wrong?

BR

chensong

On 2020年12月20日 18:54, Philippe Gerum via Xenomai wrote:
>
> This is a heads up for people working on the Xenomai port to Dovetail:
> dovetail/master and evl/master are now tracking v5.10.
>
> The former dovetail/master tip based on v5.9 is tagged as
> "dovetail-v5.9" in the repository [1]. The final tag for the EVL core
> based on v5.9 is "v5.9-evl5".
>
> [1] git://git.evlproject.org/linux-evl.git
>



