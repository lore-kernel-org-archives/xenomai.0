References: <0B8B4C90A6FEA34E9EA10570C016C358BB7D9D8A@DEMUC-SMX001.data-modul.local>
 <c371a628-edc2-0713-767b-80efac64833e@siemens.com>
 <0B8B4C90A6FEA34E9EA10570C016C358BB7DA2CC@DEMUC-SMX001.data-modul.local>
 <0c0a94e6-6650-88e2-7b89-3b6fa92efa65@siemens.com>
 <0B8B4C90A6FEA34E9EA10570C016C358BB7DA73C@DEMUC-SMX001.data-modul.local>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <52b6df12-fbb5-871a-7c4c-5208e7e04978@siemens.com>
Date: Thu, 11 Oct 2018 14:23:11 +0200
MIME-Version: 1.0
In-Reply-To: <0B8B4C90A6FEA34E9EA10570C016C358BB7DA73C@DEMUC-SMX001.data-modul.local>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe-4.14: planned release date
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Schrenkhammer, Martin" <MSchrenkhammer@data-modul.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11.10.18 11:21, Schrenkhammer, Martin wrote:
> Thanks for your reply.
> Checked again today with your latest commit 20db5ea2eee38b123c9641003fe55c895a1fd514 with same errors.
> I wanted to run a first build without modifications (beside prepare-kernel.sh and make menuconfig to append a local version.
> Maybe you can send my your actual x86 config and I can check differences and adopt to my platform.
> Mine .config is enclosed.

Reproduced: The actual problem is related to CONFIG_HYPERV which selects 
CONFIG_PARAVIRT which conflicts with CONFIG_IPIPE.

Furthermore, you want to disable CONFIG_SCHED_MC so that you can also turn off 
the power management features Xenomai complains about.

And then there is CONFIG_TRANSPARENT_HUGEPAGE and CONFIG_CMA. When both are off, 
you can also disable COMPACTION and MIGRATION.

In general, it's not optimal to start from a distro config without further tuning.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

