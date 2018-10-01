References: <0B8B4C90A6FEA34E9EA10570C016C358BB7D9D8A@DEMUC-SMX001.data-modul.local>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c371a628-edc2-0713-767b-80efac64833e@siemens.com>
Date: Mon, 1 Oct 2018 12:33:09 +0200
MIME-Version: 1.0
In-Reply-To: <0B8B4C90A6FEA34E9EA10570C016C358BB7D9D8A@DEMUC-SMX001.data-modul.local>
Content-Type: text/plain; charset=utf-8; format=flowed
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

On 01.10.18 12:10, Schrenkhammer, Martin wrote:
> Hi,
> 
> Do you already have a planned release date for ipipe-4.14?
> I am looking forward using xenomai on latest AMD V1000 platform. But it looks like it is not supported by ipipe-4.9

You are welcome to test already, see 
https://www.xenomai.org/pipermail/xenomai/2018-September/039617.html, and 
provide feedback here!

There is currently one open issue, see 
https://www.xenomai.org/pipermail/xenomai/2018-September/039614.html, but maybe 
that does not affect your workload. Also note that x86-32 is untested, probably 
broken. I'm considering to deprecate it, given that all modern CPUs come with 
64-bit support, and we have compat support in Xenomai for 32-bit userland.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

