Message-ID: <50C63303.407@xenomai.org>
Date: Mon, 10 Dec 2012 20:07:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: "\"\\\"\\\\\\\"\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"<bf6a998422f24fab874ae21fd0adb396@isir.upmc.fr>\"	\"<F74C5334-2EAF-4D8E-AE55-38BF37437EE6@mah.priv.at>\\\"\"	\"<50B8B7A8.2010800@xenomai.org>\\\"	\"\\\\\\\"<D5733E9B-1AA5-4C5F-A2E8-1346A11A7E4C@mah.priv.at>\\\\\\\\\\\\\\\"\\\\\\\"\\\"\"	\"<7563882586f5c36943667b067978e7ff@isir.upmc.fr>\\\"	<50BB69A4.8020401@xenomai.org>	\"<f4d725b0ea36a139107d61f00b627b47@isir.upmc.fr>\\\"\"
	<50BB7E6D.8080602@xenomai.org>"
	<54b68e5271dffe6add316e94480ffeb6@isir.upmc.fr>
	<5f186a473469646525a404ab3fbe4a62@isir.upmc.fr>
	<50BD043D.8080901@xenomai.org>
	<798d18aaa8af5d21590a2c2dacc2d400@isir.upmc.fr>
	<274ee8164e9384b2faf0dbe50bf890be@isir.upmc.fr>
	<50BE4F09.7060508@xenomai.org>
	<4f87d2b280543885c9cefc9b9d376fa9@isir.upmc.fr>
In-Reply-To: <4f87d2b280543885c9cefc9b9d376fa9@isir.upmc.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Compiling I-pipe patched kernel on beaglebone from
 Angstrom branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: WONG Sheng Chao <wong@isir.upmc.fr>
Cc: xenomai@xenomai.org

On 12/10/2012 07:08 PM, WONG Sheng Chao wrote:

>>>>> The first post was just fine. But two things:
>>>>> - we do not want the .config in the post patch
>>>>
>>>> I will redo the post patch without the .config file
>>>>
>>>>> - the post patch does not re-add the changes removed by the
>>>>> pre-patch in
>>>>> arch/arm/common/gic.c, which makes it look really suspicious.
>>>>
>>>> as for the arch/arm/common/gic.c, it did not exist in the original
>>>> vendor code (Angstrom). Since it did not exists, there were an 
>>>> error
>>>> when i ran the .prepare-kernel script. So what I did was copy the
>>>> arch/arm/common/gic.c from the vanilla linux kernel to my vender
>>>> code.
>>>> I did not modify the arch/arm/common/gic.c there after thus the 
>>>> post
>>>> patch does not do anything to it.
>>>>
>>>> Does that makes sense? or did I miss somethin
>>>
>>> I am sorry i made a mistake, the file i mentioned above is
>>> arch/arm/plat-mxc/gic.c
>>>
>>> As for arch/arm/common/gic.c, i pre-patch it to the
>>> vanilla-kernel-3.2.21.
>>>
>>> I don't quite understand, since I did not do any changes in this 
>>> file
>>> after i patch it with ipipe, so isn't it logical that the post-patch
>>> does not re-add since there is nothing to add?
>>
>>
>> If you did not modify it, then the pre-patch should not contain 
>> anything
>> with regard to that file. Could you give me the url to the vendor git
>> repository and the modified branch so that I can generate the patches
>> myself and compare ?
> 
> 
> Since I was using bitbake recipe to get the vendor source code, I 
> created my own git repository for the kernel source
> 
> https://github.com/shengchao/beaglebone-angstrom-xenomai
> 
> the master branch contains the original source from the vendor
> 
> and the xenomai branch is the one with pre-patch, ipipe_patch and 
> post_patch applied.


As I already said, what you should put under source control is the
I-pipe kernel, putting xenomai in the sources defeats the purpose of
having xenomai separated from the I-pipe patch.

-- 
                                                                Gilles.

