Subject: Re: Some build issues with dovetail + ipipe 4.19
References: <VI1PR05MB591721033A800D11F012D853F68D9@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5c670c64-5460-a4e6-9f07-6dec20e06385@siemens.com>
Date: Wed, 10 Feb 2021 12:44:08 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB591721033A800D11F012D853F68D9@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 10.02.21 12:23, Lange Norbert via Xenomai wrote:
> Hello,
> 
> 
> By accident I built 4.19.152-cip37-x86-15 with the wip/dovetail branch. I understand that this should be supported one day?
> In the hope that this is of use for you, I get built following errors during the modpost step with this config:
> 
> ERROR: "__rtdm_nrtsig_execute" [drivers/xenomai/testing/xeno_switchtest.ko] undefined!
> ERROR: "__rtdm_nrtsig_execute" [drivers/xenomai/net/drivers/igb/rt_igb.ko] undefined!
> ERROR: "pipeline_read_wallclock" [drivers/xenomai/net/drivers/igb/rt_igb.ko] undefined!
> 

RTnet is off already in our CI for that reason, but switchtest I thought
would work. Anyway, all these need fixing.

Thanks for reporting,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

