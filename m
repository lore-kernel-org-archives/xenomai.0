Subject: Re: xenomai.supported_cpus not working as intended?
References: <VI1PR05MB591724DFD45C58A897803F95F6600@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2d3027e0-83d7-0e98-8c2b-7b7bf06cadb3@siemens.com>
Date: Mon, 13 Jul 2020 19:52:20 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB591724DFD45C58A897803F95F6600@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 13.07.20 15:37, Lange Norbert via Xenomai wrote:
> Hello,
> 
> I am using Xenomai 3.1 and I tried once more to tie Linux to Core0, and RT to the remaining Cores.
> It seems that both Linux and Xenomai favor Core0, as rtnet-stack rtnet-rtpc seem to always run on that.
> Network drivers will process the IRQs on all cores, but realistally all are handles at Core0.
> 
> I tries the commandline xenomai.supported_cpus=0xFFFE, but this doesn’t seem to work right.
> 
> I get stuck Xenomai processes, and entries in dmesg (both with and without the isolcpus parameter).
> Kernel cmdline is like this: irqaffinity=0 xenomai.smi=disabled isolcpus=1-3 xenomai.supported_cpus=0xFFFE
> 
> Running a Xenomai Process looks like this:
> 
> # /usr/xenomai/bin/clocktest
> [  191.759690] [Xenomai] thread clocktest[575] switched to non-rt CPU0, aborted.
> == Testing built-in CLOCK_REALTIME (0)
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>    0                  0.0            0.000          0            0.0
>    1           -1450249.3          -36.240          0            0.0
>    2           -1450249.8          -36.040          0            0.0
>    3           -1450249.4          -35.292          0            0.0
> 
> And similar stuff happens when booting, Kernel dmesg is following.
> 
> So I don’t see how xenomai.supported_cpus can be safely used,
> It more or less works by chance for me (processes not getting stuck)

IIRC, we had troubles with starting off RTDM kernel tasks (like RTnet 
uses) when supported_cpus is used. There is no good control over where a 
kernel task comes up, specifically when it started by a built-in driver.

Or are you seeing issues even without RTnet in the picture?

cpus_supported is one of those "would be nice but usually broken when 
needed" feature because we do not consistently test it.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

