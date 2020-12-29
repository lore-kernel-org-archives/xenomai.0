Subject: Re: [DOVETAIL] now tracking v5.10
References: <87a6u8wxvh.fsf@xenomai.org> <5FEA8975.2090206@tj.kylinos.cn>
 <MWHPR11MB171051333F4AA84264B750BAF2D80@MWHPR11MB1710.namprd11.prod.outlook.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5FEAAAED.3080802@tj.kylinos.cn>+9DAAE038B3EA8121
Date: Tue, 29 Dec 2020 12:05:01 +0800
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB171051333F4AA84264B750BAF2D80@MWHPR11MB1710.namprd11.prod.outlook.com>
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Great, many thanks, i will give it a try.

BR

chensong

On 2020年12月29日 11:06, Chen, Hongzhan wrote:
> Hi chensong
>
> Let us switch to and focus on CXP. Actually  https://github.com/hongzhanchen/xenomai.git is
> not based on https://lab.xenomai.org/xenomai-rpm.git/log/?h=for-upstream/dovetail which
> is base of CXP per my understanding. So Please forget it.
>
> If you want to work on CXP and start related development and experience porting, maybe
> https://github.com/hongzhanchen/xenomai-rpm/tree/dovetail/cxp is initial one. It is my own work
> branch which I have integrated all patches from https://gitlab.denx.de/Xenomai/xenomai/-/tree/wip/dovetail
> including Jan's patches and mine but it is still under development.
>
> You can follow following steps to build it.
>
> 1. git clone -b dovetail/master git://git.evlproject.org/linux.evl.git
> 2. git clone -b dovetail/cxp https://github.com/hongzhanchen/xenomai-rpm.git
> 3. ./scripts/prepare-kernel.sh --linux=your_path --arch=x86 --dovetail=0001-null-patch.patch
> 4. cp hang-in-usleep_range.config .confg
is hang-in-usleep_range.config available in 
https://github.com/hongzhanchen/xenomai-rpm.git?

> 5.make bzImage -j8
>
> In addition , you can create your own 0001-null-patch.patch to work around script .
> Following is mine.
>
> diff --git a/NULL.txt b/NULL.txt
> new file mode 100644
> index 000000000000..7951defec192
> --- /dev/null
> +++ b/NULL.txt
> @@ -0,0 +1 @@
> +NULL
> --
> 2.17.1
>
> Regards
>
> Hongzhan Chen
>
>
> -----Original Message-----
> From: chensong <chensong@tj.kylinos.cn>
> Sent: Tuesday, December 29, 2020 9:42 AM
> To: Philippe Gerum <rpm@xenomai.org>; xenomai@xenomai.org; Chen, Hongzhan <hongzhan.chen@intel.com>
> Subject: Re: [DOVETAIL] now tracking v5.10
>
> Dear Philippe & Hongzhan,
>
> I was trying to build xenomai3.2 and boot it in my desktop, here is what
> i did:
>
> 1, git clone -b dovetail/master git://git.evlproject.org/linux.evl.git
> 2, git clone -b hongzhan/dovetail
> https://github.com/hongzhanchen/xenomai.git
> 3, ./xenomai-hongzhan/scripts/prepare-kernel.sh --linux=linux-evl
> --arch=x86_64
> 4, make
>
> I found there are a lot of ipipe_xxx function calls in xenomai code like
> ipipe_post_irq_root or IPIPE_NR_IRQS, which cause building failed.
>
> As my understanding, dovetail is the replacement of ipipe, as a result,
> ipipe function calls should be replaced by dovetail function calls. Did
> i miss something or did something wrong?
>
> BR
>
> chensong
>
> On 2020年12月20日 18:54, Philippe Gerum via Xenomai wrote:
>>
>> This is a heads up for people working on the Xenomai port to Dovetail:
>> dovetail/master and evl/master are now tracking v5.10.
>>
>> The former dovetail/master tip based on v5.9 is tagged as
>> "dovetail-v5.9" in the repository [1]. The final tag for the EVL core
>> based on v5.9 is "v5.9-evl5".
>>
>> [1] git://git.evlproject.org/linux-evl.git
>>
>
>



